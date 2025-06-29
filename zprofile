if [ -f "$HOME/.profile" ]; then
  emulate sh -c '. "$HOME/.profile"'
fi

if [ -z "$PATH" ]; then
  PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
fi


export PATH
