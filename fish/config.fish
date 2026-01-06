set -g fish_prompt_pwd_dir_length 0

fx --comp fish | source


# Created by `pipx` on 2024-07-22 11:47:34
set PATH $PATH /home/kokecoco/.local/bin
set PATH $PATH /home/kokecoco/lua-language-server/bin

source ~/dotfiles/fish/aliases.fish
source ~/dotfiles/fish/functions.fish
thefuck --alias | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/kokecoco/anaconda3/bin/conda
    eval /home/kokecoco/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

set -x CUDA_PATH /usr/local/cuda
set -x CUDNN_PATH /usr/local/cuda
set -x CFLAGS "-I/usr/local/cuda/include"
set -x LDFLAGS "-L/usr/local/cuda/lib64"
set -x LIBRARY_PATH "/usr/local/cuda/lib64:$LIBRARY_PATH"
set -x PATH "$CUDA_PATH/bin:$PATH"

# zellij auto start (only for interactive shells)

if status is-interactive
    if type -q zellij
        if not set -q ZELLIJ

            zellij attach main; or zellij --session main
        end
    end
end

