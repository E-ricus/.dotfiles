
{ pkgs, ... }: {
  imports = [
    ./modules/starship.nix
    ./modules/fish.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/tmux.nix
  ];

  home.packages = with pkgs; [
    eza
    fzf
    bat
    fd
    ripgrep
    zoxide
  ];
}
