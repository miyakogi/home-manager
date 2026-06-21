{ pkgs, ... }: {
  home.packages = with pkgs; [
    kitty
  ];

  home.file.".config/kitty/kitty.conf" = {
    source = ./kitty.conf;
  };
  home.file.".config/kitty/kanagawa_dragon.conf" = {
    source = ./kanagawa_dragon.conf;
  };
  home.file.".config/kitty/mikado.conf" = {
    source = ./mikado.conf;
  };
  home.file.".config/kitty/hybrid.conf" = {
    source = ./hybrid.conf;
  };
  home.file.".config/kitty/opencode.conf" = {
    source = ./opencode.conf;
  };
}
