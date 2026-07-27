# Wrapped niri compositor for Noctalia.
# Run standalone: nix run .#niri-noctalia
{
  self,
  inputs,
  den,
  ...
}: let
  # TODO: drop once nixos-unstable includes nixpkgs#546004
  # (niri pins libdisplay-info_0_3; the current channel ships
  # libdisplay-info 0.4.0 which libdisplay-info-sys 0.3.0 rejects,
  # breaking the niri build). Applied to BOTH the nixos and homeManager
  # pkgs since home-manager instantiates its own nixpkgs (noctalia's
  # config.toml references ${pkgs.niri} from the HM side).
  niriLibdisplayInfoFix = final: prev: {
    niri = prev.niri.override {libdisplay-info = prev.libdisplay-info_0_2;};
  };
in {
  # ── Standalone package (nix run .#niri-noctalia, scale 1.0) ───────
  perSystem = {pkgs, ...}: {
    packages.niri-noctalia = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.niri-noctalia];
    };
  };

  # ── Aspect: niri + Noctalia on NixOS + home-manager ───────────────
  den.aspects.niri-noctalia = {
    includes = [
      den.aspects.wayland
      den.aspects.wayland-regreet
      den.aspects.noctalia
      # Parametric include: receives {host}, injects per-host scale
      ({host}: {
        nixos = {
          pkgs,
          lib,
          ...
        }: let
          niriPkg = inputs.wrapper-modules.wrappers.niri.wrap {
            inherit pkgs;
            imports = [self.wrappersModules.niri-noctalia];
            settings.outputs."eDP-1".scale = host.display.scale;
          };
        in {
          nixpkgs.overlays = [niriLibdisplayInfoFix];

          programs.niri.enable = true;
          programs.niri.package = niriPkg;
          services.displayManager.defaultSession = lib.mkDefault "niri";
          xdg.portal = {
            enable = true;
            extraPortals = [pkgs.xdg-desktop-portal-gnome];
            # Electron/Chromium apps route custom-scheme opens
            # through the portal's OpenURI chooser,  which on niri fails to match
            # x-scheme-handler/* and shows "No Apps Available".
            # Disabling this makes xdg-open resolve handlers via the desktop DB directly.
            xdgOpenUsePortal = false;
          };
          environment.systemPackages = [pkgs.xwayland-satellite];
        };
      })
    ];

    homeManager = {
      pkgs,
      config,
      ...
    }: let
      # Noctalia v5 binary from the HM module's package (see noctalia.nix).
      noctaliaShell = config.programs.noctalia.package;
      lockScript =
        pkgs.writeShellScript "lock-screen"
        "${noctaliaShell}/bin/noctalia msg session lock";
    in {
      nixpkgs.overlays = [niriLibdisplayInfoFix];

      home.packages = [pkgs.hyprlock pkgs.satty];

      # Suppress the NetworkManager applet under niri. It is pulled in by the
      # COSMIC desktop manager (network-manager-applet ships an XDG autostart
      # file) and its NotShowIn list covers COSMIC/GNOME/KDE but not niri, so it
      # would otherwise spawn an unclickable tray icon. Noctalia provides network
      # status in the bar, so we hide the autostart entry for this user.
      xdg.configFile."autostart/nm-applet.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=NetworkManager Applet
        Exec=nm-applet
        Hidden=true
      '';

      # The Noctalia systemd user service is provided by the HM module via
      # programs.noctalia.systemd.enable (set in noctalia.nix). It binds to the
      # graphical-session target, which niri provides.

      # Belt-and-suspenders lock for external suspend triggers (e.g. lid close,
      # systemctl suspend) that bypass Noctalia's own idle behaviors.
      services.swayidle = {
        enable = true;
        systemdTargets = [config.wayland.systemd.target "graphical-session.target"];
        events = {
          "before-sleep" = "${lockScript}";
          "lock" = "${lockScript}";
        };
      };
    };
  };
}
