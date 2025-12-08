{ pkgs, ... }: {
  home.packages = with pkgs; [
    rio
    unifont
  ];

  home.file.".config/rio/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio/themes" = {
    source = ./themes;
    recursive = true;
  };
}
