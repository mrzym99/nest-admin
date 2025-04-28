<div align="center">
  <img src="./public/favicon.svg" width="100" />
  <h1>NestAdmin</h1>
  <span>中文 | <a href="./README.en_US.md">English</a></span>
</div>

---

[![license](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![gitee stars](https://gitee.com/mrzym/nest-admin/badge/star.svg)](https://github.com/mrzym99/nest-admin)
[![github stars](https://img.shields.io/github/stars/mrzym99/nest-admin)](https://github.com/mrzym99/nest-admin)
[![github forks](https://img.shields.io/github/forks/mrzym99/nest-admin)](https://github.com/mrzym99/nest-admin)

> [Gitee地址](https://github.com/mrzym99/nest-admin): https://github.com/mrzym99/nest-admin

> [Github地址](https://github.com/mrzym99/nest-admin): https://github.com/mrzym99/nest-admin

## 简介

[NestAdmin](https://github.com/mrzym99/nest-admin) 是一个简单高效的的后台管理系统，基于最新的前端技术栈，包括 Nestjs, TypeScript, TypeOrm, Mysql 和 Redis，底层可选express或fastify(master分支采用express、fastify分支采用fastify)。 适用于WEB全栈人员快速开发后台管理系统。NestAdmin 配套前端项目Vue3NaiveAdmin [前端地址传送门](https://github.com/mrzym99/vue3-naive-admin)

[项目文档](https://docs.mrzym.top)

## 在线体验

[在线体验](https://nest.mrzym.top)

## 基础功能

| 功能模块 | 功能描述 | 是否完成 | 备注 |
| --- | --- | --- |  --- | 
| 用户认证 | 用户注册、登录、验证码登录、退出登录、修改密码 | ✅ |
| 权限管理 | 基于角色的权限管理 | ✅ |
| 部门管理 | 管理组织架构中的部门信息 | ✅ |
| 岗位管理 | 管理岗位信息 | ❌ | 正在考虑做不做 |
| 角色管理 | 管理不同用户角色及其权限 | ✅ |
| 用户管理 | 管理用户信息及权限分配 | ✅ |
| 菜单管理 | 管理系统菜单及权限控制 | ✅ |
| 文件上传 | 支持文件上传功能 | ✅ |
| 邮件服务 | 发送邮件通知或验证码 | ✅ |
| 验证码服务 | 生成和验证验证码 | ✅ |
| 日志服务 | 记录系统操作日志 | ✅ |
| 定时任务 | 设置和管理定时任务 | ✅ |
| 数据字典 | 管理系统中常用的字典数据 | ✅ |
| 系统公告 | 发布和管理系统公告 | ✅ |
| 参数配置 | 系统参数的配置管理 | ✅ |
| 缓存管理 | 管理 Redis 缓存数据 | ✅ |
| 支付功能 | 支持支付宝沙箱支付(测试环境) 正式支付仅仅是修改参数即可 | ✅ |
| 第三方登录 | 支持 GitHub 第三方登录 | ✅ |



## 接口文档

Swagger文档： [Swagger](https://nest-server.mrzym.top:3366/docs)

Knife4j版： [Swagger-Knife4j](https://nest-server.mrzym.top:3366/doc.html)

## 使用

**环境准备**

确保你的环境满足以下要求：

- **git**: 你需要git来克隆和管理项目版本。
- **NodeJS**: >20，推荐 21.7.3 或更高。
- **pnpm**: >9，推荐 9.9.0 或更高。

**克隆项目**

```bash
git clone https://github.com/mrzym99/nest-admin.git
```

**导入sql文件**
sql文件: [nest_admin.sql](./sql/nest_admin.sql)

需要在本地mysql数据库中创建 nest_admin 数据库 并导入 nest_admin.sql

**环境配置**
配置文件内会有注释，主要是配置 mysql 、 redis，本地需要启动 mysql 和 redis

- [.env](./env) 基础配置
- [.env.development](./env.development) 开发环境配置
- [.env.production](./env.production) 生产环境配置

**安装依赖**

```bash
pnpm i
```

> 本项目使用 pnpm 管理依赖，如果你没有安装 pnpm，请先安装它(npm i pnpm -g)。

**启动项目**

```bash
pnpm run start:dev
```

运行起来后可以在项目日志内看到项目运行的地址和swagger文档地址

## Docker 构建

本项目使用了 Docker 来构建和运行项目。您可以通过以下步骤来构建和运行项目：

**环境要求**

您的环境必须满足以下要求：

- 含有稳定版本的 Docker 和 Docker Compose。

**注意事项**

docker-compose.yml 对应开发环境 dev，docker-compose.prod.yml对应生产环境 prod

1、构建项目

```
pnpm run docker:build:dev # 开发环境

pnpm run docker:build:prod # 生产环境
```

2、运行项目

``` 
pnpm run docker:up:dev # 开发环境

pnpm run docker:up:prod # 生产环境
```

3、停止和移除

```
pnpm run docker:down # 停止容器

pnpm run docker:down:v # 停止容器 并且删除数据卷(慎用，清理数据卷后，容器内保存的数据就没有了)
```

这些命令都是根据 `docker compose` 来进行编写的，只是将 `docker compose` 的命令写进了 `scripts` 里

[docker compose 命令大全](https://www.cnblogs.com/xyh9039/p/18540766)

如果遇到构建失败的情况，可能是因为您的Docker 环境存在问题。可以切换自己的Docker源地址，这里推荐 [阿里云镜像加速](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

还有一些镜像 如毫秒镜像等，可以问AI

## docker 常用命令

1、构建镜像

```
// 构建镜像 image_name 镜像名称 tag 版本
docker build -t <image_name>:<tag> .
eg: docker build -t nest-admin:v1 .
```

2、查看镜像

```
docker images
```

3、运行容器

```
docker run -d -p 3000:3000 --name my-app my-app:v1
// -p 3000:3000 表示 -p 表示端口 第一个 3000 表示宿主机(服务器)端口 第二个3000 表示容器内端口
```

4、 查看容器

```
docker ps
```

## docker compose 常用命令

```
docker-compose build：构建镜像。
docker-compose up：创建并启动容器。
docker-compose down：停止并删除容器、网络和卷（如果使用–v选项）。
docker-compose start：启动服务。
docker-compose stop：停止服务。
docker-compose restart：重启服务。
docker-compose logs：查看容器日志。
docker-compose ps：列出所有容器。
docker-compose config：检查docker-compose.yml文件的配置。
```

## docker 导出容器内的 数据库
```
1、进入容器
docker exec -it [容器名或ID] sh
2、导出 sql 到容器内
mysqldump -u root -p nest_admin > /opt/nest_admin.sql
3、导出 sql 到本地
docker cp [容器名或ID]:/opt/nest_admin.sql /opt/nest_admin.sql
```

## 交流

`NestAdmin` 是完全开源免费的项目，在帮助开发者更方便地进行中大型管理系统开发，同时也提供微信和 QQ 交流群，使用问题欢迎在群内提问。

<div>
  <p>QQ交流群</p>
  <img src="https://nest-image.mrzym.top/qrcode.jpg"  height="300" width="200" />
</div>

## 开源协议

项目基于 [MIT © 2025 Xiao Zhang](./LICENSE) 协议，仅供学习参考，商业使用请保留作者版权信息，作者不保证也不承担任何软件的使用风险。
