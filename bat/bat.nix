{ ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
      italic-text = "always";
      map-syntax = [
        "*.conf:INI"
      ];
    };
  };

  home.file.".config/bat/themes" = {
    source = ./themes;
    recursive = true;
  };
}
