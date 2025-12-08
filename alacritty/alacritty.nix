{ pkgs, ... }: {
  home.packages = with pkgs; [
    alacritty
  ];

  home.file.".config/alacritty/alacritty.toml" = {
    source = ./alacritty.toml;
  };
  home.file.".config/alacritty/carbonfox-vivid-oled.toml" = {
    source = ./carbonfox-vivid-oled.toml;
  };
}
