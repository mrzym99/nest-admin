import { HttpException, HttpStatus, Inject, Injectable } from '@nestjs/common';
import { IThirdLoginConfig, ThirdLoginConfig } from '~/config';
import { HttpService } from '@nestjs/axios';
import { UserService } from '~/modules/user/user.service';
import { BusinessException } from '~/common/exceptions/biz.exception';
import { ErrorEnum } from '~/constants/error.constant';
import { AuthService } from '../auth.service';
import { UserCreateDto } from '~/modules/user/dto/user.dto';
import * as argon2 from 'argon2';
import { ThirdLoginDto, ThirdLoginType } from '../dto/third-login.dto';
import * as https from 'https'
import { isDev } from '~/utils';

// 创建使用系统根证书的 Agent 生产环境记得配置 https
const secureAgent = new https.Agent({
  rejectUnauthorized: isDev ? false : true
});

@Injectable()
export class ThirdLoginService {
  constructor(
    @Inject(ThirdLoginConfig.KEY)
    private readonly thirdLoginconfig: IThirdLoginConfig,
    private readonly http: HttpService,
    private readonly userService: UserService,
    private readonly authService: AuthService,
  ) { }

  /**
   * 获取第三方登录地址
   * @param type
   * @returns
   */
  async returnUrl(type: ThirdLoginType): Promise<string> {
    let url = '';
    switch (type) {
      case 'github':
        const { githubClientId, githubCallBackUrl } = this.thirdLoginconfig;
        const githubUrl = `https://github.com/login/oauth/authorize`;
        url = `${githubUrl}?client_id=${githubClientId}&redirect_uri=${githubCallBackUrl}`;
        break;
    }

    return url;
  }

  /**
   * 根据三方登录返回的code 获取token和token_type
   * @param type
   * @param code
   * @returns
   */
  async getTokenAndTokenType(type: ThirdLoginType, code: string) {
    let access_token, token_type;
    switch (type) {
      case 'github':
        const { githubClientId, githubSecret } = this.thirdLoginconfig;
        const githubUrl = `https://github.com/login/oauth/access_token`;
        const params = {
          client_id: githubClientId,
          client_secret: githubSecret,
          code,
        };

        const { data } = await this.http.axiosRef.get(githubUrl, {
          httpsAgent: secureAgent,
          params
        });
        const urlParams = new URLSearchParams(data);
        access_token = urlParams.get('access_token');
        token_type = urlParams.get('token_type');
        const error = urlParams.get('error');
        

        // 判断错误，有错误直接 throw
        if (error) {
          throw new HttpException(error, HttpStatus.BAD_REQUEST);
        }
    }

    return { access_token, token_type };
  }

  /**
   * 三方登录
   * @param type
   * @param token_type
   * @param access_token
   * @param ip
   * @param userAgent
   * @param password
   */
  async login(
    dto: ThirdLoginDto,
    ip: string,
    userAgent: string,
  ) {
    let result = null
    const { type, password, uniqueId } = dto
    switch (type) {
      case 'github':
        if (password) {
          result = await this.registerUserByGithubToken(
            dto,
            ip,
            userAgent,
          );
        } else {
          result = await this.loginUserByGithubToken(type, uniqueId, ip, userAgent);
        }
        break;
    }

    return result;
  }

  // 判断此github用户是否已经注册
  async hasRegistered(type: ThirdLoginType, tokenType: string, token: string) {
    let result = {
      userInfo: null,
      githubUserInfo: null
    }
    switch (type) {
      case 'github':
        try {
          const { data } = await this.http.axiosRef.get(
            `https://api.github.com/user`,
            {
              headers: {
                Accept: 'application/json',
                Authorization: `${tokenType} ${token}`,
              },
              httpsAgent: secureAgent,
              timeout: 10000,
            },
          );
          result.githubUserInfo = data;
          const { id } = data;
          const user = await this.userService.findUserInfoByUniqueId(type, id);
          result.userInfo = user;
        } catch (error) {
          console.log(error);
          throw new BusinessException(ErrorEnum.AUTH_CANNOT_LOGIN);
        }
        break;
    }
    return result;
  }

  /**
   * 如果 用户已经注册，则直接登录 三方登录
   * @param email
   * @param ip
   * @param userAgent
   * @returns { access_token }
   */
  async loginUserByGithubToken(
    type: string,
    uniqueId: number,
    ip: string,
    userAgent: string,
  ) {

    let result = null;
    switch (type) {
      case 'github':
        try {
          const user = await this.userService.findUserInfoByUniqueId(type, uniqueId);
          result = await this.authService.loginDetails(user.id, ip, userAgent);
        } catch (error) {
          console.log(error);
          throw new BusinessException(ErrorEnum.AUTH_CANNOT_LOGIN);
        }
        break;
    }

    return result;
  }

  /**
   * 注册用户 再登录
   * @param token
   * @param tokenType
   */
  async registerUserByGithubToken(
    dto: ThirdLoginDto,
    ip: string,
    userAgent: string,
  ) {

    let result = null
    const { type, username, avatar, address, from, uniqueId, nickName, password } = dto
    switch (type) {
      case 'github':
        try {

          // 校验三方用户是否存在
          await this.userService.checkThirdUserExist(type, uniqueId)
          // 校验用户名和邮箱是否已经存在
          await this.userService.checkUserExist(username);

          const user: UserCreateDto = {
            username,
            avatar,
            password: '',
            from,
            uniqueId,
            address,
            nickName
          };
          user.password = await argon2.hash(password);

          await this.userService.create(user, false);

          const newUser = await this.userService.findUserInfoByUsername(username);

          result = await this.authService.loginDetails(newUser.id, ip, userAgent);
        } catch (error) {
          console.log(error);
          throw new BusinessException(ErrorEnum.AUTH_CANNOT_LOGIN);
        }
        break
    }

    return result;
  }
}
