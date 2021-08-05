# Shell function to automatically manage the BW_SESSION environment variable
# for the Bitwarden CLI.  Public domain via CC0.
# <https://gist.github.com/c0acd6bcafbc8af3dafefc90d1e0765d>

bw() {
 local cmd="$1"
 [ $# -ge 1 ] && shift || true
 if [ x"$cmd" = x"unlock" ] && [ $# -eq 0 ]; then
  local session="$(FORCE_COLOR=$(_bw_force_color) _bw_run "$cmd" --raw "$@")"
  if [ x"$session" != x"" ]; then
   export BW_SESSION="$session"
  else
   return 1
  fi
 elif [ x"$cmd" = x"lock" ] && [ $# -eq 0 ]; then
  _bw_run "$cmd" "$@" && unset BW_SESSION
 else
  _bw_run "$cmd" "$@"
 fi
}


_bw_run() {
 local cmd="$1"
 [ $# -ge 1 ] && shift || true
 if [ x"$cmd" != x"" ]; then
  command bw "$cmd" "$@"
 else
  command bw "$@"
 fi
}


_bw_force_color() {
 # Determine the value of $FORCE_COLOR for <https://www.npmjs.com/package/chalk>.
 
 if [ x"$FORCE_COLOR" != x"" ]; then
  # $FORCE_COLOR is already set
  echo "$FORCE_COLOR"
 elif ! [ -t 0 ]; then
  # stdin is not a TTY
  echo 0
 elif ([ x"$COLORTERM" = x"truecolor" ] || [ x"$COLORTERM" = x"24bit" ]) \
    && [ x"$STY" = x"" ]; then
  # true color
  echo 3
 elif (printf '%s\n' "$TERM" | grep -q -e '256') && [ x"$PS1_COLOR_256" != x"" ]; then
  # 256 colors
  echo 2
 else
  # assume color is supported
  echo 1
 fi
}

# End of bw-session.sh
