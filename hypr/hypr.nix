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
  ];

  home.file.".config/hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };
  home.file.".config/hypr/kanagawa-dragon.conf" = {
    source = ./kanagawa-dragon.conf;
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
