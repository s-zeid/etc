if [ -z "$PATH" ]; then
 PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
fi


if [ -d "$HOME/.zsh" ]; then
 for i in \
  $(cd "$HOME/.zsh";
    find . -type f \( -name '*.local.zsh' -o -name '*.zsh' \) | sort)
 do
  . "$HOME/.zsh/$i"
 done
 unset i
fi


export PATH HOSTNAME
