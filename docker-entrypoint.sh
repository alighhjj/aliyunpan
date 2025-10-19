#!/bin/sh
set -e

# Ensure X11 directory exists with correct permissions
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Set up virtual display
export DISPLAY=:0

echo "Starting X11 Virtual Frame Buffer..."
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &
sleep 2

echo "Starting window manager..."
fluxbox &
sleep 1

echo "Starting VNC server..."
x11vnc -display :0 -bg -o /tmp/x11vnc.log -localhost -listen 0.0.0.0 -rfbport 5900 -xkb -ncache 10 -ncache_cr &
sleep 1

# Change to app directory
cd /app

echo "Starting AliyunPan application..."
exec pnpm dev