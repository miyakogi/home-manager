{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop
  ];

  home.file.".conifg/btop/btop.conf" = {
    source = ./btop.conf;
  };
}
