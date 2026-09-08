{ ... }: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      enter_accept = false;
      search_mode = "daemon-fuzzy";
      search = {
        shells = "all";
        filters = [
          "directory"
          "session"
          "global"
          "host"
        ];
      };
      ai = {
        enabled = true;
      };
      daemon = {
        enabled = true;
        autostart = true;
      };
    };
  };
}
