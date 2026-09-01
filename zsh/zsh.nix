{ pkgs, config, lib, ... }: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    fastSyntaxHighlighting.enable= true;
    shellAliases = {
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        ":q" = "exit";
        "c" = "cd";
        "rm" = "trash put";

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
    };
    siteFunctions = {
      edit = ''
        "$EDITOR" "$@"
      '';
      hx = ''
        command hx "$@"
        pringtf '\033[0 q'
      '';
      gg = ''
        if git rev-parse --is-inside-work-tree &>/dev/null; then
          cd "$PWD"/"$(git rev-parse --show-cdup)" || return
        else
          cd || return
        fi
      '';
      ssh = ''
        printf '\033]11;#140000\a'
        command ssh "$@"
        printf '\033]111\a'
      '';
    };
    initContent = lib.mkMerge [
      (lib.mkOrder 1000 (builtins.readFile ./init.zsh))
      (lib.mkOrder 1500 (builtins.readFile ./extra.zsh))
    ];
  };
}
