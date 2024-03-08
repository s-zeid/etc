for cmd in info mount umount; do
  if which "udiskie-$cmd" >/dev/null 2>&1; then
    alias "ud$cmd=udiskie-$cmd"
  fi
done
