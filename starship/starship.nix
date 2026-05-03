{ ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
  home.file.".config/starship.toml" = {
    source = ./starship.toml;
  };
}
