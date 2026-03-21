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
}
