{ ... }: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.file.".config/wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };
}
