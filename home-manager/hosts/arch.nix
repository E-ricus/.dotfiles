
{
  imports = [ ./../common.nix ];

  home = {
    username = "ericus";
    homeDirectory = "/home/ericus";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
