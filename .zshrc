#  For Plugins and customization
export ZSH_ENV_HOME=$HOME/
export XDG_CONFIG_HOME=$HOME/.config/
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"

# PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/go/bin" ] ;
  then export PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ;
  then export PATH="$HOME/go/bin:$PATH"
fi
# Enviroments
export EDITOR="nvim"

# Alias
alias e="nvim"
alias czsh="nvim ~/.zshrc"
alias cnvim="cd $XDG_CONFIG_HOME/nvim/ && nvim"

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.cache/zsh/history"
setopt SHARE_HISTORY

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$XDG_CONFIG_HOME/shortcutrc" ] && source "$XDG_CONFIG_HOME/shortcutrc"
[ -f "$XDG_CONFIG_HOME/aliasrc" ] && source "$XDG_CONFIG_HOME/aliasrc"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Starship prompt
# sh -c "$(curl -fsSL https://starship.rs/install.sh)"
eval "$(starship init zsh)"

# Better folder navigation
eval "$(zoxide init zsh)"

## zsh plugins:

# Benchmark prompt
# source $ZSH_CUSTOM/plugins/zsh-prompt-benchmark/zsh-prompt-benchmark.plugin.zsh

# Load auto suggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting; should be last.
# git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
