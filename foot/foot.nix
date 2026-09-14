{ ... }: {
  programs.foot.enable = true;

  xdg.configFile."foot/foot.ini" = {
    source = ./foot.ini;
  };
  xdg.configFile."foot/mikado.ini" = {
    source = ./mikado.ini;
  };
}
