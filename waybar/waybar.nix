{ pkgs, inputs, ... }: {
  home.packages = [
    # Build from the flake input to stay ahead of the nixpkgs version
    # (needed for niri/workspaces -> ignore-workspaces option).
    inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
