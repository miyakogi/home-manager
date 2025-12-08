{ pkgs, ... }: {
  home.packages = with pkgs; [
    quickshell
  ];

  home.file.".config/quickshell/qs-dots" = {
    source = ./qs-dots;
    recursive = true;
  };
}
