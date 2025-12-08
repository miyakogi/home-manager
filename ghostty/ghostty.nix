{ pkgs, ... }: {
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config" = {
    source = ./config;
  };
  home.file.".config/ghostty/themes" = {
    source = ./themes;
    recursive = true;
  };
}
