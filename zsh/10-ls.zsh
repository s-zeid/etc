alias ls='ls --color=auto --group-directories-first -v'

if which dircolors >/dev/null 2>&1; then
 eval "$(TERM=xterm dircolors -b); export LS_COLORS"
fi
