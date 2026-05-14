{ ... }: {
  services.flatpak = {
    enable = true;
    packages = [
      ### Browser
      # Firefox
      "org.mozilla.firefox"           # Firefox
      "app.zen_browser.zen"           # Zen

      # Chromium
      "org.chromium.Chromium"         # Chromium
      "com.google.Chrome"             # Google Chrome
      "com.brave.Browser"             # Brave
      "com.vivaldi.Vivaldi"           # Vivaldi

      ### Tools
      # Flatpak Management
      "com.github.tchx84.Flatseal"    # Flatseal

      # Note Taking
      "com.logseq.Logseq"             # Logseq
      "md.obsidian.Obsidian"          # Obsidian

      ### Multimedia
      # Music Player
      "com.spotify.Client"            # Spotify

      # Game
      "com.valvesoftware.Steam"       # Steam
      "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"  # Proton-GE

      # Others
      "org.gnome.gitlab.dqpb.GMetronome"  # GMetronome
      "org.kde.krita"                 # Krita
    ];
  };
}
