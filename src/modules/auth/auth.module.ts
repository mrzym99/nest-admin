import { forwardRef, Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UserModule } from '../user/user.module';
import { TokenService } from './services/token.service';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtStrategy } from './strategies/jwt.strategy';
import { LogModule } from '../system/monitor/log/log.module';
import {
  AllConfigKeyAndPath,
  ISecurityConfig,
  securityRegToken,
} from '~/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AccessTokenEntity } from './entities/access-token.entity';
import { MenuModule } from '../system/menu/menu.module';
import { RoleModule } from '../system/role/role.module';
import { AccountController } from './controllers/account.controller';
import { CaptchaController } from './controllers/captcha.controller';
import { CaptchaService } from './services/captcha.service';
import { MailModule } from '../tools/mail/mail.module';
import { EmailController } from './controllers/email.controller';
import { OnlineModule } from '../system/monitor/online/online.module';

const controllers = [
  AuthController,
  AccountController,
  CaptchaController,
  EmailController,
];
const providers = [AuthService, TokenService, CaptchaService];

const strategies = [JwtStrategy];

@Module({
  imports: [
    TypeOrmModule.forFeature([AccessTokenEntity]),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService<AllConfigKeyAndPath>) => {
        const { jwtSecret, jwtExpire } =
          configService.get<ISecurityConfig>(securityRegToken);

        return {
          secret: jwtSecret,
          signOptions: {
            expiresIn: `${jwtExpire}s`,
          },
        };
      },
      inject: [ConfigService],
    }),
    MailModule,
    UserModule,
    RoleModule,
    MenuModule,
    LogModule,
    OnlineModule,
  ],
  controllers: [...controllers],
  providers: [...providers, ...strategies],
  exports: [TypeOrmModule, JwtModule, ...providers],
})
export class AuthModule {}
