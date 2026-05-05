# dotfiles
本仓库中的配置文件基于 WSL 下的 archlinux。
## 配置文件一览

| 源路径                    | 目标链接                  | 软件                             | 说明                                                       |
| ------------------------- | ------------------------- | -------------------------------- | ---------------------------------------------------------- |
| `dotfiles/.zshrc`         | `~/.zshrc`                | [Zsh](https://www.zsh.org/)      | Shell 配置，含插件、别名、编辑器等设置                     |
| `dotfiles/.gitconfig`     | `~/.gitconfig`            | [Git](https://git-scm.com/)      | Git 全局配置，含 GPG 签名，使用前应先配置 GPG 私钥         |
| `dotfiles/.npmrc`         | `~/.npmrc`                | [npm](https://www.npmjs.com/)    | npm 镜像源（淘宝镜像）                                     |
| `dotfiles/gpg-agent.conf` | `~/.gnupg/gpg-agent.conf` | [GnuPG](https://gnupg.org/)      | GPG Agent 配置，指定 pinentry 程序                         |
| `dotfiles/starship.toml`  | `~/.config/starship.toml` | [Starship](https://starship.rs/) | 跨 Shell 终端提示符美化                                    |
| `dotfiles/uv/uv.toml`     | `~/.config/uv/uv.toml`    | [uv](https://docs.astral.sh/uv/) | Python 包管理器，清华 PyPI 镜像                            |
| `dotfiles/nvim/`          | `~/.config/nvim/`         | [Neovim](https://neovim.io/)     | 编辑器配置，详见 [nvim/README.md](dotfiles/nvim/README.md) |

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

> 脚本会自动创建 `~/.gnupg/` 和 `~/.config/` 等必要目录。

## 依赖项

部分配置文件需要安装对应软件才能生效：

- **Zsh 插件**（在 `.zshrc` 中引用）：
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `autojump`
- **Starship**：需通过包管理器安装
- **Neovim**：需安装 >= 0.9 版本，首次启动时会自动安装 lazy.nvim 及所有插件
