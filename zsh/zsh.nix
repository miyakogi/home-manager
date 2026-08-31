{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    fastSyntaxHighlighting.enable= true;
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = ''
      : "''${DONE_MIN_CMD_DURATION:=5}"
      if [ -f "$HOME/bin/done-shared.sh" ]; then
        source "$HOME/bin/done-shared.sh"
      fi

      if command -v seasalt &>/dev/null; then
        eval "$(seasalt init zsh)"
      fi
    '';
  };
}
