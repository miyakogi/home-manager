{ pkgs, inputs, ... }:
let
  zmx = inputs.zmx.packages.${pkgs.system}.default;
in {
  home.packages = [
    zmx
  ];
}
