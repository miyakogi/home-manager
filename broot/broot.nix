{ ... }: {
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      default_flags = "-c :open_preview";
      kitty_graphics_transmission = "chunks";
      kitty_graphics_display = "direct";
    };
  };
}
