# Dockerfile for AliyunPan (阿里云盘小白羊)
# This creates a containerized version of the application that can run in Docker
# For GUI access, use with X11 forwarding or VNC

FROM node:18-alpine

# Install system dependencies needed for Electron app and X11 support
RUN apk add --no-cache \
    git \
    curl \
    python3 \
    make \
    g++ \
    xdg-utils \
    libsecret \
    libnsl \
    libstdc++ \
    libx11 \
    libxcomposite \
    libxcursor \
    libxdamage \
    libxrandr \
    mesa-gbm \
    libxscrnsaver \
    libxtst \
    alsa-lib \
    libxkbfile \
    libxshmfence \
    libgudev \
    ttf-freefont \
    fontconfig \
    xvfb \
    fluxbox \
    x11vnc \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Install specific version of pnpm globally (as root)
RUN npm install -g pnpm@8.15.4 && \
    # Set correct permissions for the /app directory
    mkdir -p /app && \
    chown -R node:node /app

# Copy package files with correct ownership
COPY --chown=node:node package.json pnpm-lock.yaml ./

# Switch to node user for package installation
USER node

# Install dependencies and update lockfile
RUN pnpm config set store-dir /app/.pnpm-store && \
    pnpm install --no-frozen-lockfile

# Copy source code with correct ownership
COPY --chown=node:node . .

# Install electron-builder for building
RUN pnpm install electron-builder@^24.13.3 --save-dev

# Switch back to root for system setup
USER root

# Set up environment
ENV NODE_ENV=production \
    ELECTRON_DISABLE_SECURITY_WARNINGS=1 \
    NODE_TLS_REJECT_UNAUTHORIZED=0 \
    DISPLAY=:0

# Create X11 startup script and set permissions
RUN echo '#!/bin/sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &\n\
sleep 1\n\
fluxbox &\n\
sleep 1\n\
x11vnc -display :0 -bg -o /tmp/x11vnc.log -localhost -listen 0.0.0.0 -rfbport 5900 -xkb -ncache 10 -ncache_cr &\n\
sleep 1\n\
exec "$@"' > /startup.sh && \
    chmod +x /startup.sh

# Copy and set up entrypoint script
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports: 5173 for dev server, 5900 for VNC
EXPOSE 5173 5900

# Build the application as node user
RUN pnpm run build

# Create necessary directories for X11
RUN mkdir -p /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix

# Switch back to root for running X11 and VNC
USER root

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/startup.sh"]