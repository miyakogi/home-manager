{ pkgs, ... }: {
  home.packages = with pkgs; [
    cursor-cli
  ];

  home.file.".agents/AGENTS.md".source = ./AGENTS.md;
}
