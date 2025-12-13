{ ... }: {
  home.file.".config/fish/functions" = {
    source = ./functions;
    recursive = true;
  };
  home.file.".config/fish/themes" = {
    source = ./themes;
    recursive = true;
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      ":q" = "exit";

      c = "cd";

      l = "ls";
      lsa = "ls --all";
      lsl = "ls -l -h";
      lsal = "ls --all -l -h";

      ln = "ln -s -v";

      mv = "mv -i";

      mkdir = "mkdir -p";

      e = "edit";
      n = "nvim";
      h = "hx";

      gstatus = "git status -s -b";

      t = "btop";
      b = "btm";
    };

    functions = {
      fish_greeting = "";
    };

    shellInit = ''
      bind ctrl-w backward-kill-word
      bind \b backward-kill-word
      bind ctrl-y 'commandline "cd ../" ; commandline -f execute'
      bind ctrl-j myjump
      bind ctrl-f nextd-or-forward-word
      if [ -n "$ZELLIJ" ]; bind ctrl-d delete-char; end
    '';

    loginShellInit = ''
      export SSL_CERT_FILE="/etc/ssl/ca-bundle.pem"
      export GIT_SSL_CAINFO="/etc/ssl/ca-bundle.pem"

      fish_add_path --global "$HOME/.nix-profile/bin"
      fish_add_path --global "$HOME/.local/bin"
      fish_add_path --global "$HOME/.cargo/bin"
      fish_add_path --global --move "$HOME/bin"

      export GOPATH="$HOME/.go"
      export RUST_SRC_PATH="(rustc --print sysroot)/lib/rustlib/src/rust/src"

      export EDITOR=nvim
      export MANPAGER="nvim +Man! -u $HOME/.config/nvim/manrc"

      export LESS="-iFRSM"
      export SYSTEMD_LESS="-iFRSM"

      set -gx XDG_DATA_DIRS ~/.nix-profile/share ~/.local/share /usr/local/share /usr/share $XDG_DATA_DIRS

      # Zoxide option
      set -x _ZO_FZF_OPTS "--bind=ctrl-z:ignore --exit-0 --height=40% --info=inline --no-sort --reverse --select-1 --exact"

      ### Login on TTY1
      if test -z "$DISPLAY"; and test "$XDG_VTNR" = 1; and begin test -z "$XDG_SESSION_TYPE"; or test "$XDG_SESSION_TYPE" = tty; end
        echo -e -n "\
      Select Window Manager of Shell:
      > 1) Hyprland [default]
        2) Niri
        3) bash
        4) fish
        5) exit
        *) any executable
      "
        read -P '>>> ' choice

        # set default wm candidate
        if test -z "$choice"
          set choice 1
        end

        switch "$choice"
          case 1 "[Hh]ypr"
            set wm "Hyprland"
          case 2 "[Nn]iri"
            set wm "niri"
          case 3 bash sh
            exec bash
          case 4 fish
            exec fish
          case 5 exit
            exit 0
          case *
            set wm "$choice"
        end

        if ! command -q uwsm
          export GTK_THEME=Adwaita:dark
          export GTK_USE_PORTAL=1

          export QT_QPA_PLATFORMTHEME=qt6ct
          export QT_QPA_PLATFORM="wayland;xcb"

          export XMODIFIERS=@im=fcitx
          export GTK_IM_MODULE=fcitx
          export QT_IM_MODULE=fcitx
          export GLFW_IM_MODULE=fcitx

          export GST_VAAPI_ALL_DRIVERS=1

          # hyprland
          export AQ_NO_MODIFIERS=0

          # sway
          export WLR_DRM_NO_MODIFIERS=1

          # app2unit
          export APP2UNIT_SLICES='a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice'

          # XDG
          export XDG_CURRENT_DESKTOP=$wm
          export XDG_SESSION_TYPE=wayland
        end

        # Start wayland session
        if string match -r -q '(Hyprland|sway|river|niri|weston)' "$wm"
          wm-start $wm
        else
          wm-start $wm
        end
      end
    '';

    interactiveShellInit = ''
      set -x GPG_TTY (tty)

      # auto ls on cd
      function __auto_ls --on-variable PWD; ls; end

      # ls color setting
      set -x LSCOLORS Exfxcxdxbxegedabagacad
      set -x LS_COLORS 'di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

      # macchina
      if type -q macchina
        macchina
      end

      # load machine local setting
      if test -f ~/.config/fish/local.fish
        source ~/.config/fish/local.fish
      end
    '';
  };
}
