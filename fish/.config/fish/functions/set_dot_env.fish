function set_dot_env
    if test (count $argv) -eq 0
        echo "Usage: set_dot_env <env_file_path>"
        return 1
    end

    for line in (grep -v '^#' $argv[1])
        set var_name (echo $line | cut -d '=' -f 1)
        set var_value (echo $line | cut -d '=' -f 2-)
        set -x $var_name $var_value
    end
end
