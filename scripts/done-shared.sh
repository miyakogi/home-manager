# shellcheck shell=bash
# done-shared.sh — zsh/bash shared long-command notifier
# Based on franciscolourenco/done (fish) window id logic, Hyprland/Niri multi-window aware.
# Threshold 5s, focus-aware (window id compare + kitty is_self), no tmux/screen.

# Prevent double load
if [ "${__done_shared_loaded:-}" != "" ]; then
  return 0 2>/dev/null || exit 0
fi
__done_shared_loaded=1

: "${DONE_MIN_CMD_DURATION:=5}"

# Early dependency check (once)
if ! command -v jq >/dev/null 2>&1; then
  echo >&2 "[done-shared] jq not found, notification disabled"
  return 0 2>/dev/null || exit 0
fi
if ! command -v notify-send >/dev/null 2>&1; then
  echo >&2 "[done-shared] notify-send not found, notification disabled"
  return 0 2>/dev/null || exit 0
fi

# zsh: EPOCHSECONDS requires zsh/datetime
if [ "${ZSH_VERSION:-}" != "" ]; then
  zmodload zsh/datetime 2>/dev/null || true
fi

__done_initial_window_id=""
__done_start_time=0
__done_last_command=""

__done_get_focused_window_id() {
  # Hyprland — address is unique per OS window
  if command -v hyprctl >/dev/null 2>&1; then
    local _tmp
    _tmp=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty' 2>/dev/null)
    if [ "$_tmp" != "" ]; then
      printf '%s' "$_tmp"
      return
    fi
  fi
  # Niri — id is unique per OS window
  if command -v niri >/dev/null 2>&1; then
    niri msg --json focused-window 2>/dev/null | jq -r '.id // empty' 2>/dev/null
    return
  fi
}

__done_is_process_window_focused() {
  # kitty: is_self + is_focused distinguishes same-PID multi-window/tab
  if [ "${KITTY_WINDOW_ID:-}" != "" ] && command -v kitty >/dev/null 2>&1; then
    if kitty @ ls 2>/dev/null | jq -e '.[].tabs[] | select(any(.windows[]; .is_self)) | .is_focused' >/dev/null 2>&1; then
      return 0
    elif kitty @ ls >/dev/null 2>&1; then
      return 1
    fi
  fi
  local current
  current=$(__done_get_focused_window_id)
  if [ "$current" = "" ] && [ "$__done_initial_window_id" = "" ]; then
    # cannot determine window id (e.g., SSH, TTY) — treat as not focused to notify
    return 1
  fi
  if [ "$current" != "$__done_initial_window_id" ]; then
    return 1
  fi
  return 0
}

__done_humanize_duration() {
  local total=$1
  local hours=$(( total / 3600 ))
  local minutes=$(( (total % 3600) / 60 ))
  local seconds=$(( total % 60 ))
  if [ "$hours" -gt 0 ]; then
    printf '%sh ' "$hours"
  fi
  if [ "$minutes" -gt 0 ]; then
    printf '%sm ' "$minutes"
  fi
  if [ "$seconds" -gt 0 ] || [ "$total" -eq 0 ]; then
    printf '%ss' "$seconds"
  fi
}

__done_preexec() {
  # Avoid recursion from DEBUG trap / precmd itself
  case "${1:-${BASH_COMMAND:-}}" in
    __done_*|*__done_precmd*|*__done_preexec*) return 0 ;;
  esac
  if [ "$1" != "" ]; then
    __done_last_command="$1"
  elif [ "${BASH_COMMAND:-}" != "" ]; then
    __done_last_command="$BASH_COMMAND"
  else
    __done_last_command=""
  fi
  if [ "${EPOCHSECONDS:-}" != "" ]; then
    __done_start_time=$EPOCHSECONDS
  else
    __done_start_time=$SECONDS
  fi
  __done_initial_window_id=$(__done_get_focused_window_id)
}

__done_precmd() {
  local exit_status=$?
  local end_time
  if [ "${EPOCHSECONDS:-}" != "" ]; then
    end_time=$EPOCHSECONDS
  else
    end_time=$SECONDS
  fi
  local elapsed=$(( end_time - __done_start_time ))
  # Early return: short command, no focus check
  if [ "$elapsed" -lt "${DONE_MIN_CMD_DURATION:-5}" ]; then
    return 0
  fi
  if __done_is_process_window_focused; then
    return 0
  fi
  local title message urgency="normal"
  if [ "$exit_status" -ne 0 ]; then
    urgency="critical"
  fi
  local human
  human=$(__done_humanize_duration "$elapsed")
  if [ "$exit_status" -ne 0 ]; then
    title="Failed ($exit_status) after $human"
  else
    title="Done in $human"
  fi
  # Limit message length and avoid option injection
  message=$(printf '%s' "$__done_last_command" | head -c 300)
  if [ "$message" = "" ]; then
    message="Command finished"
  fi
  notify-send --hint=int:transient:1 --urgency="$urgency" --icon=utilities-terminal --app-name="${ZSH_NAME:-bash}" --expire-time=3000 -- "$title" "$message" 2>/dev/null || true
  return "$exit_status"
}

# Hook registration per shell
if [ "${ZSH_VERSION:-}" != "" ]; then
  autoload -U add-zsh-hook 2>/dev/null || true
  add-zsh-hook preexec __done_preexec 2>/dev/null || true
  add-zsh-hook precmd __done_precmd 2>/dev/null || true
elif [ "${BLE_VERSION:-}" != "" ]; then
  blehook PREEXEC+=__done_preexec 2>/dev/null || true
  blehook POSTEXEC+=__done_precmd 2>/dev/null || true
elif [ "${BASH_VERSION:-}" != "" ]; then
  # Plain bash / brush: use DEBUG trap + PROMPT_COMMAND
  # Avoid duplicate registration
  if [[ "$PROMPT_COMMAND" != *"__done_precmd"* ]]; then
    # DEBUG trap stores start time and command
    trap '__done_preexec "$BASH_COMMAND"' DEBUG 2>/dev/null || true
    PROMPT_COMMAND="__done_precmd${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
  fi
fi
