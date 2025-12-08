{ pkgs, ... }: {
  home.packages = with pkgs; [
    macchina
  ];
  home.file.".config/macchina/macchina.toml" = {
    source = ./macchina.toml;
  };
  home.file.".config/macchina/themes" = {
    source = ./themes;
    recursive = true;
  };
}
