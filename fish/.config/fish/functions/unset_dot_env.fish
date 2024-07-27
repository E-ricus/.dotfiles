function unset_dot_env
    if test (count $argv) -eq 0
        echo "Usage: unset_dot_env <env_file_path>"
        return 1
    end

    for line in (grep -v '^#' $argv[1] | sed -E 's/(.*)=.*/\1/')
        set var_name (echo $line | cut -d '=' -f 1)
        set -e $var_name
    end
end
