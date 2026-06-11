{ config, inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv) system;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "miyaco";
  home.homeDirectory = "/home/miyaco";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/miyaco/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # License
  nixpkgs.config.allowUnfree = true;

  # Environment Variables
  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$HOME/.nix-profile/bin:$PATH";
    MANPATH = "${config.home.profileDirectory}/share/man:/usr/share/man";
  };

  # Bash
  programs.bash = {
    enable = true;
  };

  # Input Methods
  services.hazkey = {
    enable = true;
    server.package = inputs.nix-hazkey.packages.${system}.hazkey-server.override { enableVulkan = true; };
  };
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      inputs.nix-hazkey.packages.${pkgs.system}.fcitx5-hazkey
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      kdePackages.fcitx5-qt
      kdePackages.fcitx5-configtool
    ];
  };

  # Keyring
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
      "ssh"
      "pkcs11"
    ];
  };

  # Fonts
  fonts.fontconfig.enable = true;
  gtk = {
    gtk3.font = {
      name = "monospace";
      packages = with pkgs; [ googlesans-code ];
    };
    gtk4.font = {
      name = "monospace";
      packages = with pkgs; [ googlesans-code ];
    };
  };
  xdg.userDirs.extraConfig = {
    "FONT_DIRS" = "${config.home.homeDirectory}/.local/share/fonts:${config.home.homeDirectory}/.nix-profile/share/fonts";
  };

  # Theme
  qt.kvantum = {
    enable = true;
    settings = {
      General = {
        theme = "KvGnomeDark";
      };
    };
  };

  # notification
  # services.mako = {
  #   enable = true;
  #   extraConfig = builtins.readFile ./mako/config;
  # };

  # Install programs
  home.packages = with pkgs; [
    uutils-coreutils-noprefix

    fzf
    fd
    jq
    dua
    tokei
    just

    man-db
    man-pages
    tlrc
    less
    which

    wget
    zip
    unzip
    libarchive
    unar
    ouch

    distrobox
    appimage-run

    # Dev tools
    clang
    nodejs
    pnpm
    cmake
    poetry
    openssl
    #extra-cmake-modules
    libxkbcommon.dev
    pkgconf
    rustup
    mold

    # LSP
    uv
    ruff
    typos
    typos-lsp
    bash-language-server
    lua-language-server
    pyright
    shellcheck
    typescript-language-server
    vscode-css-languageserver

    # AI
    rtk
    radeontop

    # HW accel
    mesa
    libva

    # XDG Desktop Portals
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gnome  # for niri dark theme, see: https://github.com/niri-wm/niri/issues/2878#issuecomment-3573812112

    # Utilities
    xdg-utils
    libnotify
    wl-clipboard-rs
    lxqt.pcmanfm-qt

    # Multimedia
    lxqt.pavucontrol-qt
    pulsemixer
    alsa-utils
    playerctl
    mpc
    ncmpc
    mpdris2-rs
    yt-dlp
    ffmpegthumbnailer
    imv
    gamescope
    ffmpeg
    imagemagick
    libavif
    pngquant
    lsfg-vk
    lsfg-vk-ui
    vulkan-tools
    mangohud
    spotify-player

    # Theme
    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    rose-pine-cursor
    adwaita-icon-theme

    ### Software
    # QMK
    qmk
    avrdude
    dfu-programmer
    dfu-util
    picotool

    ### PKM
    capacities
    taskwarrior3
    taskwarrior-tui
  ];

  imports = [
    # flatpak
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    # haykey flake
    inputs.nix-hazkey.homeModules.hazkey

    ./services.nix
    ./scripts.nix
    ./flatpak/flatpak.nix

    ./fish/fish.nix
    ./brush/brush.nix
    ./man/man.nix
    ./git/git.nix
    ./gpg/gpg.nix

    ./cargo/cargo.nix

    ./nvim/neovim.nix
    ./helix/helix.nix
    ./zellij/zellij.nix

    ./atuin/atuin.nix
    ./bat/bat.nix
    ./bottom/bottom.nix
    ./broot/broot.nix
    ./btop/btop.nix
    ./direnv/direnv.nix
    ./eza/eza.nix
    ./fastfetch/fastfetch.nix
    ./gitui/gitui.nix
    ./lazygit/lazygit.nix
    ./macchina/macchina.nix
    ./ripgrep/ripgrep.nix
    ./starship/starship.nix
    ./yazi/yazi.nix
    ./zmx/zmx.nix
    ./zoxide/zoxide.nix

    ./uwsm/uwsm.nix
    ./hypr/hypr.nix
    ./niri/niri.nix

    ./waybar/waybar.nix
    ./quickshell/quickshell.nix

    ./fontconfig/fontconfig.nix

    ./alacritty/alacritty.nix
    ./foot/foot.nix
    ./kitty/kitty.nix
    ./ghostty/ghostty.nix
    ./rio/rio.nix
    ./wezterm/wezterm.nix

    ./fuzzel/fuzzel.nix
    ./tofi/tofi.nix

    ./mako/mako.nix
    ./swaync/swaync.nix
    ./swappy/swappy.nix

    ./mpv/mpv.nix

    ./opencode/opencode.nix

    ./desktop/desktop.nix
  ];
}
