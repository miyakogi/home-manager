{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
    swappy
  ];

  home.file.".config/swappy/config" = {
    source = ./config;
  };
}
