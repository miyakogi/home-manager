{ pkgs, ... }: {
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    swaybg  # for overview backdrop
  ];

  home.file.".config/niri/config.kdl" = {
    source = ./config.kdl;
  };
  home.file.".config/niri/hyprpaper.conf" = {
    source = ./hyprpaper.conf;
  };
}
