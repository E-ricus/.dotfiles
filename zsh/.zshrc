# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
    # MacOs only
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
