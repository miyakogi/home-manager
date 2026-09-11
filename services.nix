{ ... }: {
  home.file.".local/share/systemd/user/hyprland-graphical-session.target" = {
    source = ./services/hyprland-graphical-session.target;
  };
  home.file.".local/share/systemd/user/niri-graphical-session.target" = {
    source = ./services/niri-graphical-session.target;
  };
}
