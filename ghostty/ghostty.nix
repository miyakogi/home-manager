{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    systemd.enable = true;
    settings = {
      font-family = [ "Google Sans Code" "IBM Plex Sans JP" ];
      font-size = 15.0;

      font-variation = "wght=300";
      font-variation-bold = "wght=600";
      font-variation-italic = "wght=300";
      font-variation-bold-italic = "wght=600";

      theme = "kanagawa-dragon";
      background-opacity = 0.92;

      command = "fish";

      shell-integration = "fish";
      shell-integration-features = "cursor,sudo,no-title";

      window-inherit-working-directory = false;
      working-directory = "home";

      cursor-style = "block";
      cursor-style-blink = false;
      cursor-opacity = 0.9;

      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;

      quit-after-last-window-closed = false;
    };
  };
  home.file.".config/ghostty/themes" = {
    source = ./themes;
    recursive = true;
  };
}
