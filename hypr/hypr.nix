{ pkgs, ... }: {
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

  xdg.configFile."hypr/hyprland.lua" = {
    source = ./hyprland.lua;
  };
  xdg.configFile."hypr/kanagawa-dragon.lua" = {
    source = ./kanagawa-dragon.lua;
  };

  xdg.configFile."hypr/hyprpaper.conf" = {
    source = ./hyprpaper.conf;
  };
  xdg.configFile."hypr/hypridle.conf" = {
    source = ./hypridle.conf;
  };
  xdg.configFile."hypr/hyprlock.conf" = {
    source = ./hyprlock.conf;
  };
}
