# Abbreviations
abbr -a e nvim
abbr -a c cargo
abbr -a vimdiff 'nvim -d'

# Enviroments
set XDG_CONFIG_HOME $HOME/.config
set DOTFILES $HOME/.dotfiles

function add_to_path -a path
    if test -e $path
        fish_add_path $path
    end
end

# PATH
add_to_path $HOME/.bin
add_to_path $HOME/.local/bin
add_to_path $HOME/Applications
add_to_path /opt/homebrew/bin
add_to_path $HOME/.cargo/bin
add_to_path $HOME/.zig/bin
add_to_path $HOME/roc
add_to_path $HOME/.local/share/nvim/mason/bin
add_to_path $HOME/go/bin
add_to_path $HOME/google-cloud-sdk/bin
add_to_path $HOME/.local/share/coursier/bin
add_to_path $HOME/.ghcup/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/Odin
add_to_path $HOME/swift/usr/bin

# MacOnly
add_to_path /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin


# Odin
if test -d $HOME/Odin
    set ODIN_ROOT $HOME/Odin
end


# Go
if test -d /usr/local/go
    fish_add_path /usr/local/go/bin
    go env -w GOPRIVATE=github.com/goflink
end

#Mojo
if test -d $HOME/.modular
    set MODULAR_HOME $HOME/.modular
    fish_add_path $MODULAR_HOME/pkg/packages.modular.com_mojo/bin
end

# Vim
fish_vi_key_bindings
set -U fish_cursor_default block
set -U fish_cursor_insert line blink

set -U fish_greeting

# Globals
set EDITOR nvim
set -x KUBE_EDITOR nvim
set FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'

# Alias
alias rg "rg --files --hidden --glob '!.git'"
alias la "exa -la"
alias ls "exa -a"

if type -q $helix
    alias hx helix
end

# Prompt
if type -q starship
    starship init fish | source
end
# Better folder navigation
if type -q zoxide
    zoxide init fish | source
end

#>>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
