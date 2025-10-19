# AliyunPan (小白羊网盘) Docker 部署指南

我已成功为 AliyunPan 应用程序实现 Docker 支持。以下是 Docker 部署的详细说明：

## Docker 实现概述

Docker 设置包括：

1. **Dockerfile**：创建带以下功能的 AliyunPan 容器化版本：
   - 基础 Node.js 18 环境
   - Electron 应用所需的所有依赖项
   - 用于 GUI 支持的 X11 虚拟帧缓冲区 (Xvfb)
   - Fluxbox 窗口管理器
   - VNC 服务器以进行远程访问

2. **docker-compose.yml**：简化预配置服务的部署

3. **.dockerignore**：优化构建上下文

4. **文档**：添加到 README.md 中的使用说明

## 详细的 Docker 部署方法

### 方法 1：使用 Docker Compose（推荐）

1. **先决条件**：确保您已安装 Docker 和 Docker Compose

2. **克隆或导航到项目目录**：
   ```bash
   cd /path/to/aliyunpan
   ```

3. **构建并运行容器**：
   ```bash
   docker-compose up -d
   ```

4. **访问应用程序**：
   - Web 界面：[http://localhost:5173](http://localhost:5173)
   - VNC 界面：使用 VNC 客户端连接到 `localhost:5900`

5. **查看日志**（可选）：
   ```bash
   docker-compose logs -f
   ```

6. **停止容器**：
   ```bash
   docker-compose down
   ```

### 方法 2：手动 Docker 命令

1. **构建 Docker 镜像**：
   ```bash
   docker build -t aliyunpan .
   ```

2. **运行容器**（带数据持久化）：
   ```bash
   docker run -d \
     --name aliyunpan-container \
     -p 5173:5173 \
     -p 5900:5900 \
     -v ./data:/home/electron/.config \
     aliyunpan
   ```

3. **访问应用程序**：
   - Web 界面：[http://localhost:5173](http://localhost:5173)
   - VNC 界面：使用 VNC 客户端连接到 `localhost:5900`

4. **查看容器日志**：
   ```bash
   docker logs -f aliyunpan-container
   ```

5. **停止并删除容器**：
   ```bash
   docker stop aliyunpan-container
   docker rm aliyunpan-container
   ```

### 方法 3：使用 X11 转发（Linux 主机）

如果您想将 GUI 直接转发到您的 X11 显示：

1. **使用 X11 转发运行**：
   ```bash
   xhost +local:docker
   docker run -d \
     --name aliyunpan-gui \
     -e DISPLAY=$DISPLAY \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     -v ./data:/home/electron/.config \
     aliyunpan
   ```

## 端口映射

- **端口 5173**：Vite 开发服务器（Web 界面）
- **端口 5900**：VNC 服务器（远程桌面访问）

## 数据持久化

容器在 `/home/electron/.config` 中存储用户配置。挂载卷以持久化数据：

```bash
-v /path/to/local/data:/home/electron/.config
```

## Docker Compose 配置

`docker-compose.yml` 文件包括：

```yaml
version: '3.8'
services:
  aliyunpan:
    build: .
    container_name: aliyunpan
    ports:
      - "5173:5173"
      - "5900:5900"
    environment:
      - NODE_ENV=production
      - ELECTRON_DISABLE_SECURITY_WARNINGS=1
      - NODE_TLS_REJECT_UNAUTHORIZED=0
    volumes:
      - ./data:/home/electron/.config
    networks:
      - aliyunpan-net
    restart: unless-stopped
```

## 环境变量

- `NODE_ENV=production`：设置生产模式
- `ELECTRON_DISABLE_SECURITY_WARNINGS=1`：禁用 Electron 安全警告
- `NODE_TLS_REJECT_UNAUTHORIZED=0`：允许自签名证书

## VNC 访问

通过 VNC 访问应用程序：

1. 安装 VNC 客户端（如 TigerVNC Viewer、RealVNC 等）
2. 连接到 `localhost:5900`
3. 桌面将显示 AliyunPan 应用程序界面

## Web 界面访问

应用程序还在端口 5173 上运行 Web 服务器，可在 [http://localhost:5173](http://localhost:5173) 访问，提供相同的 Vue.js 前端。

## Dockerfile 架构

Dockerfile 使用多阶段方法：

1. **构建阶段**：安装依赖项并构建应用程序
2. **运行时阶段**：使用 Xvfb、Fluxbox 和 VNC 设置 GUI 环境

## 构建注意事项

- 构建过程可能需要几分钟，因为有 Electron 依赖项
- 确保您有充足的磁盘空间和内存
- 如果构建因网络问题失败，请重试或使用 VPN

## 故障排除

1. **容器启动失败**：使用 `docker logs <container_name>` 检查日志
2. **GUI 未出现**：确保 X11 转发配置正确
3. **VNC 连接失败**：验证端口 5900 是否可访问
4. **性能问题**：确保为 Docker 分配了足够的资源

## 安全说明

- VNC 服务器默认情况下不使用密码身份验证（用于本地使用）
- 用于生产部署，请考虑添加身份验证和 SSL
- 应用程序运行时禁用了安全警告以确保兼容性

此 Docker 实现允许 AliyunPan 桌面应用程序在容器化环境中运行，同时通过 VNC 或 Web 访问保留其 GUI 功能。