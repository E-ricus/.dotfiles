# Dotfiles
My configs

## Dependencies for instalation
### stow
MacOS: `brew install stow`

Arch based: `paru -S stow`

Debian based: `sudo apt install stow`

### $DOTFILES variable
`export DOTFILES="$HOME/.dotfiles"`

## Install
There should not be en existing file where stow tries to create the symlink

`chmod +x ./install && ./install`

## Uninstall

`chmod +x ./clean && ./clean`

## Rust 
For debian based distros some installations of the following dependencies might be problematic, 
being rust programs, these can be installed with cargo

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-edit
```
## Fish
Ubuntu based distros use an older fish version, this repo fixes it
```sh
sudo apt-add-repository ppa:fish-shell/release-3
```

## Nvim optional requirements
* fd
* ripgrep
* bat
* Treesitter

Arch based: `paru -S fd ripgrep bat tree-sitter`

MacOS: `brew install fd rigprep bat tree-sitter`

Deiban based:
```sh
sudo apt install ripgrep
cargo install bat
cargo install fd-find
cargo install tree-sitter
```

## Fonts
* Nerd fonts fira code
* Nerd fonts Jetbrans mono
* Noto fonts emoji (for arch)

Unix based: 
```sh
cargo install font-manger

# Install any font
font-manager install --nerd FiraCode
font-manager install --nerd JetbrainsMono
```

Arch based: `paru -S nerd-fonts-fira-code nerd-fonts-jetbrains-mono noto-fonts-emoji`

MacOS:

```sh
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
```

## Macos tmux true color suppot

```sh
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz
sudo /usr/bin/tic -xe tmux-256color terminfo.src
sudo /usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src
```

## System-76 laptops
`paru -S sys76-kb`

## ZSA Keyboards on arch
https://github.com/zsa/wally/wiki/Live-training-on-Linux
