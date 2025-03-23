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

> [Github地址](https://github.com/mrzym99/vue3-naive-admin): https://github.com/mrzym99/vue3-naive-admin

## 简介

[NestAdmin](https://github.com/mrzym99/nest-admin) 是一个简单高效的的后台管理系统，基于最新的前端技术栈，包括 Nestjs, TypeScript, TypeOrm, Mysql 和 Redis。 适用于WEB全栈人员快速开发后台管理系统。NestAdmin 配套前端项目Vue3NaiveAdmin [前端地址传送门](https://github.com/mrzym99/vue3-naive-admin)

## 在线体验

[在线体验](https://nest.mrzym.top)

## 基础功能

- [x] 用户注册、登录
- [x] 基于角色的权限管理
- [x] 部门管理
- [x] 角色管理
- [x] 用户管理
- [x] 菜单管理
- [x] 文件上传
- [x] 邮件发送
- [x] 验证码
- [x] 日志服务
- [x] 定时任务
- [x] 数据字典

## 接口文档

Swagger文档： [Swagger](https://mrzym.top:3366/docs)

Knife4j版： [Swagger-Knife4j](https://mrzym.top:3366/doc.html)

## 使用

**环境准备**

确保你的环境满足以下要求：

- **git**: 你需要git来克隆和管理项目版本。
- **NodeJS**: >=18.12.0，推荐 18.19.0 或更高。
- **pnpm**: >= 8.7.0，推荐 8.14.0 或更高。

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
docker-compose build
```

2、运行项目

```
docker-compose up -d // (使用 -f [filename] 参数可以指定不同的 compose 文件 -d 表示后台运行，适用于服务器上构建后运行项目，退出终端容器不会停止运行)
```

3、停止和移除

```
docker-compose down 来停止和删除容器(删除容器数据请使用 -v 参数)。
```

[docker compose 命令大全](https://www.cnblogs.com/xyh9039/p/18540766)

如果遇到构建失败的情况，可能是因为您的Docker 环境存在问题。可以切换自己的Docker源地址，这里推荐 [阿里云镜像加速](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

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

## 交流

`NestAdmin` 是完全开源免费的项目，在帮助开发者更方便地进行中大型管理系统开发，同时也提供微信和 QQ 交流群，使用问题欢迎在群内提问。

<div>
  <p>QQ交流群</p>
  <img src="https://nest-image.mrzym.top/qrcode.jpg"  height="300" width="200" />
</div>

## 开源协议

项目基于 [MIT © 2025 Xiao Zhang](./LICENSE) 协议，仅供学习参考，商业使用请保留作者版权信息，作者不保证也不承担任何软件的使用风险。
