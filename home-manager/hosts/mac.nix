
{
  imports = [ ./../common.nix ];

  home = {
    username = "ericpuentes";
    homeDirectory = "/Users/ericpuentes";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
