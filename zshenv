if [ x"$DISPLAY" = x"" ] && (pgrep X || pgrep Xwayland) >/dev/null 2>&1; then
  export DISPLAY=:0
fi

. ~/.path/_set
