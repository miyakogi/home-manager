{ pkgs, ... }: {
  home.packages = with pkgs; [
    niri
    xwayland-satellite
  ];

  home.file.".config/niri/config.kdl" = {
    source = ./config.kdl;
  };
  home.file.".config/niri/hyprpaper.conf" = {
    source = ./hyprpaper.conf;
  };
}
