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
alias la "eza -la"
alias ls "eza -a"

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
add_to_path $HOME/zigup/zig-out/bin
add_to_path $HOME/roc
# add_to_path $HOME/.local/share/nvim/mason/bin
add_to_path $HOME/go/bin
add_to_path $HOME/google-cloud-sdk/bin
add_to_path $HOME/.local/share/coursier/bin
add_to_path $HOME/.ghcup/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/Odin
add_to_path $HOME/swift/usr/bin
add_to_path $HOME/miniconda3/bin
add_to_path $HOME/c3c/build
add_to_path $HOME/.deno/bin
add_to_path $XDG_CONFIG_HOME/emacs/bin
add_to_path $HOME/.bun/bin

# Asdf
if test -d $HOME/.asdf
    source $HOME/.asdf/asdf.fish
end

# Bun
if test -d $HOME/.bun
    set --export BUN_INSTALL $HOME/.bun
end

# Odin
if test -d $HOME/Odin
    set ODIN_ROOT $HOME/Odin
end

# ZVM
if test -d $HOME/.zvm
    set ZVM_INSTALL $HOME/.zvm/self
    add_to_path $HOME/.zvm/self
    add_to_path $HOME/.zvm/bin
end

# Go
if test -d /usr/local/go
    fish_add_path /usr/local/go/bin
    go env -w GOPRIVATE=github.com/goflink
end

#Mojo
if test -d $HOME/.modular
    set MODULAR_HOME $HOME/.modular
    add_to_path $HOME/.modular/bin
end

# Vim
fish_vi_key_bindings
set -U fish_cursor_default block
set -U fish_cursor_insert line blink

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

# if type -q fzf
#     fzf --fish | source
# end

# if type -q conda
#     conda_init
# end

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"
