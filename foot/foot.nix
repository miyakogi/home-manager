{ pkgs, ... }: {
  home.packages = with pkgs; [
    foot
  ];

  home.file.".config/foot/foot.ini" = {
    source = ./foot.ini;
  };
  home.file.".config/foot/kanagawa-dragon.ini" = {
    source = ./kanagawa-dragon.ini;
  };
}
