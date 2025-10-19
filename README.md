# 基于如下项目二次开发
https://github.com/gaozhangmin/aliyunpan

# 功能 [![](https://img.shields.io/badge/-%E5%8A%9F%E8%83%BD-blue)](#功能-)
1.根据阿里云盘Open平台api开发的网盘客户端，支持win7-11，macOS，linux <br>

2.支持同时登录多个账号管理。 <br>

3.提供特有的文件夹树，方便快速操作。 <br>

4.在线播放网盘中各种格式的高清原画视频，并支持外挂字幕、音轨和播放速度调整，播放列表。<br>

5.显示文件夹体积，支持文件夹和文件的混合排序（文件名/体积/时间）。<br>

6.可以通过远程Aria2功能将文件直接下载到远程的VPS/NAS。<br>

7.支持批量重命名大量文件和多层嵌套的文件夹。<br>

8.可以快速复制文件，预览视频的雪碧图，并直接删除文件。<br>

9.能够管理数万文件夹和数万文件，并一次性列出文件夹中的全部文件。<br>

10.支持一次性上传/下载百万级的文件/文件夹。<br>

<a href="#readme">
    <img src="https://img.shields.io/badge/-返回顶部-orange.svg" alt="#" align="right">
</a>


# 安装 [![](https://img.shields.io/badge/-%E5%AE%89%E8%A3%85-blue)](#安装-)

## Windows
> * ia32：64位x86架构的处理器
> * x64：Apple M1处理器版本
> * portable.exe 免安装版本

1. 在 [Latest Release](https://github.com/gaozhangmin/aliyunpan/releases/latest) 页面下载 `XBYDriver-Setup-*.exe` 的安装包
2. 下载完成后双击安装包进行安装
3. 如果提示不安全，可以点击 `更多信息` -> `仍要运行` 进行安装
4. 开始使用吧！


## MacOS
> * x64：64位x86架构的处理器
> * arm64：Apple M1处理器版本

1.  去 [Latest Release](https://github.com/gaozhangmin/aliyunpan/releases/latest) 页面下载对应芯片以 `.dmg` 的安装包（Apple Silicon机器请使用arm64版本，并注意执行下文`xattr`指令）
2.  下载完成后双击安装包进行安装，然后将 `小白羊` 拖动到 `Applications` 文件夹。
3.  开始使用吧！

## Linux
> * x64：64位x86架构的处理器
> * arm64：64位ARM架构的处理器。
> * armv7l：32位ARM架构的处理器。
### deb安装包
1.  去 [Latest Release](https://github.com/gaozhangmin/aliyunpan/releases/latest) 页面下载以 `.deb` 结尾的安装包
2.  执行`sudo dpkg -i XBYDriver-3.11.6-linux-amd64.deb`
### AppImage安装包
1.  去 [Latest Release](https://github.com/gaozhangmin/aliyunpan/releases/latest) 页面下载以 `.AppImage` 结尾的安装包
2.  chmod +x XBYDriver-3.11.6-linux-amd64.AppImage`
3.  下载完成后双击安装包进行安装。
4.  开始使用吧！

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

# 交流社区 [![](https://img.shields.io/badge/-%E4%BA%A4%E6%B5%81%E7%A4%BE%E5%8C%BA-blue)](#交流社区-)

#### Telegram
[![Telegram-group](https://img.shields.io/badge/Telegram-%E7%BE%A4%E7%BB%84-blue)](https://t.me/+wjdFeQ7ZNNE1NmM1)


# 鸣谢 [![](https://img.shields.io/badge/-%E9%B8%A3%E8%B0%A2-blue)](#鸣谢-)
本项目基于 https://github.com/liupan1890/aliyunpan 仓库继续开发。

感谢作者 [liupan1890](https://github.com/liupan1890)
<a href="#readme">
<img src="https://img.shields.io/badge/-返回顶部-orange.svg" alt="#" align="right">
</a>

# 免责声明 [![](https://img.shields.io/badge/-%E5%A3%B0%E6%98%8E-blue)](#免责声明-)
1.本程序为免费开源项目，旨在分享网盘文件，方便下载以及学习electron，使用时请遵守相关法律法规，请勿滥用；

2.本程序通过调用官方sdk/接口实现，无破坏官方接口行为；

3.本程序仅做302重定向/流量转发，不拦截、存储、篡改任何用户数据；

4.在使用本程序之前，你应了解并承担相应的风险，包括但不限于账号被ban，下载限速等，与本程序无关；

5.如有侵权，请通过邮件与我联系，会及时处理。
<a href="#readme">
<img src="https://img.shields.io/badge/-返回顶部-orange.svg" alt="#" align="right">
</a>
