#!/bin/bash

echo "Testing Docker configuration for AliyunPan..."

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "❌ Dockerfile not found!"
    exit 1
else
    echo "✅ Dockerfile found"
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ docker-compose.yml not found!"
    exit 1
else
    echo "✅ docker-compose.yml found"
fi

# Check if .dockerignore exists
if [ ! -f ".dockerignore" ]; then
    echo "❌ .dockerignore not found!"
    exit 1
else
    echo "✅ .dockerignore found"
fi

# Check if package.json exists (required for the build)
if [ ! -f "package.json" ]; then
    echo "❌ package.json not found!"
    exit 1
else
    echo "✅ package.json found"
fi

echo ""
echo "Docker configuration validation completed successfully! 🎉"
echo ""
echo "To build the image, run:"
echo "  docker build -t aliyunpan ."
echo ""
echo "To run with docker-compose:"
echo "  docker-compose up -d"
echo ""