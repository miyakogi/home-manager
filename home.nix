{ config, inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
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
    PATH = "$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.nix-profile/bin:$PATH";
    DRI_PRIME = "1";
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";  # global npm install
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
      inputs.nix-hazkey.packages.${system}.fcitx5-hazkey
      # inputs.karukan.packages.${system}.default
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

  # Portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome  # for niri dark theme, see: https://github.com/niri-wm/niri/issues/2878#issuecomment-3573812112
    ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
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


  # Install programs
  home.packages = with pkgs; [
    # ── System / Core ───────────────────────────────────
    curl
    less
    uutils-coreutils-noprefix
    wget
    which

    # ── Documentation ───────────────────────────────────
    man-db
    man-pages
    tlrc

    # ── Archives & Files ────────────────────────────────
    libarchive
    ouch
    unar
    unzip
    zip

    # ── CLI Essentials ──────────────────────────────────
    dua
    fd
    fzf
    jq
    just
    tokei
    trashy
    zmx  # terminal session manager

    # ── Container / Isolation ───────────────────────────
    appimage-run
    bubblewrap
    distrobox

    # ── Toolchain / Runtime ─────────────────────────────
    clang
    lua
    nodejs
    pnpm
    poetry
    rustup
    uv

    # ── Build / Libs ────────────────────────────────────
    cmake
    libxkbcommon.dev
    mold
    openssl
    pkgconf

    # ── Benchmark / Coverage ────────────────────────────
    cargo-llvm-cov
    hyperfine

    # ── Linter / Formatter ──────────────────────────────
    ruff
    shellharden
    typos

    # ── Language Servers ────────────────────────────────
    bash-language-server
    lua-language-server
    pyright
    typescript-language-server
    typos-lsp
    vscode-css-languageserver

    # ── AI / Inference ──────────────────────────────────
    ollama-vulkan

    # ── Graphics / GPU ──────────────────────────────────
    libva
    mesa
    nvtopPackages.full
    radeontop
    vulkan-tools

    # ── Desktop / Wayland ───────────────────────────────
    libnotify
    lxqt.pcmanfm-qt
    wl-clipboard-rs
    xdg-utils

    # ── Audio / Music ───────────────────────────────────
    alsa-utils
    lxqt.pavucontrol-qt
    mpc
    ncmpc
    playerctl
    pulsemixer
    spotify-player

    # ── Video ───────────────────────────────────────────
    ffmpeg
    ffmpegthumbnailer
    yt-dlp

    # ── Image ───────────────────────────────────────────
    imagemagick
    imv
    libavif
    pngquant

    # ── Gaming ──────────────────────────────────────────
    gamescope
    lsfg-vk
    lsfg-vk-ui
    mangohud
    prismlauncher

    # ── Theming ─────────────────────────────────────────
    adwaita-icon-theme
    kdePackages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    rose-pine-cursor

    # ── Hardware / QMK ──────────────────────────────────
    avrdude
    dfu-programmer
    dfu-util
    picotool
    qmk

    # ── Productivity ────────────────────────────────────
    #capacities  # TODO: disabled due to build error -- PKM
    taskwarrior3
    taskwarrior-tui
  ] ++ [
    # ── Flake Packages ──────────────────────────────────
    # without pkgs prefix: packages from inputs.* go here
    # example: inputs.karukan.packages.${system}.default
  ];

  imports = [
    # flatpak
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    # haykey flake
    inputs.nix-hazkey.homeModules.hazkey

    ./services.nix
    ./scripts.nix
    ./flatpak/flatpak.nix

    ./bash/bash.nix
    ./fish/fish.nix
    ./zsh/zsh.nix
    # ./brush/brush.nix
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
    ./zoxide/zoxide.nix

    ./uwsm/uwsm.nix
    ./hypr/hypr.nix
    ./niri/niri.nix

    ./waybar/waybar.nix
    ./quickshell/quickshell.nix

    ./fontconfig/fontconfig.nix

    ./alacritty/alacritty.nix
    ./foot/foot.nix
    ./ghostty/ghostty.nix
    ./kitty/kitty.nix
    ./rio/rio.nix
    ./wezterm/wezterm.nix

    ./fuzzel/fuzzel.nix
    ./tofi/tofi.nix

    ./swaync/swaync.nix
    ./swappy/swappy.nix

    ./mpv/mpv.nix

    ./agents/agents.nix
    ./opencode/opencode.nix
    # ./pi/pi.nix
    # ./maki/maki.nix
    ./herdr/herdr.nix

    ./desktop/desktop.nix
  ];
}
