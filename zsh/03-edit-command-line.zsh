# Allow editing the command line with `Ctrl+x+e`
# 
# Slightly modified from <https://github.com/cypher/dotfiles/blob/73ed27b076d8905aeca11afca3d0dc2c665d58d9/zshrc#L85-L95>,
# which is licensed under the MIT License as follows:
# 
# <https://github.com/cypher/dotfiles/blob/73ed27b076d8905aeca11afca3d0dc2c665d58d9/LICENSE>
# 
#     Copyright (c) 2010 Markus Prinz
#     
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#     
#     The above copyright notice and this permission notice shall be
#     included in all copies or substantial portions of the Software.
#     
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#     LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#     OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#     WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


autoload -U edit-command-line
zle -N edit-command-line

# Emacs style
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Vi style
# bindkey -M vicmd v edit-command-line
