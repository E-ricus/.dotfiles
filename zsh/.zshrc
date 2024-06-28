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

# MacOs only
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

## Functions
# Function to add a parameter to the path if it exists
add_to_path() {
    if [[ -z "$1" ]]; then
        echo "Usage: add_to_path_if_exists <parameter>"
        return 1
    fi

    if [[ -e "$1" ]]; then
        if [[ -d "$1" ]]; then
            export PATH="$1:$PATH"
            # echo "$1 added to PATH"
        else
            # echo "$1 is not a directory"
            return 1
        fi
    else
        # echo "$1 does not exist"
        return 1
    fi
}

# Sets the enviroment variables in the given file
set_dot_env() {
    if [[ -z "$1" ]]; then
        echo "Usage: set_dot_env <env_file_path>"
        return 1
    fi
    export $(grep -v '^#' $1 | xargs)
}

# Unses the enviroment variables in the given file
unset_dot_env() {
    if [[ -z "$1" ]]; then
        echo "Usage: set_dot_env <env_file_path>"
        return 1
    fi
    unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
}

# PATH
add_to_path "$HOME/.bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/Applications"
add_to_path "/opt/homebrew/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.zig/bin"
add_to_path "$HOME/roc"
# add_to_path "$HOME/.local/share/nvim/mason/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/google-cloud-sdk/bin"
add_to_path "$HOME/.local/share/coursier/bin"
add_to_path "$HOME/.ghcup/bin"
add_to_path "$HOME/.cabal/bin"
add_to_path "$HOME/Odin"
add_to_path "$HOME/swift/usr/bin"
add_to_path "$HOME/miniconda3/bin"
# MacOnly
add_to_path "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# asdf
if [[ -d "$HOME/.asdf" ]]; then
    . "$HOME/.asdf/asdf.sh"
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
fi

# Odin
if [[ -d "$HOME/Odin" ]]; then
    export ODIN_ROOT="$HOME/Odin"
fi

# Go
if [[ -d "/usr/local/go" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
    command go env -w GOPRIVATE=github.com/goflink
fi

#Mojo
if [[ -d "$HOME/.modular" ]]; then
    export MODULAR_HOME="$HOME/.modular"
    add_to_path "$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Fixes missing snippets
if [ ! -d "$ZSH_CACHE_DIR/completions" ]; then
    mkdir -p "$ZSH_CACHE_DIR/completions"
    (( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)
fi

# Add in zsh plugins
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zi light Aloxaf/fzf-tab
#
# Load completions
autoload -Uz compinit && compinit
zi cdreplay -q

# Add in snippets
zi wait lucid for \
    OMZP::git \
    OMZP::sudo \
    OMZP::command-not-found

if command -v kubectl &> /dev/null
then
    # Snippet not working loading it manually
    # zi snippet OMZP::kubectx
    zi ice as"program" id-as'kubecomp' run-atpull \
        atinit"source <(kubectl completion zsh)"
    zi light zdharma-continuum/null
fi
if command -v kubectx &> /dev/null
then
    zi ice wait lucid OMZP::kubectx
fi


# Keybindings
bindkey -v
export KEYTIMEOUT=1
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
zi ice as"program" id-as'shell-integrations' run-atpull \
    atinit"source <(fzf --zsh);eval $(zoxide init --cmd cd zsh)"
zi light zdharma-continuum/null

# Prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
