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

print_warning() {
    echo -e "${YELLOW}[!] $1${NC}"
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

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 安装基础工具
print_message "安装基础工具..."
pkg install -y fish tmux openssh fd bat helix neovim tsu termux-services zoxide fzf

# 设置 fish 为默认 shell
print_message "设置 fish 为默认 shell..."
chsh -s fish
check_status "设置默认 shell"

# 配置 fish 插件
print_message "配置 fish 插件..."

# 创建临时安装脚本
FISH_SETUP_SCRIPT="${SCRIPT_DIR}/setup_plugins.fish"
cat > "$FISH_SETUP_SCRIPT" << 'EOF'
# 下载并安装 fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# 安装其他插件
fisher install PatrickF1/fzf.fish
fisher install kidonng/zoxide.fish
EOF

# 使用 fish 执行安装脚本
fish "$FISH_SETUP_SCRIPT"
check_status "fish 插件安装"

# 清理临时脚本
rm -f "$FISH_SETUP_SCRIPT"

# 复制配置文件
print_message "复制配置文件..."
# 创建必要的配置目录
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/helix
# 复制配置文件
cp "${SCRIPT_DIR}/configs/tmux.conf" ~/.tmux.conf
cp "${SCRIPT_DIR}/configs/fish_prompt.fish" ~/.config/fish/functions/fish_prompt.fish
cp "${SCRIPT_DIR}/configs/helix.toml" ~/.config/helix/config.toml
check_status "配置文件复制"

# 为 root 用户配置环境
print_message "配置 root 用户环境..."
# 创建 .suroot 目录（如果不存在）
mkdir -p ~/.suroot
# 链接配置文件到 root 用户目录
ln -sf ~/.config ~/.suroot/.config
ln -sf ~/.tmux.conf ~/.suroot/.tmux.conf
check_status "root 用户配置"

# 配置 SSH 服务
print_message "配置 SSH 服务..."
sshd
check_status "SSH 服务配置"

print_message "配置完成！"
print_message "SSH 服务已配置为开机自启动"
print_message "请重新启动 Termux 以使用 fish shell"

print_warning "配置完成"
print_warning "请运行 'passwd' 命令设置你的终端密码"
print_warning "请重启应用，运行 sv-enable sshd 命令启动 SSH 服务"