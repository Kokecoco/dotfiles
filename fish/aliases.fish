alias cmdh='history | fzf | read -l cmd; and test -n "$cmd"; and eval $cmd'

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

alias kitsserve="cd .. && rm -rf KITs3 && cp -r KITs/ KITs3/ && cd KITs3 && rm -rf .git .github  && bundle exec jekyll serve && cd ../KITs"

alias reboot="wsl.exe --shutdown"

alias nfzsh="zsh -f -c \"source ~/nofish.zshrc\""

alias luamake="/home/kokecoco/lua-language-server/3rd/luamake/luamake"

alias gcoh 'git checkout (git log --oneline --reverse | fzf | awk \'{print $1}\')'
alias vrecent 'vim (cat ~/.bash_history | grep -E "vim|nvim" | fzf)'

alias vfind 'vim (find . -type f | fzf)'

alias fhist 'eval (history | fzf | awk \'{for (i=2; i<=NF; i++) printf("%s ", $i)}\')'

alias gedit 'vim (git status -s | awk \'{print $2}\' | fzf)'

alias cdf 'cd (find . -type d | fzf)'

alias falias 'alias | fzf | awk -F "=" \'{print $1}\' | xargs -I {} fish -c {}'

alias kproc 'kill -9 (ps -ef | fzf | awk \'{print $2}\')'

alias gcof 'git checkout $(git branch --format="%(refname:short)" | fzf)'

alias nvimalias "nvim ~/dotfiles/fish/aliases.fish"
alias nvimfunc "nvim ~/dotfiles/fish/functions.fish"

alias gmc "gitmoji_commit"
