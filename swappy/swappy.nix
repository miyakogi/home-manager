{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
  ];

  programs.swappy.enable = true;

  home.file.".config/swappy/config" = {
    source = ./config;
  };
}
