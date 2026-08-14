{ pkgs, ... }: {
  home.packages = with pkgs; [
    blesh
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      [[ $- == *i* ]] && source ${pkgs.blesh}/share/blesh/ble.sh
    '';
  };
}
