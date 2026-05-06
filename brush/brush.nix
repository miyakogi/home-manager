{ pkgs, ... }: {
  home.packages = with pkgs; [
    brush
  ];

  home.file.".brushrc".source = ./brushrc;
  home.file.".config/brush/config.toml".source = ./config.toml;
}
