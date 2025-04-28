以下是将你提供的内容翻译成英文版本，同时保留了原文的结构和格式：

---

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

> [Gitee Address](https://github.com/mrzym99/nest-admin): <https://github.com/mrzym99/nest-admin> 

> [Github Address](https://github.com/mrzym99/nest-admin): <https://github.com/mrzym99/nest-admin> 

## Introduction

[NestAdmin](https://github.com/mrzym99/nest-admin) is a simple and efficient backend management system, based on the latest front-end technology stack, including Nestjs, TypeScript, TypeOrm, Mysql, and Redis. The underlying framework can be chosen between express or fastify (the master branch uses express, and the fastify branch uses fastify). It is suitable for full-stack developers to quickly develop backend management systems. NestAdmin is accompanied by the front-end project Vue3NaiveAdmin, which can be found at [Front-end Project Link](https://github.com/mrzym99/vue3-naive-admin).

[Project Documentation](https://docs.mrzym.top)

## Online Experience

[Online Demo](https://nest.mrzym.top)

## Basic Features

| Feature Module | Feature Description | Completion Status | Notes |
| --- | --- | --- | --- |
| User Authentication | User registration, login, verification code login, logout, password change | ✅ |
| Permission Management | Role-based permission management | ✅ |
| Department Management | Management of department information in the organizational structure | ✅ |
| Position Management | Management of position information | ❌ | Under consideration |
| Role Management | Management of user roles and their permissions | ✅ |
| User Management | Management of user information and permission allocation | ✅ |
| Menu Management | Management of system menus and permission control | ✅ |
| File Upload | Support for file upload functionality | ✅ |
| Email Service | Sending email notifications or verification codes | ✅ |
| Verification Code Service | Generation and verification of verification codes | ✅ |
| Log Service | Recording system operation logs | ✅ |
| Scheduled Tasks | Setting and managing scheduled tasks | ✅ |
| Data Dictionary | Management of commonly used dictionary data in the system | ✅ |
| System Announcements | Publishing and managing system announcements | ✅ |
| Parameter Configuration | Configuration management of system parameters | ✅ |
| Cache Management | Management of Redis cache data | ✅ |
| Payment Function | Support for Alipay sandbox payment (test environment); formal payment only requires parameter modification | ✅ |
| Third-Party Login | Support for GitHub third-party login | ✅ |

## API Documentation

Swagger Documentation: [Swagger](https://nest-server.mrzym.top:3366/docs)

Knife4j Version: [Swagger-Knife4j](https://nest-server.mrzym.top:3366/doc.html)

## Usage

**Environment Preparation**

Ensure your environment meets the following requirements:

- **git**: You need git to clone and manage project versions.
- **NodeJS**: >20, recommended version 21.7.3 or higher.
- **pnpm**: >9, recommended version 9.9.0 or higher.

**Clone the Project**

```bash
git clone https://github.com/mrzym99/nest-admin.git
```

**Import SQL File**

SQL file: [nest_admin.sql](./sql/nest_admin.sql)

You need to create a `nest_admin` database in your local MySQL database and import `nest_admin.sql`.

**Environment Configuration**

The configuration files contain comments, mainly for configuring MySQL and Redis. You need to have MySQL and Redis running locally.

- [.env](./env) Basic Configuration
- [.env.development](./env.development) Development Environment Configuration
- [.env.production](./env.production) Production Environment Configuration

**Install Dependencies**

```bash
pnpm i
```

> This project uses pnpm to manage dependencies. If you do not have pnpm installed, please install it first (`npm i pnpm -g`).

**Start the Project**

```bash
pnpm run start:dev
```

After running, you can see the project's running address and Swagger documentation address in the project logs.

## Docker Build

This project uses Docker to build and run the project. You can follow these steps to build and run the project:

**Environment Requirements**

Your environment must meet the following requirements:

- A stable version of Docker and Docker Compose.

**Notes**

- `docker-compose.yml` corresponds to the development environment (dev).
- `docker-compose.prod.yml` corresponds to the production environment (prod).

1. Build the Project

```bash
pnpm run docker:build:dev # Development Environment

pnpm run docker:build:prod # Production Environment
```

2. Run the Project

```bash
pnpm run docker:up:dev # Development Environment

pnpm run docker:up:prod # Production Environment
```

3. Stop and Remove

```bash
pnpm run docker:down # Stop containers

pnpm run docker:down:v # Stop containers and remove data volumes (use with caution, as removing data volumes will delete all data within the containers)
```

These commands are based on `docker compose` and are simply written into the `scripts` section.

[Docker Compose Command List](https://www.cnblogs.com/xyh9039/p/18540766)

If you encounter build failures, it may be due to issues with your Docker environment. You can switch your Docker mirror address. Here is a recommendation for [Alibaba Cloud Mirror Acceleration](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors).

You can also ask AI for other mirrors such as the millisecond mirror.

## Docker Common Commands

1. Build Image

```bash
// Build image with image_name as the image name and tag as the version
docker build -t <image_name>:<tag> .
eg: docker build -t nest-admin:v1 .
```

2. View Images

```bash
docker images
```

3. Run Container

```bash
docker run -d -p 3000:3000 --name my-app my-app:v1
// -p 3000:3000 indicates the port mapping, where the first 3000 is the host machine (server) port and the second 3000 is the container port
```

4. View Containers

```bash
docker ps
```

## Docker Compose Common Commands

```bash
docker-compose build: Build images.
docker-compose up: Create and start containers.
docker-compose down: Stop and remove containers, networks, and volumes (if using the --v option).
docker-compose start: Start services.
docker-compose stop: Stop services.
docker-compose restart: Restart services.
docker-compose logs: View container logs.
docker-compose ps: List all containers.
docker-compose config: Check the configuration of the docker-compose.yml file.
```

## Export Database from Docker Container

```bash
1. Enter the container
docker exec -it [container_name_or_ID] sh
2. Export SQL to the container
mysqldump -u root -p nest_admin > /opt/nest_admin.sql
3. Export SQL to the local machine
docker cp [container_name_or_ID]:/opt/nest_admin.sql /opt/nest_admin.sql
```

## Communication

`NestAdmin` is a completely open-source and free project, aimed at helping developers more conveniently develop medium and large-scale management systems. It also provides WeChat and QQ groups for communication. Feel free to ask questions in the group if you encounter any issues.

<div>
  <p>QQ Group</p>
  <img src="https://nest-image.mrzym.top/qrcode.jpg" height="300" width="200" />
</div>

## Open Source License

The project is licensed under the [MIT © 2025 Xiao Zhang](./LICENSE). It is for learning and reference only. For commercial use, please retain the author's copyright information. The author does not guarantee nor assume any risks associated with the use of the software.