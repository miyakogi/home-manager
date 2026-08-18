if [ "$XDG_CURRENT_DESKTOP" = niri ] && [ "$TERM" != xterm-ghostty ]
  exec bash
end

set -x GPG_TTY (tty)

# need to activate auto ls function
type -q __auto_ls

# ls color setting
set -x LSCOLORS Exfxcxdxbxegedabagacad
set -x LS_COLORS 'di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=46;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# image viewer
switch $TERM
  case kitty xterm-ghostty xterm-rio
    alias img="kitten icat"
  case wezterm
    alias img="wezterm imgcat"
end

# load machine local setting
if test -f ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end
