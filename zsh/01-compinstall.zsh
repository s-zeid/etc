# Portions of this file may be subject to the following copyright and license
# (probably excluding the note about the GNU General Public License):
# 
# <https://github.com/zsh-users/zsh/blob/5ede2c55f144593c16498c3131a76e188114a9c6/LICENCE>
# 
#     Unless otherwise noted in the header of specific files, files in this
#     distribution have the licence shown below.
#     
#     However, note that certain shell functions are licensed under versions
#     of the GNU General Public Licence.  Anyone distributing the shell as a
#     binary including those files needs to take account of this.  Search
#     shell functions for "Copyright" for specific copyright information.
#     None of the core functions are affected by this, so those files may
#     simply be omitted.
#     
#     --
#     
#     The Z Shell is copyright (c) 1992-2017 Paul Falstad, Richard Coleman,
#     Zoltán Hidvégi, Andrew Main, Peter Stephenson, Sven Wischnowsky, and
#     others.  All rights reserved.  Individual authors, whether or not
#     specifically named, retain copyright in all changes; in what follows, they
#     are referred to as `the Zsh Development Group'.  This is for convenience
#     only and this body has no legal status.  The Z shell is distributed under
#     the following licence; any provisions made in individual files take
#     precedence.
#     
#     Permission is hereby granted, without written agreement and without
#     licence or royalty fees, to use, copy, modify, and distribute this
#     software and to distribute modified versions of this software for any
#     purpose, provided that the above copyright notice and the following
#     two paragraphs appear in all copies of this software.
#     
#     In no event shall the Zsh Development Group be liable to any party for
#     direct, indirect, special, incidental, or consequential damages arising out
#     of the use of this software and its documentation, even if the Zsh
#     Development Group have been advised of the possibility of such damage.
#     
#     The Zsh Development Group specifically disclaim any warranties, including,
#     but not limited to, the implied warranties of merchantability and fitness
#     for a particular purpose.  The software provided hereunder is on an "as is"
#     basis, and the Zsh Development Group have no obligation to provide
#     maintenance, support, updates, enhancements, or modifications.


# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
#zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%B%d (error(s): %e)%b'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
autoload -Uz compinit
compinit
# End of lines added by compinstall
