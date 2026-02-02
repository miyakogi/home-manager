{ config, ... }: {
  home.file.".local/share/systemd/user" = {
    source = "${config.home.profileDirectory}/share/systemd/user";
    recursive = true;
  };
  home.file.".local/share/systemd/user/hyprland-graphical-session.target" = {
    source = ./services/hyprland-graphical-session.target;
  };
  home.file.".local/share/systemd/user/waybar-hyprland.service" = {
    source = ./services/waybar-hyprland.service;
  };
  home.file.".local/share/systemd/user/waybar-niri.service" = {
    source = ./services/waybar-niri.service;
  };
  home.file.".local/share/systemd/user/fcitx5-flatpak.service" = {
    source = ./services/fcitx5-flatpak.service;
  };
  home.file.".local/share/systemd/user/fcitx5-arch.service" = {
    source = ./services/fcitx5-arch.service;
  };
}
