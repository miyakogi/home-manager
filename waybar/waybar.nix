{ pkgs, inputs, ... }: {
  programs.waybar = {
    enable = true;
    # Build from the flake input to stay ahead of the nixpkgs version
    # (needed for niri/workspaces -> ignore-workspaces option).
    package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
