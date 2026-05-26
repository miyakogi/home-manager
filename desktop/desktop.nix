{ ... }: {
  xdg.desktopEntries = {
    "Video" = {
      name = "Video (Chrome)";
      genericName = "Video player on chrome with gamescope";
      type = "Application";
      icon = "com.google.Chrome";
      exec = "gamescope -f -w 1920 -h 1080 -W 3840 -H 2160 --filter fsr --sharpness 10 --backend wayland --hdr-enabled -- flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chrome --file-forwarding com.google.Chrome";
    };
  };
  xdg.desktopEntries = {
    "Zen-Main" = {
      name = "Zen (Main)";
      type = "Application";
      icon = "app.zen_browser.zen";
      exec = ''flatpak run --branch=stable --arch=x86_64 --command=launch-script.sh --file-forwarding app.zen_browser.zen -P "Default (release)" --name zen-main'';
    };
  };
  xdg.desktopEntries = {
    "Zen-Sub" = {
      name = "Zen (Sub)";
      type = "Application";
      icon = "app.zen_browser.zen";
      exec = "flatpak run --branch=stable --arch=x86_64 --command=launch-script.sh --file-forwarding app.zen_browser.zen -P Sub --name zen-sub";
    };
  };
  xdg.desktopEntries = {
    "com.tutanota.Tutanota" = {
      name = "Tuta (Mail)";
      type = "Application";
      icon = "com.tutanota.Tutanota";
      exec = "flatpak run --branch=stable --arch=x86_64 --command=tutanota-desktop --file-forwarding com.tutanota.Tutanota --force-device-scale-factor=1.5 --ozone-platform=wayland @@u %U @@";
    };
  };
  xdg.desktopEntries = {
    "md.obsidian.Obsidian" = {
      name = "Obsidian";
      type = "Application";
      icon = "md.obsidian.Obsidian";
      exec = "flatpak run --branch=stable --arch=x86_64 --command=obsidian.sh --file-forwarding md.obsidian.Obsidian --force-device-scale-factor=1.5 --ozone-platform=wayland @@u %U @@";
    };
  };
  xdg.desktopEntries = {
    "capacities" = {
      name = "Capacities";
      type = "Application";
      icon = "capacities";
      exec = "capacities --no-sandbox --force-device-scale-factor=1.5 --ozone-platform=wayland";
    };
  };
  xdg.desktopEntries = {
    "com.ticktick.TickTick" = {
      name = "TickTick";
      type = "Application";
      icon = "com.ticktick.TickTick";
      exec = "flatpak run --branch=stable --arch=x86_64 --command=ticktick --file-forwarding com.ticktick.TickTick --force-device-scale-factor=2 --ozone-platform=wayland @@u %U @@";
    };
  };
  xdg.desktopEntries = {
    # GMetronome (flatpak)
    "org.gnome.gitlab.dqpb.GMetronome" = {
      name = "GMetronome";
      type = "Application";
      icon = "org.gnome.gitlab.dqpb.GMetronome";
      exec = "flatpak run --branch=stable --arch=x86_64 --command=gmetronome --env=GDK_SCALE=2 --env=GDK_DPI_SCALE=2.0 org.gnome.gitlab.dqpb.GMetronome";
    };
  };
  xdg.desktopEntries = {
    "spotify-player" = {
      name = "Spotify Player";
      type = "Application";
      icon = "com.spotify.Client";
      exec = ''wezterm start --class spotify-player zmx attach spotify-player bash -c "sleep 0.3s && spotify_player"'';
    };
  };
}
