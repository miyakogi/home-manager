{ pkgs, ... }: {
  home.packages = with pkgs; [
    helix
  ];

  home.file.".config/helix/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/helix/languages.toml" = {
    source = ./languages.toml;
  };
  home.file.".config/helix/themes" = {
    source = ./themes;
  };
}
