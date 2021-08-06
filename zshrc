if [ -z "$PATH" ]; then
 PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
fi

__etc="$(cd "$(dirname -- "$(readlink "${ZDOTDIR:-$HOME}/.zshrc")")" && pwd)"
__role_dirs=$({ cd "$__etc" && make _find_role_dirs absolute=1 suffix=_zsh; } 2>/dev/null)
for __dir in "$HOME/.zsh" $__role_dirs; do
 if [ -d "$__dir" ]; then
  for __script in \
   $(find "$__dir/" -type f \( -name '*.local.zsh' -o -name '*.zsh' \) | sort)
  do
   . "$__script"
  done
  unset __script
 fi
done
unset __etc __role_dirs __dir


export PATH HOSTNAME
