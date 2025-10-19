@echo off
echo Testing Docker configuration for AliyunPan...

REM Check if Dockerfile exists
if not exist "Dockerfile" (
    echo ❌ Dockerfile not found!
    exit /b 1
) else (
    echo ✅ Dockerfile found
)

REM Check if docker-compose.yml exists
if not exist "docker-compose.yml" (
    echo ❌ docker-compose.yml not found!
    exit /b 1
) else (
    echo ✅ docker-compose.yml found
)

REM Check if .dockerignore exists
if not exist ".dockerignore" (
    echo ❌ .dockerignore not found!
    exit /b 1
) else (
    echo ✅ .dockerignore found
)

REM Check if package.json exists (required for the build)
if not exist "package.json" (
    echo ❌ package.json not found!
    exit /b 1
) else (
    echo ✅ package.json found
)

echo.
echo Docker configuration validation completed successfully! 🎉
echo.
echo To build the image, run:
echo   docker build -t aliyunpan .
echo.
echo To run with docker-compose:
echo   docker-compose up -d
echo.