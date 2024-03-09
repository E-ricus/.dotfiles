### ENVIROMENTS
export ZSH_ENV_HOME=$HOME
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"
export DOTFILES="$HOME/.dotfiles"

# Globals
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'

# Alias
alias e="nvim"
alias czsh="nvim ~/.zshrc"
alias cnvim="cd $XDG_CONFIG_HOME/nvim/ && nvim"
alias ls="eza"
alias la="eza -la"

# Function to add a parameter to the path if it exists
add_to_path() {
    if [[ -z "$1" ]]; then
        echo "Usage: add_to_path_if_exists <parameter>"
        return 1
    fi

    if [[ -e "$1" ]]; then
        if [[ -d "$1" ]]; then
            export PATH="$1:$PATH"
            echo "$1 added to PATH"
        else
            echo "$1 is not a directory"
            return 1
        fi
    else
        echo "$1 does not exist"
        return 1
    fi
}

# PATH
add_to_path "$HOME/.bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/Applications"
add_to_path "/opt/homebrew/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.zig/bin"
add_to_path "$HOME/roc"
add_to_path "$HOME/.local/share/nvim/mason/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/google-cloud-sdk/bin"
add_to_path "$HOME/.local/share/coursier/bin"
add_to_path "$HOME/.ghcup/bin"
add_to_path "$HOME/.cabal/bin"
add_to_path "$HOME/Odin"
add_to_path "$HOME/swift/usr/bin"
# MacOnly
add_to_path "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# Odin
if [[ -d "$HOME/Odin" ]]; then
    export ODIN_ROOT "$HOME/Odin"
fi

# Go
if [[ -d "/usr/local/go" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
    command go env -w GOPRIVATE=github.com/goflink
fi

#Mojo
if [[ -d "$HOME/.modular" ]]; then
    export MODULAR_HOME "$HOME/.modular"
    add_to_path "$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"
fi


# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ericus/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ericus/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ericus/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ericus/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<




#################################################################
### PLUGINS
## Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
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
        zdharma-continuum/fast-syntax-highlighting

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
zinit ice wait id-as"starship_prompt" has"starship" lucid \
      eval'starship init zsh' run-atpull
zinit light zdharma-continuum/null

# Better folder navigation
zinit ice wait id-as"zoxide_movement" has"zoxide" lucid \
      eval'zoxide init zsh' run-atpull
zinit light zdharma-continuum/null

