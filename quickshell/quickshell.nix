{ ... }: {
  programs.quickshell.enable = true;

  home.file.".config/quickshell/qs-dots" = {
    source = ./qs-dots;
    recursive = true;
  };
}
