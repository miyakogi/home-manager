{ ... }: {
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--sort" "Filename"
      "--group"
      "--time-style" "long-iso"
    ];
  };
}
