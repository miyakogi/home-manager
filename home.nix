{ config, pkgs, ... }:

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

  # Environment Variables
  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$HOME/.nix-profile/bin:$PATH";
    SSL_CERT_FILE = "/etc/ssl/ca-bundle.pem";
    GIT_SSL_CAINFO = "/etc/ssl/ca-bundle.pem";
  };

  # Input Methods
  # i18n.inputMethod = {
  #   type = "fcitx5";
  #   fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  # };

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

  # notification
  # services.mako = {
  #   enable = true;
  #   extraConfig = builtins.readFile ./mako/config;
  # };

  # Install programs
  home.packages = with pkgs; [
    git
    delta
    difftastic
    gh

    fzf
    fd
    jq
    dua

    fastfetch

    wget
    unzip
    libarchive
    unar

    # Dev tools
    rustup
    uv
    ruff
    typos
    typos-lsp

    nixgl.auto.nixGLDefault
    mesa
    libva
    wl-clipboard

    # uwsm
    newt
    app2unit
    xdg-terminal-exec

    # XDG Desktop Portals
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    libnotify

    qt6Packages.qt6ct

    # Utilities
    lxqt.pcmanfm-qt

    # multimedia
    lxqt.pavucontrol-qt
    pulsemixer
    alsa-utils
    playerctl
    mpc
    ffmpegthumbnailer
    imv
    mpv
    gamescope

    # Input Methods
    # fcitx5
    # fcitx5-mozc
    # fcitx5-gtk
    kdePackages.fcitx5-configtool

    # font
    fontconfig
    googlesans-code
    ibm-plex
    noto-fonts
    noto-fonts-cjk-sans

    # Icons
    numix-icon-theme
    qogir-icon-theme
  ];

  imports = [
    ./services.nix
    ./scripts.nix

    ./fish/fish.nix
    ./starship/starship.nix

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
    ./gitui/gitui.nix
    ./macchina/macchina.nix
    ./ripgrep/ripgrep.nix
    ./yazi/yazi.nix
    ./zoxide/zoxide.nix

    ./hypr/hypr.nix
    ./niri/niri.nix

    ./waybar/waybar.nix
    ./quickshell/quickshell.nix

    ./alacritty/alacritty.nix
    ./foot/foot.nix
    ./kitty/kitty.nix
    ./ghostty/ghostty.nix
    ./rio/rio.nix
    ./wezterm/wezterm.nix

    ./fuzzel/fuzzel.nix
    ./tofi/tofi.nix

    ./mako/mako.nix
    ./swappy/swappy.nix
  ];
}
