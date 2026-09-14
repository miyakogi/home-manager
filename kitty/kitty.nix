{ pkgs, ... }: {
  home.packages = with pkgs; [
    kitty
  ];

  xdg.configFile."kitty/kitty.conf" = {
    source = ./kitty.conf;
  };
  xdg.configFile."kitty/blackmetal-ash.conf" = {
    source = ./blackmetal-ash.conf;
  };
  xdg.configFile."kitty/hybrid.conf" = {
    source = ./hybrid.conf;
  };
  xdg.configFile."kitty/kanagawa_dragon.conf" = {
    source = ./kanagawa_dragon.conf;
  };
  xdg.configFile."kitty/mikado.conf" = {
    source = ./mikado.conf;
  };
  xdg.configFile."kitty/opencode.conf" = {
    source = ./opencode.conf;
  };
}
