### ENVIROMENTS
export ZSH_ENV_HOME=$HOME
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"
export DOTFILES="$HOME/.dotfiles"

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

if [ -d "/usr/local/go/" ] ;
  then export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "$HOME/.cargo/bin" ] ;
  then export PATH="$HOME/.cargo/bin:$PATH"
fi
# Globals
export EDITOR="nvim"

# Alias
alias e="nvim"
alias czsh="nvim ~/.zshrc"
alias cnvim="cd $XDG_CONFIG_HOME/nvim/ && nvim"
alias ls="exa -la"

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

### PLUGINS
## Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
## End of Zinit's installer chunk

# Benchmark prompt
# source $ZSH_CUSTOM/plugins/zsh-prompt-benchmark/zsh-prompt-benchmark.plugin.zsh

zinit wait lucid for \
    atload'_history_substring_search_config' \
        zsh-users/zsh-history-substring-search \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting

## Plugins configuration
# History substring config
function _history_substring_search_config() {
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
}

# History in cache directory:
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.cache/zsh/history"
setopt SHARE_HISTORY

## COMPLETION
# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '\e' send-break
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

### Eval plugins
# Only needed to load at first time using eval null plugins
# zinit ice wait"1"
zinit light NICHOLAS85/z-a-eval 
# Starship prompt
zplugin ice from"gh-r" as"program" atload'!eval $(starship init zsh)'
zinit light starship/starship

# Better folder navigation
zinit ice wait id-as"zoxide_movement" has"zoxide" lucid \
      eval'zoxide init zsh' run-atpull
zinit light zdharma/null
