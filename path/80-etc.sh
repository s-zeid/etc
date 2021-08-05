if [ -d "$HOME/etc/_bin" ]; then
 PATH="$HOME/etc/_bin:$PATH"
fi

for role_dir in $(cd "$HOME/etc" && make _find_role_dirs 2>/dev/null); do
 if [ -d "$HOME/etc/$role_dir/_bin" ]; then
  PATH="$HOME/etc/$role_dir/_bin:$PATH"
 fi
done
