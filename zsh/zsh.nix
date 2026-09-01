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
    };
    initContent = let
      zshConfig = lib.mkOrder 1000 ''
        ### KeyBind
        # Base config
        autoload -Uz select-word-style
        select-word-style bash

        # Ctrl-Y
        cd-up() {
          BUFFER="cd ../"
          zle accept-line
        }
        zle -N cd-up
        bindkey '^Y' cd-up
      '';
      zshExtra = lib.mkOrder 1500 ''
        ### autocmd
        chpwd() {
          ls
        }
        ### function
        tree() {
          ls --tree 2>/dev/null || command tree
        }

        # Load Plugins
        : "''${DONE_MIN_CMD_DURATION:=5}"
        if [ -f "$HOME/bin/done-shared.sh" ]; then
          source "$HOME/bin/done-shared.sh"
        fi

        if command -v seasalt &>/dev/null; then
          eval "$(seasalt init zsh)"
        fi

        if command -v fastfetch &>/dev/null; then
          fastfetch --config config-short.jsonc
        elif command -v macchina &>/dev/null; then
          macchina
        fi
      '';
    in
    lib.mkMerge [ zshConfig zshExtra ];
  };
}
