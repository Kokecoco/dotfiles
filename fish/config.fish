if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_prompt_pwd_dir_length 0

# Created by `pipx` on 2024-07-22 11:47:34
set PATH $PATH /home/kokecoco/.local/bin

alias l="ls -l --color=auto"
alias ls="ls --color=auto"
alias ll="ls -alF --color=auto"
alias la="ls -a --color=auto"

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

source ~/dotfiles/fish/functions/auto_virtualenv.fish
auto_virtualenv

alias rtty=" ~/go/bin/rtty run bash -p 8080 -v --font \"HackGen Console NF\""

alias pyserve="python -m http.server 8000"

alias toja="trans -b en:ja"

alias gip="curl -s http://ifconfig.me"

function mem
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
end

alias kitsserve="rm -rf KITs3 && cp -r KITs/ KITs3/ && cd KITs3 && rm -rf .git .github  && jekyll serve && cd .."

alias reboot="wsl.exe --shutdown"

alias nfzsh="zsh -f -c \"source ~/nofish.zshrc\""
