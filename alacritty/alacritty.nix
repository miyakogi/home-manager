{ ... }: {
  programs.alacritty.enable = true;

  home.file.".config/alacritty/alacritty.toml" = {
    source = ./alacritty.toml;
  };
  home.file.".config/alacritty/carbonfox-vivid-oled.toml" = {
    source = ./carbonfox-vivid-oled.toml;
  };
  home.file.".config/alacritty/mikado.toml" = {
    source = ./mikado.toml;
  };
}
