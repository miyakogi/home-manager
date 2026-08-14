{ pkgs, ... }: {
  home.packages = with pkgs; [
    blesh
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ $- == *i* && -z ''${BRUSH_VERSION-} ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh
        ${builtins.readFile ./interactive-shell.bash}
      fi
    '';
  };
}
