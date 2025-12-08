{ ... }: {
  home.file.".local/share/systemd/user" = {
    source = ./services;
    recursive = true;
  };
}
