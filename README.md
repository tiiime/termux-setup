# Termux Setup Script
这是一个用于快速配置 [Termux](https://termux.dev/en/) 环境的一键式脚本。  
> 详见：https://invoker.me/make-adb-shell-great-again/


[![asciicast](https://asciinema.org/a/xz1c6nF78SARclkAMCBxp5BLR.svg)](https://asciinema.org/a/xz1c6nF78SARclkAMCBxp5BLR)


## 功能特性

- 自用工具 tmux, nvim...
- fish shell
- sshd
- configs
- host 端辅助工具

## 使用方法

### 准备工作

1. 选择源
```bash
termux-change-repo

```

2.  更新
```bash
pkg update && pkg upgrade -y
```

### 一键执行

```bash
curl -sL https://raw.githubusercontent.com/tiiime/termux-setup/main/run.sh | bash
```

### 手动执行
1. 克隆仓库：
```bash
git clone https://github.com/tiiime/termux-setup.git
```

2. 进入目录：
```bash
cd termux-setup
```

3. 运行脚本：
```bash
chmod +x setup.sh
./setup.sh
```

## Host 端使用说明

1.  手机 adb 连接电脑后，使用 [ ssh_phone ]( ./host/ssh_phone ) 脚本连接：
```bash
# 确保手机已通过 USB 连接并启用了 ADB
./host/ssh_phone 8022
```

## 注意事项

- 请确保有稳定的网络连接
- 建议在全新安装的 Termux 上运行
- 使用 Host 端工具前需要：
  - 安装 ADB 工具
  - 手机开启 USB 调试

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
