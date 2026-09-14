{ ... }: {
  programs.neovim = {
    enable = true;
    # Keep managing ~/.config/nvim/init.lua via xdg.configFile (see below): load the
    # generated provider setup through wrapper args instead of generating a
    # conflicting init.lua.
    sideloadInitLua = true;
    withRuby = false;
    withPython3 = true;
  };

  xdg.configFile."nvim/init.lua" = {
    source = ./init.lua;
  };
  xdg.configFile."nvim/manrc" = {
    source = ./manrc;
  };
  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
  xdg.configFile."nvim/after" = {
    source = ./after;
    recursive = true;
  };
  xdg.configFile."nvim/ftplugin" = {
    source = ./ftplugin;
    recursive = true;
  };
  xdg.configFile."nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };

}
