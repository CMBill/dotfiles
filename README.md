# dotfiles (Windows)

本分支中的配置文件用于 Windows 环境。

## 配置文件一览

| 源路径                         | 目标链接 (Windows)                    | 软件                                       | 说明                                                                                                            |
| ------------------------------ | ------------------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| `dotfiles/.npmrc`              | `%USERPROFILE%\.npmrc`                | [npm](https://www.npmjs.com/)              | npm 镜像源（npmmirror）                                                                                         |
| `dotfiles/starship.toml`       | `%USERPROFILE%\.config\starship.toml` | [Starship](https://starship.rs/)           | 跨 Shell 终端提示符美化，含 Nerd Fonts 图标映射                                                                 |
| `dotfiles/wezterm/` *(子模块)* | `%USERPROFILE%\.config\wezterm`       | [WezTerm](https://wezfurlong.org/wezterm/) | 模块化终端配置（字体、外观、快捷键、事件），独立仓库 [wezterm-config](https://github.com/CMBill/wezterm-config) |
| `dotfiles/alacritty/`          | `%APPDATA%\alacritty`                 | [Alacritty](https://alacritty.org/)        | 跨平台 GPU 加速终端，Catppuccin Mocha 配色，LXGWWenKaiMono Nerd Font 字体                                       |
| `dotfiles/nvim/`               | `%LOCALAPPDATA%\nvim`                 | [Neovim](https://neovim.io/)               | 编辑器配置，详见 [nvim/README.md](dotfiles/nvim/README.md)                                                      |
| `dotfiles/opencode/`           | `%USERPROFILE%\.config\opencode`      | [OpenCode](https://opencode.ai)            | AI 编程助手配置（superpowers、smart-title、magic-context）                                                      |

## 部署

使用 `apply.ps1` 通过符号链接（或 Junction / 复制回退）将配置文件部署到对应路径。

```powershell
powershell -ExecutionPolicy Bypass -File .\apply.ps1
```

> 脚本会自动创建 `%USERPROFILE%\.config`、`%LOCALAPPDATA%\nvim`、`%APPDATA%\alacritty` 等必要目录。
>
> **wezterm** 为 Git 子模块。克隆仓库时请使用 `git clone --recurse-submodules`，或克隆后执行：
> ```powershell
> git submodule update --init
> ```

## 依赖项

部分配置文件需要安装对应软件才能生效：

- **[Starship](https://starship.rs/)**：需通过包管理器安装
- **[WezTerm](https://wezfurlong.org/wezterm/)**：需安装 Windows 版本
- **[Alacritty](https://alacritty.org/)**：需安装 Windows 版本（配置位于 `%APPDATA%\alacritty\`）
- **[Neovim](https://neovim.io/)**：需安装 >= 0.9 版本，首次启动时自动安装 lazy.nvim 及所有插件
- **[OpenCode](https://opencode.ai)**：需安装 CLI 工具，插件通过 `opencode.json` 自动管理
