#!/data/data/com.termux/files/usr/bin/bash

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的信息函数
print_message() {
    echo -e "${GREEN}[*] $1${NC}"
}

print_error() {
    echo -e "${RED}[!] $1${NC}"
}

# 检查命令是否执行成功
check_status() {
    if [ $? -eq 0 ]; then
        print_message "$1 成功"
    else
        print_error "$1 失败"
        exit 1
    fi
}

# 创建临时目录
TEMP_DIR=$(mktemp -d)
cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

clone_and_setup() {
    # 克隆仓库
    print_message "克隆配置仓库..."
    cd "$TEMP_DIR"
    git clone https://github.com/tiiime/termux-setup.git
    check_status "仓库克隆"

    # 执行设置脚本
    print_message "执行设置脚本..."
    cd termux-setup
    chmod +x setup.sh
    ./setup.sh
    check_status "设置脚本执行"
}

# 安装 git
print_message "安装 git..."
pkg install -y git && clone_and_setup || {
    print_error "执行更新或安装失败"
    print_warning "pkg update 可能需要手动确认，请尝试单独运行 'pkg update' 命令"
    exit 1
}
