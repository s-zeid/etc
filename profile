. ~/.path/_set

__home=$HOME
__etc="$(cd "$__home" && cd "$(dirname -- "$(readlink "$__home/.profile")")" && pwd)"
__role_dirs=$({ cd "$__etc" && make find-role-dirs absolute=1 suffix=/_profile.d; } 2>/dev/null)
for __dir in "$HOME/.profile.d" $__role_dirs; do
  if [ -d "$__dir" ]; then
    for __script in \
      $(find "$__dir/" -type f \( -name '*.local.sh' -o -name '*.sh' \) | sort)
    do
      export __script
      . "$__script"
    done
    unset __script
  fi
done
unset __home __etc __role_dirs __dir


export PATH HOSTNAME
