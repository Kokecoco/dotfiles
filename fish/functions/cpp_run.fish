function cpp_run
    # 引数が指定されているかチェック
    if [ (count $argv) -eq 0 ]
        echo "Usage: cpp_run <filename>"
        return 1
    end

    # ファイル名を取得
    set filename $argv[1]

    # ファイルが存在するかチェック
    if not test -f $filename
        echo "File $filename does not exist."
        return 1
    end

    # コンパイル
    set outputfile (basename $filename .cpp)
    g++ -o $outputfile $filename

    # コンパイルが成功したかチェック
    if [ $status -ne 0 ]
        echo "Compilation failed."
        return 1
    end

    # 実行
    ./$outputfile

    # 実行が成功したかチェック
    if [ $status -ne 0 ]
        echo "Execution failed."
        return 1
    end
end

