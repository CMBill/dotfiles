# dotfiles
本仓库中的配置文件基于 WSL 下的 archlinux。
## 配置文件一览

| 源路径                          | 目标链接                        | 软件                                   | 说明                                                       |
| ------------------------------- | ------------------------------- | -------------------------------------- | ---------------------------------------------------------- |
| `dotfiles/.zshrc`               | `~/.zshrc`                      | [Zsh](https://www.zsh.org/)            | Shell 配置，含插件、别名、编辑器等设置                     |
| `dotfiles/.gitconfig`           | `~/.gitconfig`                  | [Git](https://git-scm.com/)            | Git 全局配置，含 GPG 签名，使用前应先配置 GPG 私钥         |
| `dotfiles/.npmrc`               | `~/.npmrc`                      | [npm](https://www.npmjs.com/)          | npm 镜像源（淘宝镜像）                                     |
| `dotfiles/starship.toml`        | `~/.config/starship.toml`       | [Starship](https://starship.rs/)       | 跨 Shell 终端提示符美化                                    |
| `dotfiles/uv/`                  | `~/.config/uv/`                 | [uv](https://docs.astral.sh/uv/)       | Python 包管理器，清华 PyPI 镜像                            |
| `dotfiles/helix/config.toml`    | `~/.config/helix/config.toml`   | [Helix](https://helix-editor.com/)     | 编辑器配置，Catppuccin Mocha 主题                          |
| `dotfiles/yazi/theme.toml`      | `~/.config/yazi/theme.toml`     | [Yazi](https://yazi-rs.github.io/)     | 文件管理器主题，Catppuccin Mocha 配色                      |
| `dotfiles/opencode/`            | `~/.config/opencode/`           | [OpenCode](https://opencode.ai/)       | CLI 编码助手配置，含 opencode.jsonc 和 tui.jsonc           |

## 脚本用法

### `apply.sh` — 部署配置文件

该脚本将仓库中的配置文件通过软链接部署到系统中对应的位置。如果目标位置已存在文件或目录，会自动备份为 `.bak` 后缀。

```bash
# 克隆仓库
git clone https://github.com/CMBill/dotfiles.git ~/dotfiles

# 运行部署脚本
cd ~/dotfiles
bash apply.sh
```

> 脚本会自动创建 `~/.config/` 等必要目录。

## 依赖项

部分配置文件需要安装对应软件才能生效：

- **Zsh 插件**（在 `.zshrc` 中引用）：`zinit`
- **Starship**：需通过包管理器安装
- **Helix**：需通过 `pacman -S helix` 安装
- **Yazi**：需通过 `pacman -S yazi` 安装
