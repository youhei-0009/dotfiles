#tmux
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]%f"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# ユーザプロンプト設定
if [ $UID -eq 0 ];then
# ルートユーザーの場合
PROMPT="%F{red}[%*]% %c%f $"
#PROMPT="%F{red}[%*]% %~%f $"
else
# ルートユーザー以外の場合
PROMPT='%F{green}[%*]% %c%f`rprompt-git-current-branch`$'
#PROMPT="%F{green}[%*]% %~%f $"
fi

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
# RPROMPT='`rprompt-git-current-branch`'

#exaが廃止なのでezaのエイリアス設定
alias ls='eza -a'
alias lsa='eza --git --time-style=long-iso -gahl --total-size'
alias lsn='eza --git --time-style=long-iso -gahl'
alias lsf='eza -1f'
alias lsd='eza -1D'
alias lst='eza -TD'

# 言語設定
export LANG=ja_JP.UTF-8

# 色設定
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export EXA_COLORS="da=32"
# export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
# export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# 重複を記録しない
setopt histignorealldups
# history
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
SAVEHIST=500000
# allhistory
function h { history -E 1 }
# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# bat設定
export BAT_THEME="Monokai Extended"
alias bt='bat -P'
# bat ページャーあり
alias bl='bat'

#kubectl
alias kb='kubectl'
alias kblp='kubectl get pod -o wide'

#kubectx,ns
alias ct='kubectx'
alias ctc='kubectx -c'
alias ns='kubens'
alias nsc='kubens -c'

#kubernetes plugin ツール krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

#grepに-Pオプションを追加
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
alias grep='/opt/homebrew/opt/grep/libexec/gnubin/grep'

#phpenvで必要なパスを追加
#必要なパッケージインストール、default_configure_optionsの修正、PHP_BUILD_CONFIGURE_OPTSの環境設定も必要
export PKG_CONFIG_PATH="/opt/homebrew/opt/krb5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libedit/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libjpeg/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpng/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libzip/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/oniguruma/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/tidy-html5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/libiconv/bin:$PATH"
export PATH="/opt/homebrew/opt/krb5/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/tidy-html5/lib:$PATH"
export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting
#入力補完
zinit light zsh-users/zsh-autosuggestions

### End of Zinit's installer chunk

#flutter PATH and setting
export PATH=$HOME/workspace/development/flutter/bin:$PATH
alias flutter="fvm flutter"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/yohei.yauchi/.dart-cli-completion/zsh-config.zsh ]] && . /Users/yohei.yauchi/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
export PATH="/Users/yohei.yauchi/.pub-cache/bin:$PATH"
