# Swap {back,for}ward-word and -char bindings
bindkey '^B' backward-word
bindkey '^F' forward-word
for modifier in '\e' '\M-'; do
  bindkey "${modifier}B" backward-char
  bindkey "${modifier}b" backward-char
  bindkey "${modifier}F" forward-char
  bindkey "${modifier}f" forward-char
done
