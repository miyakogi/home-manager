{ pkgs, inputs, ... }: {
  home.packages = [
    pkgs.blesh
    inputs.seasalt.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.file.".blerc".source = ./blerc.bash;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ $- == *i* && -z ''${BRUSH_VERSION-} ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh
        if command -v seasalt &>/dev/null; then
          eval "$(seasalt init bash)"
        fi
      fi
    '';
    initExtra = builtins.readFile ./init-extra.bash;
  };
}
