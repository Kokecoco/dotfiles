# -----------------------------
# Lang
# -----------------------------
#export LANG=ja_JP.UTF-8
#export LESSCHARSET=utf-8

# -----------------------------
# General
# -----------------------------
# 色を使用
autoload -Uz colors ; colors

# エディタをvimに設定
export EDITOR=nvim

# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# emacsキーバインド
bindkey -e

# viキーバインド
#bindkey -v

# フローコントロールを無効にする
setopt no_flow_control

# ワイルドカード展開を使用する
setopt extended_glob

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# ビープ音を鳴らさないようにする
#setopt no_beep

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の入力のみで移動する
setopt auto_cd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# 8bit文字を有効にする
setopt print_eight_bit

# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# パスの最後のスラッシュを削除しない
setopt noautoremoveslash

# 各コマンドが実行されるときにパスをハッシュに入れる
#setopt hash_cmds

# rsysncでsshを使用する
export RSYNC_RSH=ssh

# その他
umask 022
ulimit -c 0

# -----------------------------
# Prompt
# -----------------------------
# %M    ホスト名
# %m    ホスト名
# %d    カレントディレクトリ(フルパス)
# %~    カレントディレクトリ(フルパス2)
# %C    カレントディレクトリ(相対パス)
# %c    カレントディレクトリ(相対パス)
# %n    ユーザ名
# %#    ユーザ種別
# %?    直前のコマンドの戻り値
# %D    日付(yy-mm-dd)
# %W    日付(yy/mm/dd)
# %w    日付(day dd)
# %*    時間(hh:flag_mm:ss)
# %T    時間(hh:mm)
# %t    時間(hh:mm(am/pm))
PROMPT='%F{cyan}%n@%m%f:%~# '

# -----------------------------
# Completion
# -----------------------------
# 自動補完を有効にする
autoload -Uz compinit ; compinit

# 単語の入力途中でもTab補完を有効化
#setopt complete_in_word

# コマンドミスを修正
setopt correct

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
#setopt list_types

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# --prefix=/usr などの = 以降でも補完
setopt magic_equal_subst

# -----------------------------
# History
# -----------------------------
# 基本設定
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# ヒストリーに重複を表示しない
setopt histignorealldups

# 他のターミナルとヒストリーを共有
setopt share_history

# すでにhistoryにあるコマンドは残さない
setopt hist_ignore_all_dups

# historyに日付を表示
alias h='fc -lt '%F %T' 1'

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 履歴をすぐに追加する
setopt inc_append_history

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

#余分なスペースを削除してヒストリに記録する
#setopt hist_reduce_blanks

# historyコマンドは残さない
#setopt hist_save_no_dups

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
#bindkey '^R' history-incremental-pattern-search-backward
#bindkey "^S" history-incremental-search-forward

# ^P,^Nを検索へ割り当て
#bindkey "^P" history-beginning-search-backward-end
#bindkey "^N" history-beginning-search-forward-end

# -----------------------------
# Alias
# -----------------------------
# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# エイリアス
alias lst='ls -ltr --color=auto'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -alF --color=auto'
alias l="ls -l"

alias du="du -Th"
alias df="df -Th"
alias su="su -l"
alias so='source'
alias vz='nvim ~/.zshrc'
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias back='pushd'
alias diff='diff -U1'

alias tma='tmux attach'
alias tml='tmux list-window'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ..1="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."

alias vi="nvim"
alias vim="nvim"
alias code="nvim"
alias emacs="nvim"
alias nano="nvim"
alias pico="nvim"
alias edit="nvim"
alias e="nvim"

alias fishrc="nvim ~/.config/fish/config.fish"

alias nvimrc="nvim ~/.config/nvim/init.lua"
alias nvimplugins="cd ~/.config/nvim/lua/plugins && nvim"

alias ga="git add ."
alias gc="git commit -m"
alias gpush="git push"
alias gpull="git pull"

alias c="clear"
alias reset="clear && cd ~ && fish"

alias nofish="bash --rcfile ~/nofish.bashrc"

alias uclip="uclip.exe"
alias clip="uclip.exe"

