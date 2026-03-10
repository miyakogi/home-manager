{ ... }: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      default_flags = "-c :open_preview";
    };
  };
}
