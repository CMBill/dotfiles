#!/usr/bin/env bash

set -e

# 获取脚本所在目录的绝对路径
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$ROOT_DIR/dotfiles"

echo "Starting dotfiles symlink deployment..."

# 确保必要的系统目录存在
mkdir -p "$HOME/.config"

# 通用函数：创建软链接，若目标存在则备份为 .bak
create_symlink() {
    local source_file="$1"
    local target_file="$2"

    if [ ! -e "$source_file" ]; then
        echo "Warning: Source file $source_file does not exist. Skipping."
        return
    fi

    # 检查目标是否存在，或者是损坏的软链接
    if [ -e "$target_file" ] || [ -h "$target_file" ]; then
        # 如果目标已经是正确的软链接，则跳过
        if [ -h "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
            echo "[OK]     Symlink already exists: $target_file -> $source_file"
            return
        fi

        # 否则，进行备份
        echo "[BACKUP] Backing up existing file/folder: $target_file to ${target_file}.bak"
        mv "$target_file" "${target_file}.bak"
    fi

    # 创建软链接
    echo "[LINK]   Creating symlink: $target_file -> $source_file"
    ln -sfn "$source_file" "$target_file"
}

# 明确的路径映射表 (Explicit Mapping)

# 1. 位于 Home 目录的配置
#create_symlink "$SOURCE_DIR/.zshrc" "$HOME/.zshrc"
#create_symlink "$SOURCE_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$SOURCE_DIR/.npmrc" "$HOME/.npmrc"
# create_symlink "$SOURCE_DIR/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# 2. 位于 ~/.config 目录的配置
create_symlink "$SOURCE_DIR/nvim" "$HOME/.config/nvim"
create_symlink "$SOURCE_DIR/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$SOURCE_DIR/uv" "$HOME/.config/uv"
create_symlink "$SOURCE_DIR/wezterm" "$HOME/.config/wezterm"

echo "Deployment completed successfully!"
