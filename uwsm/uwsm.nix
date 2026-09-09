{ pkgs, ... }: {
  home.packages = with pkgs; [
    uwsm
    newt
    app2unit
    xdg-terminal-exec
  ];
  home.file.".config/uwsm/env" = {
    source = ./env;
  };
  home.file.".config/uwsm/env-hyprland" = {
    source = ./env-hyprland;
  };
  home.file.".config/uwsm/env-niri" = {
    source = ./env-niri;
  };
}
