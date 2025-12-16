{ pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-tty;
      program = "pinentry-tty";
    };
  };
}

