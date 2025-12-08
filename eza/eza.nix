{ ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--sort" "Filename"
      "--group"
      "--time-style" "+%Y-%m-%d %H:%M"
    ];
  };
}
