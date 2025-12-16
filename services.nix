{ config, ... }: {
  home.file.".local/share/systemd/user" = {
    source = "${config.home.profileDirectory}/share/systemd/user";
    recursive = true;
  };
  home.file.".local/share/systemd/user/waybar-hyprland.service" = {
    source = ./services/waybar-hyprland.service;
  };
  home.file.".local/share/systemd/user/waybar-niri.service" = {
    source = ./services/waybar-niri.service;
  };
}
