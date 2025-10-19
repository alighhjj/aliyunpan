# Docker部署 [![](https://img.shields.io/badge/-%E5%AE%B9%E5%99%A8%E9%83%A8%E7%BD%B2-blue)](#docker部署-)

## 使用Docker Compose (推荐)

1. 确保已安装 Docker 和 Docker Compose
2. 在项目根目录运行以下命令构建和启动容器：

```bash
docker-compose up -d
```

3. 访问应用:
   - Web界面: [http://localhost:5173](http://localhost:5173)
   - VNC界面: 使用VNC客户端连接 `localhost:5900`

## 手动构建Docker镜像

```bash
# 构建镜像
docker build -t aliyunpan .

# 运行容器
docker run -d -p 5173:5173 -p 5900:5900 --name aliyunpan-container aliyunpan
```

## 持久化数据

容器内的用户数据会存储在 `/home/electron/.config` 目录，可通过挂载卷来持久化:

```bash
docker run -d -p 5173:5173 -p 5900:5900 -v ./data:/home/electron/.config --name aliyunpan-container aliyunpan
```

## Docker配置说明

- 5173端口: Vite开发服务器
- 5900端口: VNC远程桌面访问
- 使用Xvfb虚拟显示缓冲区支持Electron GUI
- 包含fluxbox轻量级窗口管理器
- 包含x11vnc提供VNC服务

<a href="#readme">
    <img src="https://img.shields.io/badge/-返回顶部-orange.svg" alt="#" align="right">
</a>