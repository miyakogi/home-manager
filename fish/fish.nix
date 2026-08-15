{ pkgs, ... }: {
  home.file.".config/fish/functions" = {
    source = ./functions;
    recursive = true;
  };
  home.file.".config/fish/themes" = {
    source = ./themes;
    recursive = true;
  };

  # improved completion
  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;  # conflict with brush and blesh
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      ":q" = "exit";

      c = "cd";

      rm = "trash put";

      l = "ls";
      lsa = "ls --all";
      lsl = "ls -l -h";
      lsal = "ls --all -l -h";

      ln = "ln -s -v";

      e = "edit";
      n = "nvim";
      h = "hx";

      gstatus = "git status -s -b";

      t = "btop";
      b = "btm";
    };

    shellAliases = {
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
    };

    functions = {
      fish_greeting = ''
        if ! status is-login
          if type -q fastfetch
            fastfetch --config config-short.jsonc
          else if type -q macchina
            macchina
          end
        end
      '';
      __auto_ls = {
        onVariable = "PWD";
        body = "ls";
      };
    };

    binds = {
      "ctrl-w".command = "backward-kill-word";
      "ctrl-backspace".command = "backward-kill-word";
      "ctrl-y".command = [ "commandline \"cd ../\"" "commandline -f execute" ];
      "ctrl-j".command = "myjump";
      "ctrl-f".command = "nextd-or-forward-word";
    };

    plugins = [
      { name = "done"; src = pkgs.fishPlugins.done.src; }
    ];

    shellInit = ''
      if [ -n "$ZELLIJ" ]; bind ctrl-d delete-char; end
    '';

    loginShellInit = builtins.readFile ./login-shell.fish;
    interactiveShellInit = builtins.readFile ./interactive-shell.fish;
  };
}
