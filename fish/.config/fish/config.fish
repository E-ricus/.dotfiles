# Abbreviations
abbr -a e nvim
abbr -a c cargo
abbr -a vimdiff 'nvim -d'

# Enviroments
set XDG_CONFIG_HOME $HOME/.config
set DOTFILES $HOME/.dotfiles

# PATH
if test -d $HOME/.bin
    fish_add_path $HOME/.bin
end

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

# Rust
if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
end

# Golang
if test -d $HOME/go
    fish_add_path $HOME/go/bin
    set GOPATH $HOME/go
end

if test -d /usr/local/go
    fish_add_path /usr/local/go/bin
    set GOROOT /usr/local/go
end

# Vim
fish_vi_key_bindings

set -U fish_greeting

# Globals
set EDITOR nvim
set FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'

# Alias
alias rg "rg --files --hidden --glob '!.git'"
alias ls "exa -la"

# Prompt
starship init fish | source
# Better folder navigation
zoxide init fish | source
