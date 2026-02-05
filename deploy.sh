#!/bin/bash

# Hugo 博客快速部署脚本
# 用法：./deploy.sh [环境]
# 环境：dev（开发） | prod（生产）

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Hugo 是否安装
if ! command -v hugo &> /dev/null; then
    print_error "Hugo 未安装，请先安装 Hugo"
    exit 1
fi

# 默认环境
ENV=${1:-prod}

print_info "开始部署流程..."
print_info "目标环境: $ENV"

# 清理旧的构建文件
print_info "清理旧的构建文件..."
rm -rf public/*

# 根据环境构建
if [ "$ENV" = "dev" ]; then
    print_info "构建开发版本（包含草稿）..."
    hugo -D
elif [ "$ENV" = "prod" ]; then
    print_info "构建生产版本..."
    hugo
else
    print_error "未知环境: $ENV"
    print_info "用法: ./deploy.sh [dev|prod]"
    exit 1
fi

# 检查构建是否成功
if [ $? -eq 0 ]; then
    print_info "✅ Hugo 构建成功！"
else
    print_error "❌ Hugo 构建失败！"
    exit 1
fi

# 验证构建结果
if [ ! -d "public" ] || [ -z "$(ls -A public)" ]; then
    print_error "构建目录为空或不存在"
    exit 1
fi

print_info "构建完成，生成文件："
du -sh public/

# 检查是否有 localhost 硬编码
LOCALHOST_COUNT=$(grep -r "localhost" public/ 2>/dev/null | wc -l | tr -d ' ')
if [ "$LOCALHOST_COUNT" -gt 0 ]; then
    print_warn "警告：发现 $LOCALHOST_COUNT 处 localhost 硬编码"
    print_warn "建议检查 hugo.toml 中的 baseURL 配置"
else
    print_info "✅ 未发现 localhost 硬编码"
fi

# 显示部署提示
print_info ""
print_info "======================================"
print_info "📦 构建完成！"
print_info "======================================"
print_info ""
print_info "部署方式："
print_info "1. 同步到服务器："
print_info "   rsync -avz --delete public/ user@8.130.111.124:/var/www/html/"
print_info ""
print_info "2. 或使用 scp："
print_info "   scp -r public/* user@8.130.111.124:/var/www/html/"
print_info ""
print_info "3. 本地测试："
print_info "   cd public && python3 -m http.server 8080"
print_info "   然后访问: http://localhost:8080"
print_info ""
print_info "======================================"

# 询问是否启动本地预览
read -p "是否启动本地预览服务器？(y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "启动本地预览服务器..."
    cd public
    print_info "访问地址: http://localhost:8080"
    print_info "按 Ctrl+C 停止服务器"
    python3 -m http.server 8080
fi
