{ pkgs, ... }: {
  home.packages = [
    pkgs.blesh
  ];

  home.file.".config/blesh/init.sh".source = ./blerc.bash;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ $- == *i* ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh
      fi
    '';
    initExtra = builtins.readFile ./init-extra.bash;
  };
}
