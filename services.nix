{ config, ... }: {
  home.file.".local/share/systemd/user" = {
    source = "${config.home.profileDirectory}/share/systemd/user";
    recursive = true;
  };
  home.file.".local/share/systemd/user/hyprland-graphical-session.target" = {
    source = ./services/hyprland-graphical-session.target;
  };
  home.file.".local/share/systemd/user/niri-graphical-session.target" = {
    source = ./services/niri-graphical-session.target;
  };
  home.file.".local/share/systemd/user/ollama.service" = {
    source = ./services/ollama.service;
  };
  home.file.".local/share/systemd/user/hypridle-hyprland.service" = {
    source = ./services/hypridle-hyprland.service;
  };
  home.file.".local/share/systemd/user/swayidle-niri.service" = {
    source = ./services/swayidle-niri.service;
  };
  home.file.".local/share/systemd/user/waybar-hyprland.service" = {
    source = ./services/waybar-hyprland.service;
  };
  home.file.".local/share/systemd/user/waybar-niri.service" = {
    source = ./services/waybar-niri.service;
  };
  home.file.".local/share/systemd/user/taskwarrior-notify.service" = {
    source = ./services/taskwarrior-notify.service;
  };
  home.file.".local/share/systemd/user/taskwarrior-notify.timer" = {
    source = ./services/taskwarrior-notify.timer;
  };
  home.file.".local/share/systemd/user/taskwarrior-notify-daily.service" = {
    source = ./services/taskwarrior-notify-daily.service;
  };
  home.file.".local/share/systemd/user/taskwarrior-notify-daily.timer" = {
    source = ./services/taskwarrior-notify-daily.timer;
  };
}
