#!/usr/bin/env fish

function wm-start
  if command -q uwsm
    exec uwsm start (string lower $argv[1]).desktop
  else if test "$argv[1]" = "Hyprland"
    exec start-hyprland
  else if test $argv[1] = niri
    exec niri-session
  else
    exec $argv[1]
  end
end
