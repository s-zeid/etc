# .local/bin
if [ -d "$HOME/.local/bin" ]; then
 PATH="$HOME/.local/bin:$PATH"
fi

# public personal bin
if [ -d "$HOME/bin" ]; then
 PATH="$HOME/bin:$PATH"
fi

# private personal bin
if [ -d "$HOME/bin/private" ]; then
 PATH="$HOME/bin/private:$PATH"
fi
