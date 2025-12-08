{ pkgs, ... }: {
  home.packages = with pkgs; [
    bottom
  ];

  home.file.".config/bottom/bottom.toml" = {
    source = ./bottom.toml;
  };
}
