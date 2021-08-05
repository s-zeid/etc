if [ -e "$HOME/bin/synchronize" -a -d "$HOME/.synchronize" ]; then
 compdef "local profiles; _wanted profiles expl profiles \
          _files -W $HOME/.synchronize" \
         synchronize
fi
