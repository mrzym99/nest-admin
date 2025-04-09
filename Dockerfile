# 使用官方的 Node.js 运行时镜像作为基础镜像
FROM node:21.7.3-alpine


# 设置工作目录
WORKDIR /usr/src/app

# 安装 MySQL 客户端 用于解决 nest-admin容器内不能使用 mysql 命令 
# RUN apk add --no-cache mysql-client

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装项目依赖
RUN npm install pnpm -g
RUN pnpm config set registry https://registry.npmmirror.com
RUN pnpm install

# 复制项目文件
COPY . .

# 构建项目
RUN pnpm run build

# 暴露应用的端口
EXPOSE 3000

# 启动应用
CMD ["pnpm", "run", "start:prod"]