{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim
  ];

  home.file.".config/nvim/init.lua" = {
    source = ./init.lua;
  };
  home.file.".config/nvim/manrc" = {
    source = ./manrc;
  };
  home.file.".config/nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
  home.file.".config/nvim/after" = {
    source = ./after;
    recursive = true;
  };
  home.file.".config/nvim/ftplugin" = {
    source = ./ftplugin;
    recursive = true;
  };
  home.file.".config/nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };

}
