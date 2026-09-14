{ ... }: {
  programs.tofi.enable = true;

  home.file.".config/tofi/config" = {
    source = ./config;
  };
}
