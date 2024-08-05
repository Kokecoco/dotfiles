function mdcd
    # 引数を変数に格納
    set dir $argv[1]

    # ディレクトリが存在するか確認
    if test -d $dir
        # 存在する場合は移動
        cd $dir
    else
        # 存在しない場合はディレクトリを作成してから移動
        mkdir -p $dir
        cd $dir
    end
end

