function fm
    set action $argv[1]
    set source $argv[2]
    set destination $argv[3]

    function confirm
        echo -n "$argv[1] $argv[2] を実行してもよろしいですか？ (y/n): "
        read -l response
        if test $response = "y"
            return 0
        else
            echo "操作はキャンセルされました。"
            return 1
        end
    end

    function help
        echo "使い方: fm [コマンド] [ソース] [デスティネーション]"
        echo ""
        echo "コマンド:"
        echo "  c       : ファイルまたはディレクトリをコピーする。"
        echo "  m       : ファイルまたはディレクトリを移動する。"
        echo "  cz      : ファイルまたはディレクトリを圧縮する。"
        echo "  dz      : ファイルを解凍する。"
        echo "  d       : ファイルまたはディレクトリを削除する。"
        echo "  l       : ディレクトリ内のファイルを一覧表示する。"
        echo "  e       : ファイルを暗号化する。"
        echo "  de      : ファイルを復号化する。"
        echo "  sd      : ファイルを選択的に削除する。"
        echo "  pc      : 進捗表示付きでファイルをコピーする。"
        echo "  find    : ディレクトリ内のファイルを検索する。"
        echo "  ext     : 拡張子でファイルを一覧表示する。"
        echo "  info    : ファイルに関する情報を表示する。"
        echo "  backup   : ファイルまたはディレクトリのバックアップを作成する。"
        echo "  help    : このヘルプメッセージを表示する。"
        echo ""
        echo "例:"
        echo "  fm c ~/Documents ~/Backup"
        echo "  fm m ~/file.txt ~/Documents/"
        echo "  fm l ~/Downloads"
        echo "  fm find ~/Documents myfile.txt"
        echo "  fm ext ~/Downloads jpg"
        echo "  fm info ~/Documents/myfile.txt"
        echo "  fm backup ~/Documents ~/Backup/backup_of_documents"
    end

    if test -z "$action"
        help
        return
    end

    switch $action
        # ファイル/フォルダのコピー
        case "c" # copy
            if confirm "コピー" $source
                cp -rv $source $destination
                echo "$source を $destination にコピーしました。"
            end

        # ファイル/フォルダの移動
        case "m" # move
            if confirm "移動" $source
                mv -v $source $destination
                echo "$source を $destination に移動しました。"
            end

        # ファイル/フォルダの圧縮
        case "cz" # compress
            if confirm "圧縮" $source
                tar -czvf $destination $source
                echo "$source を $destination に圧縮しました。"
            end

        # 圧縮ファイルの解凍
        case "dz" # decompress
            if confirm "解凍" $source
                tar -xzvf $source -C $destination
                echo "$source を $destination に解凍しました。"
            end

        # ファイル/フォルダの削除
        case "d" # delete
            if confirm "削除" $source
                rm -rv $source
                echo "$source を削除しました。"
            end

        # ファイル/フォルダの一覧表示
        case "l" # list
            ls -lh $source

        # ファイルの暗号化
        case "e" # encrypt
            if confirm "暗号化" $source
                openssl aes-256-cbc -salt -in $source -out $destination
                echo "$source を $destination に暗号化しました。"
            end

        # ファイルの復号化
        case "de" # decrypt
            if confirm "復号化" $source
                openssl aes-256-cbc -d -in $source -out $destination
                echo "$source を $destination に復号化しました。"
            end

        # サブディレクトリ/ファイルの選択的削除
        case "sd" # selective delete
            echo "削除するファイルまたはディレクトリを $source から選択してください:"
            ls $source
            echo -n "削除するファイル名を入力してください: "
            read -l files
            if confirm "削除" $files
                rm -rv $source/$files
                echo "選択されたファイルを削除しました。"
            end

        # 進捗表示付きのコピー
        case "pc" # progress copy
            if confirm "コピー" $source
                rsync -ah --progress $source $destination
                echo "$source を $destination に進捗表示付きでコピーしました。"
            end

        # ファイル検索
        case "find" # find
            echo -n "検索するファイル名を $source で入力してください: "
            read -l filename
            find $source -name "$filename" -print

        # 特定の拡張子のファイルをリスト表示
        case "ext" # extension
            if test -z "$destination"
                echo "使い方: fm ext [ディレクトリ] [拡張子]"
                return
            end
            ls -lh $source/*.$destination

        # ファイルの情報表示
        case "info" # info
            if test -f $source
                stat $source
            else
                echo "$source はファイルではありません。"
            end

        # バックアップ
        case "backup" # backup
            if confirm "バックアップ" $source
                cp -rv $source $destination
                echo "$source のバックアップを $destination に作成しました。"
            end

        case "*"
            help
    end
end

