abbr -a e nvim
abbr -a c cargo
abbr -a vimdiff 'nvim -d'

set PATH $PATH /usr/local/go/bin
set PATH $PATH $HOME/go/bin
set GOPATH $HOME/go
set GOROOT /usr/local/go
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set EDITOR nvim

alias rg "rg --files --hidden --glob '!.git'"
alias ls "exa -la"

#setenv FZF_DEFAULT_COMMAND 'rg --files'
#setenv FZF_CTRL_T_COMMAND 'rg --files'
#setenv FZF_DEFAULT_OPTS '--height 20%'

starship init fish | source
zoxide init fish | source
