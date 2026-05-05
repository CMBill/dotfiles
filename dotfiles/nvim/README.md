# Neovim 配置

基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件，首次启动时自动安装。

## 目录结构

```
dotfiles/nvim/
├── init.lua                 # 入口文件，加载 lazy.lua
├── lazy-lock.json           # 插件版本锁定文件
├── lua/
│   ├── config/
│   │   └── lazy.lua         # lazy.nvim 引导与初始化
│   └── plugins/
│       └── spec1.lua        # 所有插件配置集中于此
├── .gitignore               # 忽略 lazy-lock.json
└── .vscode/
    └── settings.json        # VS Code 与 Neovim 联动的编辑器设置
```

## 已安装插件

| 插件                                                         | 用途                                           |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [catppuccin](https://github.com/catppuccin/nvim)             | 配色主题（Mocha 风格）                         |
| [snacks.nvim](https://github.com/folke/snacks.nvim)          | 功能合集：文件查找、文件浏览、通知、Git 集成等 |
| [which-key.nvim](https://github.com/folke/which-key.nvim)    | 按键映射提示                                   |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏美化                                     |
| [mini.icons](https://github.com/echasnovski/mini.icons)      | 文件图标                                       |
| [mini.pairs](https://github.com/echasnovski/mini.pairs)      | 自动配对括号                                   |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)  | Git 行内修改标记                               |

## 依赖

- Neovim >= 0.9
- Git（用于克隆 lazy.nvim 及插件）
