{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${system}.default;
  };

  xdg.configFile."helix/config.toml" = {
    source = ./config.toml;
  };
  xdg.configFile."helix/languages.toml" = {
    source = ./languages.toml;
  };
  xdg.configFile."helix/themes" = {
    source = ./themes;
    recursive = true;
  };
}
