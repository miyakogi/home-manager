{ pkgs, ... }: {
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   extraConfig = builtins.readFile ./hyprland.conf;
  # };

  home.packages = with pkgs; [
    hyprland
    # xwayland  # -> system
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    hyprpicker
    hyprshutdown
  ];

  home.file.".config/hypr/hyprland.lua" = {
    source = ./hyprland.lua;
  };
  home.file.".config/hypr/kanagawa-dragon.lua" = {
    source = ./kanagawa-dragon.lua;
  };

  home.file.".config/hypr/hyprpaper.conf" = {
    source = ./hyprpaper.conf;
  };
  home.file.".config/hypr/hypridle.conf" = {
    source = ./hypridle.conf;
  };
  home.file.".config/hypr/hyprlock.conf" = {
    source = ./hyprlock.conf;
  };
}
