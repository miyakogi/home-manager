# Shared by bash and brush (brush also processes .bashrc).
# Runs after shellAliases (see bash.nix), so `ls` in function bodies expands
# to the eza alias at definition time (bash), or is resolved at runtime from
# the current alias (brush, which has no chained-alias support).

### Keybind
stty werase undef
bind '"\C-w": unix-filename-rubout'
bind '"\C-h": unix-filename-rubout'  # ctrl+backspace

# Functions (from brushrc)
function edit() {
  "$EDITOR" "$@"
}

# change terminal bg color on ssh
function ssh() {
  # change bg color (dark red)
  printf '\033]11;#140000\a'

  # execute ssh
  command ssh "$@"

  # reset to original background
  printf '\033]111\a'
}

# execute `ls` on `cd`
function _auto_ls() {
  if [ "$PWD" != "$_LAST_PWD" ]; then
    if [ "$_LAST_PWD" != "" ]; then
      ls
    fi
    _LAST_PWD="$PWD"
  fi
}
if [[ ${BLE_VERSION-} ]]; then
  blehook PRECMD+=_auto_ls
else
  PROMPT_COMMAND="_auto_ls${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
fi

# startup
if ! shopt -q login_shell; then
  if command -v fastfetch &>/dev/null; then
    fastfetch --config config-short.jsonc
  elif command -v macchina &>/dev/null; then
    macchina
  fi
fi
