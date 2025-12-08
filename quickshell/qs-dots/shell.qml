import Quickshell

ShellRoot {

  property var color: Quickshell.env("XDG_CURRENT_DESKTOP").includes("niri") ? "#181616" : "#181616"

  Desktop {
    screenName: "DP-2"
    desktopColor: color
  }

  Desktop {
    screenName: "HDMI-A-3"
    desktopColor: color
  }
}
