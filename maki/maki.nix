{ pkgs, inputs, ... }: {
  home.packages = [
    inputs.maki.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home.file.".config/maki/init.lua".source = ./init.lua;
  home.file.".config/maki/permissions.toml".source = ./permissions.toml;
  home.file.".config/maki/AGENTS.md".source = ../agents/AGENTS.md;
}