alias rtty=" ~/go/bin/rtty run bash -p 8080 -v --font \"HackGen Console NF\""

alias pyserve="python -m http.server 8000"

alias toja="trans -b en:ja"

alias gip="curl -s http://ifconfig.me"


# -----------------------------
# Plugin
# -----------------------------
# root のコマンドはヒストリに追加しない
#if [ $UID = 0 ]; then
#  unset HISTFILE
#  SAVEHIST=0
#fi

#function h {
#  history
#}

#function g() {
#  egrep -r "$1" .
#}

function t()
{
  tmux new-session -s $(pwd |sed -E 's!^.+/([^/]+/[^/]+)$!\1!g' | sed -e 's/\./-/g')
}

function psgrep() {
  ps aux | grep -v grep | grep "USER.*COMMAND"
  ps aux | grep -v grep | grep $1
}

function dstop()
{
  docker stop $(docker ps -a -q);
}

function drm()
{
  docker rm $(docker ps -a -q);
}

# -----------------------------
# Plugin
# -----------------------------
# zplugが無ければインストール
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを有効化する
source ~/.zplug/init.zsh

# プラグインList
# zplug "ユーザー名/リポジトリ名", タグ
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
#zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf

# インストールしていないプラグインをインストール
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose > /dev/null 2>&1

# -----------------------------
# PATH
# -----------------------------
case "${OSTYPE}" in
  darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac

# -----------------------------
# Python
# -----------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
alias pipallupgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# -----------------------------
# Golang
# -----------------------------
if which go > /dev/null 2>&1  ; then
  export CGO_ENABLED=1
  export GOPATH=$HOME/dev/go
  export PATH=$PATH:$(go env GOROOT)/bin:$GOPATH/bin
fi

# -----------------------------
# Git
# -----------------------------
function gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

function gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

function gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}


. "$HOME/.cargo/env"

# zplug のメッセージを非表示にする
export ZPLUG_LOG_LOAD_SUCCESS=false
export ZPLUG_LOG_LOAD_FAILURE=false

mem() {
    free -b | awk '/Mem:/ {
        used=$3;
        free=$4;
        total=$2;
        
        # サイズ単位の変換
        if (total >= 1073741824) {
            total=total/1073741824;  # GiB
            used=used/1073741824;
            free=free/1073741824;
            unit="GiB";
        } else if (total >= 1048576) {
            total=total/1048576;  # MiB
            used=used/1048576;
            free=free/1048576;
            unit="MiB";
        } else if (total >= 1024) {
            total=total/1024;  # KiB
            used=used/1024;
            free=free/1024;
            unit="KiB";
        } else {
            unit="B";  # バイト
        }
        
        used_p=used/total*100;
        free_p=free/total*100;
        
        bar_size=30;
        used_bar=int(used_p/100*bar_size);
        free_bar=int(free_p/100*bar_size);
        
        used_bar_str="";
        for (i=0; i<used_bar; i++) {used_bar_str=used_bar_str "#";}
        free_bar_str="";
        for (i=0; i<free_bar; i++) {free_bar_str=free_bar_str "#";}
        
        printf "+-------------------------------------------------------+\n";
        printf "| \033[1;32mUsed:%5.1f %s (%.1f%%) |%-30s\033[0m|\n", used, unit, used_p, used_bar_str"|";
        printf "| \033[1;34mFree:%5.1f %s (%.1f%%) |%-30s\033[0m|\n", free, unit, free_p, free_bar_str"|";
        printf "+-------------------------------------------------------+\n";
    }'
}

