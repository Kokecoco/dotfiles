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
        
        used_bar_str=;
        for (i=0; i<used_bar; i++) {used_bar_str=used_bar_str "#";}
        free_bar_str=;
        for (i=0; i<free_bar; i++) {free_bar_str=free_bar_str "#";}
        
        printf "+-------------------------------------------------------+\n";
        printf "| \033[1;32mUsed:%5.1f %s (%.1f%%) |%-30s\033[0m|\n", used, unit, used_p, used_bar_str"|";
        printf "| \033[1;34mFree:%5.1f %s (%.1f%%) |%-30s\033[0m|\n", free, unit, free_p, free_bar_str"|";
        printf "+-------------------------------------------------------+\n";
    }'
end


function gitmoji_commit
    # Gitmojiのリストを定義
    set gitmoji_list "
    ✨  :sparkles: 新機能の追加
    🐛  :bug: バグ修正
    📝  :memo: ドキュメントの更新
    🎨  :art: コードの構造・書式の改善
    🔥  :fire: コードやファイルの削除
    🚀  :rocket: パフォーマンスの改善
    💄  :lipstick: UIやスタイルの改善
    🔒  :lock: セキュリティの向上
    🚑  :ambulance: 緊急修正
    🔧  :wrench: 設定ファイルの変更
    ⚡️  :zap: 小さな機能の追加
    🩹 :adhesive_bandage: 小規模な修正
    "

    # コミットメッセージのプレフィックスのリストを定義
    set prefix_list "
    feat: 新機能
    fix: バグ修正
    docs: ドキュメント修正
    style: コードの書式修正（機能に影響しない変更）
    refactor: リファクタリング
    perf: パフォーマンス改善
    test: テストの追加や修正
    chore: その他の変更（ビルドやツール、依存関係のアップデートなど）
    hotfix: 緊急修正
    "

    # Gitmojiをfzfで選択
    set selected_gitmoji (echo $gitmoji_list | fzf | awk '{print $1}')

    # コミットメッセージのプレフィックスをfzfで選択
    set selected_prefix (echo $prefix_list | fzf | awk '{print $1}')

    # コミットメッセージをユーザーに入力してもらう
    if test -n "$selected_gitmoji" -a -n "$selected_prefix"
        read -P "コミットメッセージを入力してください: " commit_message
        if test -n "$commit_message"
            # 選択されたGitmoji、プレフィックス、入力されたメッセージでコミット
            git commit -m "$selected_gitmoji $selected_prefix $commit_message"
        else
            echo "コミットメッセージが入力されませんでした。"
        end
    else
        echo "Gitmojiまたはプレフィックスの選択がキャンセルされました。"
    end
end

function gf
    set -l branch (git branch -r | fzf --prompt "Select remote branch: " | string trim)
    if test -n "$branch"
        # リモートブランチ名から 'origin/' プレフィックスを取り除く
        set -l local_branch (string replace -r '^origin/' '' $branch)

        # ローカルブランチが存在するか確認
        if not git rev-parse --verify $local_branch^/dev/null 2>/dev/null
            echo "Fetching and checking out new branch $local_branch..."
            git checkout -b $local_branch $branch
        else
            echo "Branch $local_branch already exists locally."
            git checkout $local_branch
        end
    end
end

function oweb
    set htmlfile $argv[1]
    set basename (basename $htmlfile .html)
    nvim $htmlfile assets/css/$basename.css assets/js/$basename.js
end

function gaweb
    set htmlfile $argv[1]
    set basename (basename $htmlfile .html)
    git add $htmlfile assets/css/$basename.css assets/js/$basename.js
end


function kits
    # プロジェクトディレクトリに移動
    cd /home/kokecoco/projects/KITs/

    # ANSIエスケープシーケンスを使って色を設定
    set reset "\033[0m"
    set bold "\033[1m"
    set green "\033[32m"
    set blue "\033[34m"
    set red "\033[31m"

    # figletでメッセージを表示
    echo -en "$bold$green"
    figlet -w 80 'Welcome to KITs Project!'
    echo -en "$reset\n"

    # git pullを実行
    echo -en "$blue"
    echo -n "== Pulling latest changes from Git =="
    echo -e "$reset"
    git pull
    echo

    # lsでディレクトリの内容を表示
    echo -en "$blue"
    echo -n "== Current Directory Contents =="
    echo -e "$reset"
    ls
    echo

    # git statusを表示
    echo -en "$blue"
    echo -n "== Git Status =="
    echo -e "$reset"
    git status
    echo

    # メニューの表示をループで繰り返す
    while true
        # メニューを表示
        echo -en "$green"
        echo -n "== Choose an option: "
        echo -e "$reset"

        echo -en "$green"
        echo -n "1) Open Neovim"
        echo -e "$reset"

        echo -en "$green"
        echo -n "2) Run Git Command"
        echo -e "$reset"

        echo -en "$green"
        echo -n "3) View All Files With Information"
        echo -e "$reset"

        echo -en "$green"
        echo -n "4) Exit"
        echo -e "$reset"

        # ユーザーの入力を取得
        echo -en "$green"
        read -p "echo 'Select an option [1-4]: '" choice
        echo -e "$reset"

        switch $choice
            case 1
                nvim
                return
            case 2
                echo -en "$green"
                read -p "echo 'Enter Git command: '" git_command
                echo -e "$reset"
                eval "git $git_command"
            case 3
                ll
            case 4
                echo -en "$green"
                echo -n "Exiting..."
                echo -e "$reset"
                return
            case '*'
                echo -en "$red"
                echo -n "Invalid option. Please try again."
                echo -e "$reset"
        end
    end
end

