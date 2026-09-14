{ pkgs, inputs, ... }:
let
  # Build from the flake input to stay ahead of nixpkgs, with the test
  # suite disabled and only the Wayland backend enabled.
  rio = inputs.rio.packages.${pkgs.stdenv.hostPlatform.system}.rio.overrideAttrs (old: {
    doCheck = false;
    withX11 = false;
    withWayland = true;
  });
in
{
  home.packages = with pkgs; [
    unifont
  ];

  programs.rio = {
    enable = true;
    package = rio;
  };

  xdg.configFile."rio/config.toml" = {
    source = ./config.toml;
  };
  xdg.configFile."rio/themes" = {
    source = ./themes;
    recursive = true;
  };
  xdg.configFile."rio/themes/wm-theme.toml" = {
    source = ./themes/opencode.toml;
  };
  xdg.configFile."rio-hyprland/config.toml" = {
    source = ./config.toml;
  };
  xdg.configFile."rio-hyprland/themes/wm-theme.toml" = {
    source = ./themes/kanagawa-dragon.toml;
  };
  xdg.configFile."rio-niri/config.toml" = {
    source = ./config.toml;
  };
  xdg.configFile."rio-niri/themes/wm-theme.toml" = {
    source = ./themes/bitmute.toml;
  };
}
