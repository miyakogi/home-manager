{ ... }: {
  programs.neovim = {
    enable = true;
    # Keep managing ~/.config/nvim/init.lua via home.file (see below): load the
    # generated provider setup through wrapper args instead of generating a
    # conflicting init.lua.
    sideloadInitLua = true;
  };

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
