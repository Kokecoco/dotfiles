# functions.zsh

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

function backup() {
  cp "$1" "${1}.bak"
}

function h() {
  history | grep "$1"
}

function replace_all() {
  find . -type f -exec sed -i "s/$1/$2/g" {} +
}

function gs() {
  git status -sb
}

function myip() {
  curl -s http://ipinfo.io/ip
}

function sysinfo() {
  echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
  echo "Memory: $(free -h | grep Mem | awk '{print $3 "/" $2}')"
  echo "Disk: $(df -h / | awk 'NR==2 {print $3 " / " $2}')"
  echo "Uptime: $(uptime -p)"
}

function rename_all() {
  for file in *.$1; do
    mv "$file" "${file%.$1}.$2"
  done
}

function dus() {
  du -sh "$1"
}

function compress() {
  tar -czvf "$1".tar.gz "$1"
}

function extract() {
  tar -xzvf "$1"
}

function copy() {
  pbcopy < "$1"
}

function cdh() {
  local dir
  dir=$(dirs -v | fzf | awk '{print $2}')
  if [[ -n $dir ]]; then
    eval cd "$dir"
  fi
}

function auto_virtualenv {
    local cwd="$PWD"

    while true; do
        if [[ -d "$cwd/venv" ]]; then
            if [[ "$VIRTUAL_ENV" != "$cwd/venv" ]]; then
                echo "Python venv activated: $cwd/venv"
                source "$cwd/venv/bin/activate"
                echo "Virtual environment activated"
            fi
            break
        fi

        if [[ "$cwd" == "/" ]]; then
            if [[ -n "$VIRTUAL_ENV" ]]; then
                echo "Python activated venv deactivate: $VIRTUAL_ENV"
                deactivate
            fi
            break
        fi

        cwd=$(dirname "$cwd")
    done
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd auto_virtualenv
auto_virtualenv  # 初回実行

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


