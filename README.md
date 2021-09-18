# Dotfiles
My configs

## Dependencies for instalation
### stow
MacOS: `brew install stow`
Arch based: `paru -S stow`
### $DOTFILES variable
`export DOTFILES="$HOME/.dotfiles"`

## Install
There should not be en existing file where stow tries to create the symlink
`chmod +x ./install && ./install`

## Uninstall
`chmod +x ./clean && ./clean`


## Nvim optional requirements for telescope
* fd
* ripgrep
* bat
Arch based: `paru -S fd ripgrep bat`
MacOS: `brew install fd rigprep bat`

## Fonts
* Nerd fonts fira code
* Nerd fonts Jetbrans mono
* Noto fonts emoji (for arch)
Arch based: `paru -S nerd-fonts-fira-code nerd-fonts-jetbrains-mono noto-fonts-emoji`
MacOS:
`brew tap homebrew/cask-fonts`
`brew install --cask font-fira-code-nerd-font`
`brew install --cask font-jetbrains-mono-nerd-font`

## Macos tmux true color suppot
`curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz`
`sudo /usr/bin/tic -xe tmux-256color terminfo.src`
`sudo /usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src`

## System-76 laptops
`paru -S sys76-kb`

## ZSA Keyboards on arch
https://github.com/zsa/wally/wiki/Live-training-on-Linux
