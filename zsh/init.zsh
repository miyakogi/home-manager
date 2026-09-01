### Completion
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*' \
  'r:|?=**'

### KeyBind
# Base config
autoload -Uz select-word-style
select-word-style bash

# Ctrl-Y
cd-up() {
  BUFFER="cd ../"
  zle accept-line
}
zle -N cd-up
bindkey '^Y' cd-up
