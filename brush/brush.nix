{ pkgs, ... }: {
  home.packages = with pkgs; [
    brush
  ];

  home.file.".brushrc".source = ./brushrc;
}
