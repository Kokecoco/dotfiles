# ~/.config/fish/functions/warp.fish

function warp --description "エイリアスを使用してディレクトリを移動する"
    set alias_file ~/.warp_aliases

    function is_valid_alias
        set alias_name $argv[1]
        if string match -qr '[^a-zA-Z0-9_-]' $alias_name
            echo "無効なエイリアス名: '$alias_name'。英数字、ハイフン、アンダースコアのみが使用可能です。"
            return 1
        end
        return 0
    end

    function display_help
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
    end

    if test (count $argv) -eq 0
        display_help
        return 1
    end

    if test (count $argv) -eq 2 -a $argv[1] = '--add'
        set alias $argv[2]
        if not is_valid_alias $alias
            return 1
        end
        set current_dir (pwd)
        set existing (grep "^$alias " $alias_file)
        if test (count $existing) -gt 0
            echo "エイリアス '$alias' は既に存在しています。--update オプションを使用して変更してください。"
            return 1
        end
        echo "$alias $current_dir" >> $alias_file
        echo "ディレクトリ '$current_dir' をエイリアス '$alias' として追加しました。"
        return 0
    end

    if test (count $argv) -eq 2 -a $argv[1] = '--remove'
        set alias $argv[2]
        if not is_valid_alias $alias
            return 1
        end
        set temp_file (mktemp)
        grep -v "^$alias " $alias_file > $temp_file
        mv $temp_file $alias_file
        echo "エイリアス '$alias' を削除しました。"
        return 0
    end

    if test (count $argv) -eq 3 -a $argv[1] = '--rename'
        set old_alias $argv[2]
        set new_alias $argv[3]
        if not is_valid_alias $new_alias
            return 1
        end
        set temp_file (mktemp)
        set found 0
        for line in (cat $alias_file)
            set elements (string split ' ' $line)
            if test (count $elements) -eq 2
                set key $elements[1]
                set value $elements[2]
                if string match -q '~*' $value
                    set value (eval echo $value)
                end
                if test $key = $old_alias
                    echo "$new_alias $value" >> $temp_file
                    set found 1
                else
                    echo "$key $value" >> $temp_file
                end
            else
                echo $line >> $temp_file
            end
        end
        if test $found -eq 0
            echo "エイリアス '$old_alias' に見つかりませんでした。"
            rm -f $temp_file
            return 1
        end
        mv $temp_file $alias_file
        echo "エイリアス '$old_alias' を '$new_alias' に変更しました。"
        return 0
    end

    if test (count $argv) -eq 2 -a $argv[1] = '--update'
        set alias $argv[2]
        if not is_valid_alias $alias
            return 1
        end
        set current_dir (pwd)
        set temp_file (mktemp)
        grep -v "^$alias " $alias_file > $temp_file
        echo "$alias $current_dir" >> $temp_file
        mv $temp_file $alias_file
        echo "エイリアス '$alias' を現在のディレクトリに更新しました。"
        return 0
    end

    if test (count $argv) -eq 1 -a $argv[1] = '--list'
        cat $alias_file
        return 0
    end

    if test (count $argv) -eq 1 -a $argv[1] = '--help'
        display_help
        return 0
    end

    set alias $argv[1]
    set found 0

    for line in (cat $alias_file)
        set elements (string split ' ' $line)
        if test (count $elements) -eq 2
            set key $elements[1]
            set value $elements[2]
            if string match -q '~*' $value
                set value (eval echo $value)
            end
            if test $key = $alias
                cd $value
                set found 1
                break
            end
        end
    end

    if test $found -eq 0
        echo "エイリアス '$alias' は $alias_file に見つかりませんでした。"
        return 1
    end
end

