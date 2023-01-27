typeset -g -A _bind
_bind[Backspace]=backward-delete-char
_bind[Delete]=delete-char-or-list
_bind[Insert]=overwrite-mode
_bind[Up]=up-line-or-history
_bind[Down]=down-line-or-history
_bind[Left]=backward-char
_bind[Right]=forward-char
_bind[Home]=beginning-of-line
_bind[End]=end-of-line
_bind[PageUp]=beginning-of-buffer-or-history
_bind[PageDown]=end-of-buffer-or-history
_bind[Shift-Tab]=reverse-menu-complete

# To use zkbd:
# * Run `autoload zkbd && zkbd` to generate a zkbd file.
# * If using tmux, rename the generated file to end with `.tmux`.
# * Put `__load_zkbd` or `__load_zkbd {filename}` in (e.g.) `99-zkbd.zsh`.
__load_zkbd() {
  local file; file=$1
  if [[ -z "$1" ]]; then
    file="$HOME/.zkbd/${TERM:t}-${${DISPLAY:t}:-${VENDOR:t}-${OSTYPE:t}}${TMUX:+.tmux}"
  fi
  if [ -e "$file" ]; then
    . "$file"
    __bind_keys key
  fi
}

typeset -g -A key
if [ x"$TMUX" != x"" ]; then
  key[Backspace]='^?'
  key[Delete]='^[[3~'
  key[Insert]='^[[2~'
  key[Up]='^[[A'
  key[Down]='^[[B'
  key[Left]='^[[D'
  key[Right]='^[[C'
  key[Home]='^[[1~'
  key[End]='^[[4~'
  key[PageUp]='^[[5~'
  key[PageDown]='^[[6~'
  key[Shift-Tab]='^[[Z'
elif [ ${#terminfo} -gt 0 ]; then
  key[Backspace]="${terminfo[kbs]}"
  key[Delete]="${terminfo[kdch1]}"
  key[Insert]="${terminfo[kich1]}"
  key[Up]="${terminfo[kcuu1]}"
  key[Down]="${terminfo[kcud1]}"
  key[Left]="${terminfo[kcub1]}"
  key[Right]="${terminfo[kcuf1]}"
  key[Home]="${terminfo[khome]}"
  key[End]="${terminfo[kend]}"
  key[PageUp]="${terminfo[kpp]}"
  key[PageDown]="${terminfo[knp]}"
  key[Shift-Tab]="${terminfo[kbct]}"
fi

__bind_keys() {
  if [ $# -ne 1 ]; then
    echo "Usage: _bind_keys {key array name}" >&2
    return 2
  fi
  local key_array_name; key_array_name=$1
  typeset -a key_array_keys; key_array_keys=( ${(Pk)${key_array_name}} )
  typeset -A key_array
  for i in $(seq 1 ${#key_array_keys}); do
    key_array[${key_array_keys[$((i))]}]=${(Pv)${key_array_name}[$((i))]}
  done
  for bind_key in ${(@k)_bind}; do
    if [[ -n "${key_array[$bind_key]}" ]]; then
      bindkey "${key_array[$bind_key]}" "${_bind[$bind_key]}"
    fi
  done
}
__bind_keys key

# values from $terminfo[] are only valid when the terminal is in application mode
if [[ -n "${terminfo[smkx]}" && -n "${terminfo[rmkx]}" ]]; then
  autoload -Uz add-zle-hook-widget
  __zle_app_mode_start() { echoti smkx; }
  __zle_app_mode_end() { echoti rmkx; }
  add-zle-hook-widget -Uz zle-line-init __zle_app_mode_start
  add-zle-hook-widget -Uz zle-line-finish __zle_app_mode_end
fi
