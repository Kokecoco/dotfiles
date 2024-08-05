function auto_virtualenv --on-variable PWD
    set cwd $PWD

    while true
        if [ -d "$cwd/venv" ]
            if [ "$VIRTUAL_ENV" != "$cwd/venv" ]
                echo "Python venv activated: $cwd/venv"
                source $cwd/venv/bin/activate.fish
                echo "Virtual environment activated"
            else
                # echo ""
            end
            break
        end

        if [ "$cwd" = "/" ]
            if [ -n "$VIRTUAL_ENV" ]
                echo "Python activated venv deactivate: $VIRTUAL_ENV"
                deactivate
            end
            break
        end

        set cwd (dirname $cwd)
    end
end

