if [ -f "$HOME/.profile" ]; then
 emulate sh -c '. "$HOME/.profile"'
fi

if [ -z "$PATH" ]; then
 PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
fi

__home=${ZDOTDIR:-$HOME}
__etc="$(cd "$__home" && cd "$(dirname -- "$(readlink "$__home/.zshrc")")" && pwd)"
__role_dirs=$({ cd "$__etc" && make find-role-dirs absolute=1 suffix=/_zsh; } 2>/dev/null)
for __dir in "$HOME/.zsh" $__role_dirs; do
 if [ -d "$__dir" ]; then
  for __script in \
   $(find "$__dir/" -type f \( -name '*.local.zsh' -o -name '*.zsh' \) | sort)
  do
   export __script
   . "$__script"
  done
  unset __script
 fi
done
unset __home __etc __role_dirs __dir


export PATH HOSTNAME
