{ pkgs, inputs, ... }: {
  home.packages = [
    pkgs.blesh
    inputs.seasalt.packages.${pkgs.system}.default
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
    initExtra = builtins.readFile ./init-extra.bash;
  };
}
