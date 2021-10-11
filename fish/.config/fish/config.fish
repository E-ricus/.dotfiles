abbr -a e nvim
abbr -a c cargo
abbr -a vimdiff 'nvim -d'

# PATH
if test -d $HOME/.bin
    set PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
    set PATH $HOME/.local/bin $PATH
end

# Rust
if test -d $HOME/.cargo/bin
    set PATH $HOME/.cargo/bin $PATH
end

# Golang
if test -d $HOME/go
    set PATH $HOME/go/bin $PATH
    set GOPATH $HOME/go
end

if test -d /usr/local/go
    set PATH /usr/local/go/bin $PATH
    set GOROOT /usr/local/go
end


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
