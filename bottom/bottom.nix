{ ... }: {
  programs.bottom.enable = true;

  home.file.".config/bottom/bottom.toml" = {
    source = ./bottom.toml;
  };
}
