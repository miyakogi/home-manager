{ pkgs, inputs, ... }:
let
  rio = inputs.rio.packages.${pkgs.stdenv.hostPlatform.system}.rio.overrideAttrs (old: {
      doCheck = false;
      withX11 = false;
      withWayland = true;
    });
in {
  home.packages = with pkgs; [
    unifont
  ];

  programs.rio = {
    enable = true;
    package = rio;
  };

  home.file.".config/rio/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio/themes" = {
    source = ./themes;
    recursive = true;
  };
  home.file.".config/rio/themes/wm-theme.toml" = {
    source = ./themes/opencode.toml;
  };
  home.file.".config/rio-hyprland/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio-hyprland/themes/wm-theme.toml" = {
    source = ./themes/kanagawa-dragon.toml;
  };
  home.file.".config/rio-niri/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio-niri/themes/wm-theme.toml" = {
    source = ./themes/blackmetal-ash.toml;
  };
}
