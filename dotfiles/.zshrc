# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=99999
SAVEHIST=99999
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bill/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# 绑定键盘上的特殊按键如End，可以命令行里按cat回车，再按下对应的按键即可查看
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# 配置默认编辑器
export EDITOR='nvim'

# 配置插件
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/autojump/autojump.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 终端语言
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

# 别名
alias ls='ls --color=auto'
alias ll='ls -alhF'
alias grep='grep --color=auto'

export PATH="$PATH:/mnt/c/Program Files/Microsoft VS Code/bin"

# 引入starship
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/bill/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

