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
    libgbm \
    libxss \
    libasound \
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

# Create user to run the app
RUN addgroup -g 1000 electron && \
    adduser -u 1000 -G electron -s /bin/sh -D electron

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install pnpm globally
RUN npm install -g pnpm

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Install electron-builder for building
RUN pnpm install electron-builder@^24.13.3 --save-dev

# Build the application
RUN pnpm run build

# Set up environment
ENV NODE_ENV=production
ENV ELECTRON_DISABLE_SECURITY_WARNINGS=1
ENV NODE_TLS_REJECT_UNAUTHORIZED=0
ENV DISPLAY=:0

# Create X11 startup script
RUN echo '#!/bin/sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &\n\
sleep 1\n\
fluxbox &\n\
sleep 1\n\
x11vnc -display :0 -bg -o /tmp/x11vnc.log -localhost -listen 0.0.0.0 -rfbport 5900 -xkb -ncache 10 -ncache_cr &\n\
sleep 1\n\
exec "$@"' > /startup.sh && chmod +x /startup.sh

# Expose ports: 5173 for dev server, 5900 for VNC
EXPOSE 5173 5900

# Copy entrypoint script
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "/startup.sh && pnpm dev"]