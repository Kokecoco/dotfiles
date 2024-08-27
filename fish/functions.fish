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
    if test (count $argv) -eq 0
        # 引数なしで呼ばれた場合、ホームディレクトリに移動
        builtin cd ~
    else if test "$argv[1]" = '-'
        # 'cd -' の処理を保持 (前のディレクトリに戻る)
        builtin cd -
    else
        # その他の引数がある場合は通常のcdを実行
        builtin cd $argv
    end

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