warp() {
    alias_file="$HOME/.warp_aliases"

    is_valid_alias() {
        alias_name="$1"
        if [[ "$alias_name" =~ [^a-zA-Z0-9_-] ]]; then
            echo "無効なエイリアス名: '$alias_name'。英数字、ハイフン、アンダースコアのみが使用可能です。"
            return 1
        fi
        return 0
    }

    display_help() {
        echo "使用法: warp <alias>"
        echo "       warp --add <alias>"
        echo "       warp --remove <alias>"
        echo "       warp --update <alias>"
        echo "       warp --rename <old_alias> <new_alias>"
        echo "       warp --list"
        echo "       warp --help"
        echo ""
        echo "エイリアスを使用してディレクトリを移動します。"
        echo ""
        echo "オプション:"
        echo "  --add <alias>: 新しいエイリアスを追加します。"
        echo "  --remove <alias>: 指定したエイリアスを削除します。"
        echo "  --update <alias>: 指定したエイリアスを現在のディレクトリに更新します。"
        echo "  --rename <old_alias> <new_alias>: 指定したエイリアスの名前を変更します。"
        echo "  --list: 登録されている全てのエイリアスを表示します。"
        echo "  --help: このヘルプメッセージを表示します。"
    }

    if [[ $# -eq 0 ]]; then
        display_help
        return 1
    fi

    if [[ $# -eq 2 && $1 == '--add' ]]; then
        alias="$2"
        if ! is_valid_alias "$alias"; then
            return 1
        fi
        current_dir="$(pwd)"
        if grep -q "^$alias " "$alias_file"; then
            echo "エイリアス '$alias' は既に存在しています。--update オプションを使用して変更してください。"
            return 1
        fi
        echo "$alias $current_dir" >> "$alias_file"
        echo "ディレクトリ '$current_dir' をエイリアス '$alias' として追加しました。"
        return 0
    fi

    if [[ $# -eq 2 && $1 == '--remove' ]]; then
        alias="$2"
        if ! is_valid_alias "$alias"; then
            return 1
        fi
        grep -v "^$alias " "$alias_file" > "$alias_file.tmp" && mv "$alias_file.tmp" "$alias_file"
        echo "エイリアス '$alias' を削除しました。"
        return 0
    fi

    if [[ $# -eq 3 && $1 == '--rename' ]]; then
        old_alias="$2"
        new_alias="$3"
        if ! is_valid_alias "$new_alias"; then
            return 1
        fi
        found=0
        while IFS= read -r line; do
            key="${line%% *}"
            value="${line#* }"
            if [[ "$key" == "$old_alias" ]]; then
                echo "$new_alias $value" >> "$alias_file.tmp"
                found=1
            else
                echo "$line" >> "$alias_file.tmp"
            fi
        done < "$alias_file"
        if [[ $found -eq 0 ]]; then
            echo "エイリアス '$old_alias' に見つかりませんでした。"
            rm -f "$alias_file.tmp"
            return 1
        fi
        mv "$alias_file.tmp" "$alias_file"
        echo "エイリアス '$old_alias' を '$new_alias' に変更しました。"
        return 0
    fi

    if [[ $# -eq 2 && $1 == '--update' ]]; then
        alias="$2"
        if ! is_valid_alias "$alias"; then
            return 1
        fi
        current_dir="$(pwd)"
        grep -v "^$alias " "$alias_file" > "$alias_file.tmp"
        echo "$alias $current_dir" >> "$alias_file.tmp"
        mv "$alias_file.tmp" "$alias_file"
        echo "エイリアス '$alias' を現在のディレクトリに更新しました。"
        return 0
    fi

    if [[ $# -eq 1 && $1 == '--list' ]]; then
        cat "$alias_file"
        return 0
    fi

    if [[ $# -eq 1 && $1 == '--help' ]]; then
        display_help
        return 0
    fi

    alias="$1"
    found=0

    while IFS= read -r line; do
        key="${line%% *}"
        value="${line#* }"
        if [[ "$key" == "$alias" ]]; then
            cd "$value" || return
            found=1
            break
        fi
    done < "$alias_file"

    if [[ $found -eq 0 ]]; then
        echo "エイリアス '$alias' は $alias_file に見つかりませんでした。"
        return 1
    fi
}

mdcd() {
    # 引数を変数に格納
    dir="$1"

    # ディレクトリが存在するか確認
    if [ -d "$dir" ]; then
        # 存在する場合は移動
        cd "$dir" || return
    else
        # 存在しない場合はディレクトリを作成してから移動
        mkdir -p "$dir"
        cd "$dir" || return
    fi
}

exec fish
