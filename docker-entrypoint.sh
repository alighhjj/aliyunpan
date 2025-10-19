#!/bin/sh
set -e

# Setup X11 forwarding if host display is available
if [ -n "$DISPLAY" ]; then
    export DISPLAY=$DISPLAY
else
    # If no display is provided, set up virtual display
    export DISPLAY=:0
fi

echo "Starting X11 Virtual Frame Buffer..."
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &

echo "Starting window manager..."
fluxbox &

echo "Starting VNC server..."
x11vnc -display :0 -bg -o /tmp/x11vnc.log -localhost -listen 0.0.0.0 -rfbport 5900 -xkb -ncache 10 -ncache_cr &

# Wait a bit for X server to start
sleep 3

# Change to app directory
cd /app

echo "Starting AliyunPan application..."
exec "$@"