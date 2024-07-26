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
alias e="nvim"
alias code="nvim"
alias atom="nvim"
alias emacs="nvim"

alias fishrc="nvim ~/.config/fish/config.fish"

alias nvimrc="nvim ~/.config/nvim/init.lua"
alias nvimplugins="cd ~/.config/nvim/lua/plugins && nvim"

alias ga="git add ."
alias gc="git commit -m"
alias gpush="git push"
alias gpull="git pull"
