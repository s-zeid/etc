PS1_COLOR_24bit='\x1b[38;2;171;127;204m'
PS1_COLOR_256='\x1b[38;5;140m'
PS1_COLOR_BASIC='DARK_MAGENTA'

PS1_USER="${PS1_USER-%n}"
PS1_USER="$PS1_USER${PS1_USER:+@}"
PS1_MACHINE="${PS1_MACHINE-%m}"
PS1_SIGIL="${PS1_SIGIL-\$(pwd=\$(pwd); ([ x\"\$pwd\" = x\"/\" ]) && true || echo /)}"
#PS1_SIGIL='%(!.#.$)'  # like `\$` in bash


# setup basic color variables

_COLOR_RED='\x1b[1m\x1b[31m';     _COLOR_DARK_RED='\x1b[31m'
_COLOR_YELLOW='\x1b[1m\x1b[33m';  _COLOR_DARK_YELLOW='\x1b[33m'
_COLOR_GREEN='\x1b[1m\x1b[32m';   _COLOR_DARK_GREEN='\x1b[32m'
_COLOR_CYAN='\x1b[1m\x1b[36m';    _COLOR_DARK_CYAN='\x1b[36m'
_COLOR_BLUE='\x1b[1m\x1b[34m';    _COLOR_DARK_BLUE='\x1b[34m'
_COLOR_MAGENTA='\x1b[1m\x1b[35m'; _COLOR_DARK_MAGENTA='\x1b[35m'
_COLOR_WHITE='\x1b[1m\x1b[37m';   _COLOR_DARK_WHITE='\x1b[37m'
_COLOR_DEFAULT='\x1b[1m\x1b[39m'; _COLOR_DARK_DEFAULT='\x1b[39m'
_COLOR_NONE='\x1b[0m'

#for color in RED YELLOW GREEN CYAN BLUE MAGENTA WHITE DEFAULT; do
# eval "printf \"\$_COLOR_$color $color \$_COLOR_NONE NONE\n\""
# eval "printf \"\$_COLOR_DARK_$color DARK_$color \$_COLOR_NONE NONE\n\""
#done


# set colors for PS1 and RPS1

if ([ x"$COLORTERM" = x"truecolor" ] || [ x"$COLORTERM" = x"24bit" ]) \
   && [ x"$STY" = x"" ]; then
 # true colour
 if [ x"$PS1_COLOR_24bit" != x"" ]; then
  PS1_COLOR="%{$(printf "$PS1_COLOR_24bit")%}"
 elif [ x"$PS1_COLOR_256" != x"" ]; then
  PS1_COLOR="%{$(printf "$PS1_COLOR_256")%}"
 else
  PS1_COLOR="$(eval echo "\$_COLOR_$PS1_COLOR_BASIC")"
 fi
 RPS1_COLOR_DATE="%{$(printf '\x1b[38;5;248m')%}"
 RPS1_COLOR_TIME="%{$(printf '\x1b[38;5;251m')%}"
elif (printf '%s\n' "$TERM" | grep -q -e '256') && [ x"$PS1_COLOR_256" != x"" ]; then
 # 256 colours
 if [ x"$PS1_COLOR_256" != x"" ]; then
  PS1_COLOR="%{$(printf "$PS1_COLOR_256")%}"
 else
  PS1_COLOR="%{$(printf "$(eval echo "\$_COLOR_$PS1_COLOR_BASIC")")%}"
 fi
 RPS1_COLOR_DATE="%{$(printf '\x1b[38;5;248m')%}"
 RPS1_COLOR_TIME="%{$(printf '\x1b[38;5;251m')%}"
else
 # basic colours
 PS1_COLOR="%{$(printf "$(eval echo "\$_COLOR_$PS1_COLOR_BASIC")")%}"
 RPS1_COLOR_DATE="%{$(printf "$_COLOR_DARK_WHITE")%}"
 RPS1_COLOR_TIME="%{$(printf "$_COLOR_WHITE")%}"
fi


# set PS1 and RPS1

PS1="$PS1_COLOR$PS1_USER$PS1_MACHINE:%~$PS1_SIGIL %{$(printf "$_COLOR_NONE")%}"
RPS1="%{ %}$RPS1_COLOR_DATE%D{%Y-%m-%d} $RPS1_COLOR_TIME%D{%H:%M:%S}%{$(printf "$_COLOR_NONE"'\x08')%}"
setopt PROMPT_SUBST


# cleanup

unset \
 PS1_COLOR_24bit PS1_COLOR_256 PS1_COLOR_BASIC \
 PS1_USER PS1_MACHINE PS1_SIGIL \
 PS1_COLOR RPS1_COLOR_DATE RPS1_COLOR_TIME \
 _COLOR_NONE

for color in RED YELLOW GREEN CYAN BLUE MAGENTA WHITE DEFAULT; do
 eval unset _COLOR_$color _COLOR_DARK_$color
done
