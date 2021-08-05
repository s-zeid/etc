TITLE=
TITLE_SEQ=
title() {
 if [ $# -ne 0 ]; then
  TITLE="$@"
  TITLE_SEQ="$(printf '\033]2;%s\007' "$TITLE")"
 fi
 printf '%s' $TITLE_SEQ >&2
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd title
