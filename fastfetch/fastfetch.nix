{ pkgs, ... }: {
  programs.fastfetch = {
    enable = true;
    # package = null;  # use system's package to support librpm package manager.
  };
  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
  home.file.".config/fastfetch/config-short.jsonc".source = ./config-short.jsonc;
}
