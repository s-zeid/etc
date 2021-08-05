export PAGER='less'
export EDITOR='vim'

export LESS="-R"

if [ -d /dev/shm ] && [ -w /dev/shm ]; then
 TMPPREFIX=/dev/shm/zsh
fi

HISTFILE=~/.zhistory
HISTSIZE=1024
SAVEHIST=1024
setopt APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

HOSTNAME="$(hostname)"
