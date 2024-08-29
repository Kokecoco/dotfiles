# functions.fish

# ディレクトリ作成と移動
function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# バックアップ作成
function backup
    cp $argv[1] $argv[1].bak
end

# 履歴検索
function h
    history | grep $argv[1]
end

# 一括置換
function replace_all
    find . -type f -exec sed -i "s/$argv[1]/$argv[2]/g" {} +
end

# Gitステータス簡略表示
function gs
    git status -sb
end

# パブリックIPアドレス取得
function myip
    curl -s http://ipinfo.io/ip
end

# システム情報表示
function sysinfo
    echo "CPU: (sysctl -n machdep.cpu.brand_string)"
    echo "Memory: (free -h | grep Mem | awk '{print $3 "/" $2}')"
    echo "Disk: (df -h / | awk 'NR==2 {print $3 " / " $2}')"
    echo "Uptime: (uptime -p)"
end

# ファイル拡張子一括変更
function rename_all
    for file in *.$argv[1]
        mv $file (string replace -- $argv[1] $argv[2] $file)
    end
end

# ディレクトリ容量表示
function dus
    du -sh $argv[1]
end

# 圧縮
function compress
    tar -czvf $argv[1].tar.gz $argv[1]
end

# 解凍
function extract
    tar -xzvf $argv[1]
end

# クリップボードにコピー
function copy
    pbcopy < $argv[1]
end

# グローバル変数としてディレクトリ履歴を保存
set -g DIR_STACK

function cd
  set OLDPWD_TEMP $PWD
    if test (count $argv) -eq 0
        # 引数なしで呼ばれた場合、ホームディレクトリに移動
        builtin cd ~
    else if test "$argv[1]" = '-'
              # 'cd -' の処理 ($OLDPWD に移動)
        if test -n "$OLDPWD"
            builtin cd $OLDPWD
        end
    else
        # その他の引数がある場合は通常のcdを実行
        builtin cd $argv
    end

    set OLDPWD $OLDPWD_TEMP
    # ディレクトリ移動後、現在のディレクトリを履歴スタックに保存
    set -g DIR_STACK $PWD $DIR_STACK
end

function cdh
    # fzfでディレクトリ履歴から選択
    set dir (printf "%s\n" $DIR_STACK | fzf)
    if test -n "$dir"
        builtin cd $dir
    end
end

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


