# dotfiles (Windows)

本仓库中的配置文件用于 Windows 环境。

## 配置文件一览

| 源路径                   | 目标链接 (Windows)                    | 软件                                       | 说明                                                       |
| ------------------------ | ------------------------------------- | ------------------------------------------ | ---------------------------------------------------------- |
| `dotfiles/.npmrc`        | `%USERPROFILE%\.npmrc`                | [npm](https://www.npmjs.com/)              | npm 镜像源（淘宝镜像）                                     |
| `dotfiles/starship.toml` | `%USERPROFILE%\.config\starship.toml` | [Starship](https://starship.rs/)           | 跨 Shell 终端提示符美化                                    |
| `dotfiles/wezterm/`      | `%USERPROFILE%\.config\wezterm`       | [WezTerm](https://wezfurlong.org/wezterm/) | GPU 加速的跨平台终端模拟器配置                             |
| `dotfiles/nvim/`         | `%LOCALAPPDATA%\nvim`                 | [Neovim](https://neovim.io/)               | 编辑器配置，详见 [nvim/README.md](dotfiles/nvim/README.md) |
| `dotfiles/uv/`           | `%APPDATA%\uv`                        | [uv](https://docs.astral.sh/uv/)           | Python 包管理器，清华 PyPI 镜像                            |

## 部署

使用 `apply.ps1` 通过符号链接（或 Junction / 复制回退）将配置文件部署到对应路径。

```powershell
git clone <repo-url> $env:USERPROFILE\dotfiles
cd $env:USERPROFILE\dotfiles
powershell -ExecutionPolicy Bypass -File .\apply.ps1
```

> 脚本会自动创建 `%USERPROFILE%\.config`、`%LOCALAPPDATA%\nvim`、`%APPDATA%\uv` 等必要目录。

## 依赖项

部分配置文件需要安装对应软件才能生效：

- **[Starship](https://starship.rs/)**：需通过包管理器安装
- **[WezTerm](https://wezfurlong.org/wezterm/)**：需安装 Windows 版本
- **[Neovim](https://neovim.io/)**：需安装 >= 0.9 版本，首次启动时自动安装 lazy.nvim 及所有插件
