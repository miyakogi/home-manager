# Shared by bash and brush (brush also processes .bashrc).
# Runs after shellAliases (see bash.nix), so `ls` in function bodies expands
# to the eza alias at definition time (bash), or is resolved at runtime from
# the current alias (brush, which has no chained-alias support).

# Functions used by both ble and non-ble shells
function edit() {
  "$EDITOR" "$@"
}

# fix helix cursor shape
function hx() {
  command hx "$@"
  printf '\033[0 q'
}

# go to git root
function gg() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    cd "$(pwd)"/"$(git rev-parse --show-cdup)" || return
  else
    cd || return
  fi
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

# use eza for ls
function tree() {
  ls --tree 2>/dev/null || command tree
}

# ble.sh handles keys and hooks via ~/.blerc; plain bash / brush use
# readline bindings and PROMPT_COMMAND here instead.
if [[ -z ${BLE_VERSION-} ]]; then
  stty werase undef
  bind '"\C-w": unix-filename-rubout'
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
