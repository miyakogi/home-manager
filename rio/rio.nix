{ pkgs, inputs, ... }:
let
  rio = inputs.rio.packages.${pkgs.system}.rio.overrideAttrs (_: {
      doCheck = false;
    });
in {
  home.packages = with pkgs; [
    unifont
  ];

  programs.rio = {
    enable = true;
    package = rio;
  };

  home.file.".config/rio/config.toml" = {
    source = ./config.toml;
  };
  home.file.".config/rio/themes" = {
    source = ./themes;
    recursive = true;
  };
}
