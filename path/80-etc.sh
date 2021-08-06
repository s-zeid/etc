etc="$(cd "$(dirname -- "$(readlink "$HOME/.path")")" && pwd)"

if [ -d "$etc/_bin" ]; then
 PATH="$etc/_bin:$PATH"
fi

for role_dir in $(cd "$etc" && make find-role-dirs 2>/dev/null); do
 if [ -d "$etc/$role_dir/_bin" ]; then
  PATH="$etc/$role_dir/_bin:$PATH"
 fi
done

unset etc role_dir
