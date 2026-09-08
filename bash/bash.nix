{ pkgs, inputs, ... }: {
  home.packages = [
    pkgs.blesh
  ];

  home.file.".blerc".source = ./blerc.bash;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ $- == *i* && -z ''${BRUSH_VERSION-} ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh
      fi
    '';
    initExtra = builtins.readFile ./init-extra.bash;
  };
}
