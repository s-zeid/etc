if [ x"$XDG_RUNTIME_DIR" = x"" ]; then
  if [ -d "/run/user/$(id -u)" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  fi
fi

if [ x"$DISPLAY" = x"" ] && (pgrep X || pgrep Xwayland) >/dev/null 2>&1; then
  export DISPLAY=:0
fi

. ~/.path/_set
