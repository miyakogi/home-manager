#!/usr/bin/env fish

function wm-start
  if type -q uwsm
    if test "$argv[1]" = "Hyprland"
      exec uwsm start hyprland.desktop
    else if "$argv[1]" = "niri"
      exec uwsm start niri
    else
      exec uwsm start (string lower $argv[1]).desktop
    end
  else if test "$argv[1]" = "Hyprland"
    exec start-hyprland
  else if test "$argv[1]" = "niri"
    exec niri-session
  else
    exec $argv[1]
  end
end
