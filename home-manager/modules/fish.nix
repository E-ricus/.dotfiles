
{
  programs.fish = {
    enable = true;
    shellInit = ''
      set -U fish_greeting

      # Enviroments
      set XDG_CONFIG_HOME $HOME/.config
      set DOTFILES $HOME/.dotfiles

      # Globals
      set EDITOR nvim
      set -x KUBE_EDITOR nvim
      set FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'

      # Abbreviations
      abbr -a e nvim
      abbr -a vimdiff 'nvim -d'
      # Alias
      alias rg "rg --files --hidden --glob '!.git'"
      alias ls='eza -lh --group-directories-first --icons=auto'
      alias lsa='ls -a'
      alias lt='eza --tree --level=2 --long --icons --git'
      alias lta='lt -a'
      alias ff="fzf --preview 'bat --style=numbers --color=always {}'''

      # Vim
      fish_vi_key_bindings
      set -U fish_cursor_default block
      set -U fish_cursor_insert line blink

      if type -q $helix
          alias hx helix
      end
    '';

    functions = {
      cd = {
        description = "Enhanced cd with zoxide integration";
        body = ''
          if test (count $argv) -eq 0
              builtin cd ~ && return
          else if test -d $argv[1]
              builtin cd $argv[1]
          else
              z $argv && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
          end
        '';
      };
      add_to_path = {
        argumentNames = [ "path" ];
        body = ''
          if test -e $path
              fish_add_path $path
          end
        '';
      };
      conda_init = {
        body = ''
          if test -d $HOME/miniconda3/bin/
              eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
          else
              echo "Conda not found"
          end
        '';
      };
      custom_colors = {
        body = ''
          switch $argv
              case ayu
                  ayu_colors
              case nord
                  nord_colors
              case darcula
                  darcula_colors
              case '*'
                  echo Undefined color
          end
        '';
      };
      ayu_colors = {
        body = ''
          set -U fish_color_normal CBCCC6
          set -U fish_color_command 5CCFE6
          set -U fish_color_quote BAE67E
          set -U fish_color_redirection D4BFFF
          set -U fish_color_end F29E74
          set -U fish_color_error FF3333
          set -U fish_color_param CBCCC6
          set -U fish_color_comment 5C6773
          set -U fish_color_selection --background=FFCC66
          set -U fish_color_history_current --bold
          set -U fish_color_search_match --background=FFCC66
          set -U fish_color_match F28779
          set -U fish_color_operator FFCC66
          set -U fish_color_escape 95E6CB
          set -U fish_color_cwd 73D0FF
          set -U fish_color_cwd_root red
          set -U fish_color_valid_path --underline
          set -U fish_color_autosuggestion 707A8C
          set -U fish_color_user brgreen
          set -U fish_color_host normal
          set -U fish_color_cancel -r
          set -U fish_pager_color_completion normal
          set -U fish_pager_color_description B3A06D yellow
          set -U fish_pager_color_prefix normal --bold --underline
          set -U fish_pager_color_progress brwhite --background=cyan
        '';
      };
      nord_colors = {
        body = ''
          set -U fish_color_normal normal
          set -U fish_color_command 81a1c1
          set -U fish_color_quote a3be8c
          set -U fish_color_redirection b48ead
          set -U fish_color_end 88c0d0
          set -U fish_color_error ebcb8b
          set -U fish_color_param eceff4
          set -U fish_color_comment 434c5e
          set -U fish_color_match --background=brblue
          set -U fish_color_selection white --bold --background=brblack
          set -U fish_color_search_match bryellow --background=brblack
          set -U fish_color_history_current --bold
          set -U fish_color_operator 00a6b2
          set -U fish_color_escape 00a6b2
          set -U fish_color_cwd green
          set -U fish_color_cwd_root red
          set -U fish_color_valid_path --underline
          set -U fish_color_autosuggestion 4c566a
          set -U fish_color_user brgreen
          set -U fish_color_host normal
          set -U fish_color_cancel -r
          set -U fish_pager_color_completion normal
          set -U fish_pager_color_description B3A06D yellow
          set -U fish_pager_color_prefix normal --bold --underline
          set -U fish_pager_color_progress brwhite --background=cyan
        '';
      };
      darcula_colors = {
        body = ''
          set -L
          set -U fish_color_normal normal
          set -U fish_color_command F8F8F2
          set -U fish_color_quote F1FA8C
          set -U fish_color_redirection 8BE9FD
          set -U fish_color_end 50FA7B
          set -U fish_color_error FFB86C
          set -U fish_color_param FF79C6
          set -U fish_color_comment 6272A4
          set -U fish_color_match --background=brblue
          set -U fish_color_selection white --bold --background=brblack
          set -U fish_color_search_match bryellow --background=brblack
          set -U fish_color_history_current --bold
          set -U fish_color_operator 00a6b2
          set -U fish_color_escape 00a6b2
          set -U fish_color_cwd green
          set -U fish_color_cwd_root red
          set -U fish_color_valid_path --underline
          set -U fish_color_autosuggestion BD93F9
          set -U fish_color_user brgreen
          set -U fish_color_host normal
          set -U fish_color_cancel -r
          set -U fish_pager_color_completion normal
          set -U fish_pager_color_description B3A06D yellow
          set -U fish_pager_color_prefix normal --bold --underline
          set -U fish_pager_color_progress brwhite --background=cyan
        '';
      };
      mojo_activate = {
        body = ''
          set nightly 0
          if test (count $argv) -gt 0
              if test $argv[1] = "--nightly"
                  set nightly 1
              end
          end

          set conda_env "mojo"
          set mojo_dir "packages.modular.com_mojo"
          set install_msg "Installing mojo"
          set install_cmd "modular install mojo"

          if test $nightly -eq 1
              set conda_env "mojo-nightly"
              set mojo_dir "packages.modular.com_nightly_mojo"
              set install_msg "Installing nightly mojo"
              set install_cmd "modular install nightly/mojo"
          end

          if not test -d "$HOME/.modular"
              echo "Modular not installed"
              return 1
          end

          conda activate $conda_env

          if test $status -ne 0
              conda create -n $conda_env python=3.10 -y; and conda activate $conda_env
          end

          if not test -d "$MODULAR_HOME/pkg/$mojo_dir/"
              echo $install_msg
              eval $install_cmd
          end

          add_to_path "$MODULAR_HOME/pkg/$mojo_dir/bin"
        '';
      };
      set_dot_env = {
        body = ''
          if test -z "$argv[1]"
              echo "Usage: set_dot_env <env_file_path>"
              return 1
          end
          set -l env_file $argv[1]

          for line in (grep -v '^#' $env_file)
              set -l key (echo $line | cut -d '=' -f 1)
              set -l value (echo $line | cut -d '=' -f 2-)

              if string match -qr '^[a-zA-Z_][a-zA-Z0-9_]*$' -- $key
                  set -gx $key $value
              else
                  echo "Warning: Skipping invalid variable name '$key'"
              end
          end
        '';
      };
      sql_proxy_connect = {
        body = ''
          if test (count $argv) -lt 2
              echo "Usage: sql_proxy_connect <db_name> <env> [port]"
              return 1
          end

          set db_name $argv[1]
          set env $argv[2]
          set port 1234
          if test (count $argv) -ge 3
              set port $argv[3]
          end

          set connection ""
          switch $db_name
              case fulfillment
                  set connection "flink-core-$env:europe-west3:fulfillment"
              case flow-management
                  set connection "flink-rider-engagement-$env:europe-west3:flow-management"
              case rider-state
                  if test $env = staging
                      set env dev
                  end
                  set connection "flink-ridertech-$env:europe-west3:rider-state-service-$env"
              case rider-profile
                  if test $env = staging
                      set env dev
                  end
                  set connection "flink-ridertech-$env:europe-west3:rider-profile-service-$env"
              case equipment
                  set connection "flink-rider-engagement-$env:europe-west3:rider-equipment"
              case fleet
                  set connection "flink-fleet-management-$env:europe-west3:fleet-management-$env"
              case ops-staff
                  set connection "flink-core-$env:europe-west3:ops-staff-info"
              case qsm
                  set connection "flink-ridertech-$env:europe-west3:quinyx-rider-shifts-$env"
              case '*'
                  echo "Undefined database name: $db_name."
                  read -P "Do you want to connect in flink-core [y/n]? " choice
                  if test $choice = Y -o $choice = y
                      set connection "flink-core-$env:europe-west3:$db_name"
                  else
                      echo "Add the database in the script with the correct connection string."
                      return 1
                  end
          end

          set cmd "$HOME/cloud-sql-proxy --address 0.0.0.0 --port $port $connection"
          echo "Connecting to $cmd"
          eval $cmd
        '';
      };
      unset_dot_env = {
        body = ''
          if test -z "$argv[1]"
              echo "Usage: unset_dot_env <env_file_path>"
              return 1
          end
          set -l env_file $argv[1]
          for key in (grep -v '^#' $env_file | sed -E 's/(.*)=.*/\1/')
              if string match -qr '^[a-zA-Z_][a-zA-Z0-9_]*$' -- $key
                  set -e $key
              else
                  echo "Warning: Skipping invalid variable name '$key'"
              end
          end
        '';
      };
      yy = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
    };
  };
}
