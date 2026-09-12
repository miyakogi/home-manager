{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".local/share/systemd/user" = {
    source = pkgs.symlinkJoin {
      name = "systemd-user-units";
      paths = map (p: p + "/share/systemd/user") (
        lib.filter (p: lib.pathExists (p + "/share/systemd/user")) config.home.packages
      );
    };
    recursive = true;
  };
}
