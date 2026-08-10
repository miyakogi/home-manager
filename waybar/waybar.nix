{ pkgs, inputs, ... }: {
  home.packages =  [
    # pkgs.waybar
    inputs.waybar.packages.${pkgs.system}.default
  ];

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
