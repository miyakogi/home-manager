{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    unifont
  ];

  programs.rio = {
    enable = true;
    package = inputs.rio.packages.${pkgs.system}.rio;
  };

  home.file.".config/rio/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio/themes" = {
    source = ./themes;
    recursive = true;
  };
}
