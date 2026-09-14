{ ... }: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  home.file.".config/zellij/config.kdl" = {
    source = ./config.kdl;
  };
}
