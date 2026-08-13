{ pkgs, inputs, ... }: {
  home.packages =  [
    # pkgs.waybar
    inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
