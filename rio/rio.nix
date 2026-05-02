{ pkgs, inputs, ... }:
let
  rio = inputs.rio.packages.${pkgs.system}.rio.overrideAttrs (old: {
      doCheck = false;
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.shaderc ];
    });
in {
  home.packages = with pkgs; [
    unifont
    lilex
    glslang  # for build
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
