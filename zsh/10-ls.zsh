export LS_ARGS='--color=auto --group-directories-first -v'
alias ls="ls $LS_ARGS"

if which dircolors >/dev/null 2>&1; then
 eval "$(TERM=xterm dircolors -b); export LS_COLORS"
fi
