bindkey ' ' magic-space

zstyle ':completion:*:warnings' format 'no such %d'

# offer to correct commands and arguments
setopt CORRECT CORRECT_ALL

# don't offer hidden filenames when offering to correct arguments
CORRECT_IGNORE_FILE=.*

# set max-errors to approximately one-third of the typed characters
zstyle ':completion:*' max-errors 'reply=($(((${#PREFIX}/1+${#SUFFIX}/1)/3)))'

# allow navigating completions with arrow keys
setopt MENU_COMPLETE

# ignore `_*` functions (e.g. shell completion functions) and ZSH parameters
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:parameters' ignored-patterns '_*'

# ignore system users other than root, defined as 1 <= UID <= 999
_ignored_users=$(
 cut -d: -f1,3 /etc/passwd \
  | egrep -v -e ':(0|[0-9]{4})$' 2>/dev/null \
  | cut -d: -f 1
)
if [ $? -ne 0 ]; then
 _ignored_users=
fi
zstyle ':completion:*:*:*:users' ignored-patterns $(printf '%s ' $_ignored_users)
unset _ignored_users

# when completing processes, show full command lines and all processes
# from the current user
_ps_completion_cmd='ps -u "$UID" wx'
if eval "$_ps_completion_cmd" >/dev/null 2>&1; then
 zstyle ':completion:*:processes' command "$_ps_completion_cmd"
else
 zstyle ':completion:*:processes' command 'ps w'
fi
unset _ps_completion_cmd

autoload bashcompinit
bashcompinit
