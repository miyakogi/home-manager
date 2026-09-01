### autocmd
chpwd() {
  ls
}
### function
tree() {
  ls --tree 2>/dev/null || command tree
}

# Load Plugins
: "${DONE_MIN_CMD_DURATION:=5}"
if [ -f "$HOME/bin/done-shared.sh" ]; then
  source "$HOME/bin/done-shared.sh"
fi

if command -v seasalt &>/dev/null; then
  eval "$(seasalt init zsh)"
fi

if command -v fastfetch &>/dev/null; then
  fastfetch --config config-short.jsonc
elif command -v macchina &>/dev/null; then
  macchina
fi
