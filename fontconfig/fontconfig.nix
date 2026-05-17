{ pkgs, ... }: {
  home.packages = with pkgs; [
    fontconfig

    # font
    googlesans-code
    lilex
    ibm-plex
    noto-fonts
    noto-fonts-cjk-sans
  ];

  home.file.".config/fontconfig/conf.d" = {
    source = ./conf.d;
    recursive = true;
  };
}
