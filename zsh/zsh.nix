{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    fastSyntaxHighlighting.enable= true;
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = ''
      if command -v seasalt &>/dev/null; then
        eval "$(seasalt init zsh)"
      fi
    '';
  };
}
