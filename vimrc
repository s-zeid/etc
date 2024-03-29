" Plugins {{{1

try
  call pathogen#infect()
catch | endtry
set loadplugins


" General settings {{{1

set nocompatible

set showtabline=2
set number
set foldcolumn=1
set wildmenu
set wildoptions=pum

" Cursor shape
try
  let s:blink = "-blinkwait800-blinkon800-blinkoff800"
  let &guicursor = "n-v-c-sm:block-blinkon0"  " Normal: block, not blinking
  let &guicursor .= ",i-ci-ve:ver10" . s:blink  " Insert: vertical bar
  let &guicursor .= ",r-cr-o:block" . s:blink  " Replace: block
catch /^Vim\%((\a\+)\)\=:E\(355\|518\):/
endtry
if &term =~ 'xterm\|rxvt\|tmux\|screen' && !has("nvim")
  let &t_SI .= "\e[5 q"
  let &t_SR .= "\e[1 q"
  let &t_EI .= "\e[2 q"
endif


" Format settings  {{{1

set shiftwidth=2
set tabstop=8
set expandtab
" Insert real tabs on <Tab> without modifiers
" (but not all terminals support binding <C-Tab> and <C-i>)
inoremap <silent> <S-Tab> <Tab>
inoremap <silent> <C-Tab> <Tab>
inoremap <silent> <S-C-i> <Tab>
imap <silent> <Tab> <C-v><Tab>

set autoindent
filetype plugin indent on
au BufRead,BufNewFile *.py setlocal expandtab< tabstop< softtabstop< shiftwidth<


" Custom mappings {{{1

" Cut to clipboard
vmap <silent> <C-d> "+d
nmap <silent> <C-d> "+d
" Copy to clipboard
nmap <silent> <C-y> "+y
vmap <silent> <C-y> "+y
" Paste from clipboard
nmap <silent> <C-p> "+p
vmap <silent> <C-p> "+p
nmap <silent> <C-P> "+P
vmap <silent> <C-P> "+P

" Super-{Left,Right} - move to {left,right} tab
nmap <silent> <Esc>[1;1D gT
vmap <silent> <Esc>[1;1D gT
imap <silent> <Esc>[1;1D <C-o>gT<Esc>
nmap <silent> <Esc>[1;1C gt
vmap <silent> <Esc>[1;1C gt
imap <silent> <Esc>[1;1C <C-o>gt<Esc>

" {Ctrl,Alt}-{Home,End} ({C,A}-Fn-{Left,Right}) - move to {left,right} tab
nmap <silent> <M-Home> gT
vmap <silent> <M-Home> gT
imap <silent> <M-Home> <C-o>gT<Esc>
nmap <silent> <C-Home> gT
vmap <silent> <C-Home> gT
imap <silent> <C-Home> <C-o>gT<Esc>
nmap <silent> <M-End>  gt
vmap <silent> <M-End>  gt
imap <silent> <M-End>  <C-o>gt<Esc>
nmap <silent> <C-End>  gt
vmap <silent> <C-End>  gt
imap <silent> <C-End>  <C-o>gt<Esc>

" End search highlighting
noremap <silent> <Esc> :nohlsearch<CR><Esc>

" Fix command mode popup menu arrow keys in Neovim (cannot use <silent> here)
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>


" Custom commands {{{1

command! Pdf execute "!pdf \"%\""


" Color scheme & overrides {{{1

colorscheme default
set background=light
syn on
autocmd BufRead,BufNewFile,Syntax * syn sync fromstart

" GUI color palette {{{2

" Adwaita Dark
let g:PaletteANSI = [
\ "#241F31", "#C01C28", "#2EC27E", "#F5C211", "#1E78E4", "#9841BB", "#0AB9DC", "#C0BFBC",
\ "#5E5C64", "#ED333B", "#57E389", "#F8E45C", "#51A1FF", "#C061CB", "#4FD2FD", "#F6F5F4",
\]
let g:PaletteNormal = {
\ "Background": "#1E1E1E",
\ "Foreground": "#FFFFFF",
\}

" XTerm
let g:PaletteExtras = {
\ "Brown": "#AF5F00",
\ "Orange": "#FF8700",
\ "Violet": "#AF87FF",
\}

" }}}

command SyntaxColors : call SyntaxColors()
function SyntaxColors()
  if execute("colorscheme")->trim() != "default"
    return
  endif

  " Default background/foreground colors {{{2
  hi Normal cterm=NONE ctermbg=NONE gui=NONE
  if has("gui_running")
    execute "highlight Normal guibg=" . g:PaletteNormal["Background"]
    execute "highlight Normal guifg=" . g:PaletteNormal["Foreground"]
  endif

  " Highlight groups {{{2
  hi Comment     term=italic cterm=italic ctermfg=Gray gui=italic guifg=Gray66
  hi Constant    ctermfg=Red guifg=Red
  hi DiffChange  ctermbg=DarkMagenta guibg=DarkMagenta
  hi Directory   cterm=bold ctermfg=Blue gui=bold guifg=Blue
  hi FoldColumn  cterm=NONE ctermfg=DarkBlue ctermbg=NONE guibg=NONE guifg=DarkBlue
  hi Folded      term=italic cterm=italic ctermfg=Gray ctermbg=237 gui=italic guifg=Gray66 guibg=Gray23
  hi Identifier  term=bold ctermfg=Blue guifg=Blue
  hi Ignore      ctermfg=Black
  hi LineNr      ctermfg=130 guifg=#af5f00
  hi Pmenu       ctermfg=Black ctermbg=225 guifg=Black guibg=#ffd7ff
  hi PreProc     ctermfg=DarkCyan guifg=DarkCyan
  hi Search      ctermfg=Black ctermbg=LightCyan guifg=Black guibg=LightCyan
  hi Special     term=NONE ctermfg=141 guifg=Violet
  hi SpecialChar cterm=bold,underline ctermfg=Red gui=bold guifg=Red
  hi SpellBad    term=reverse ctermbg=224 ctermfg=Black gui=undercurl guisp=Red
  hi SpellLocal  term=underline ctermbg=DarkBlue gui=undercurl guisp=DarkCyan
  hi SpellRare   ctermbg=LightMagenta gui=undercurl guisp=Magenta
  hi SpecialKey  cterm=bold ctermfg=Blue gui=bold guifg=Blue
  hi Statement   term=bold cterm=NONE ctermfg=DarkYellow gui=NONE guifg=DarkYellow
  hi TabLine     cterm=NONE ctermbg=NONE ctermfg=Gray gui=NONE guibg=NONE guifg=Gray66
  hi TabLineSel  cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE
  hi Title       term=NONE cterm=NONE ctermfg=141 gui=NONE guifg=Violet
  hi Type        term=NONE cterm=NONE ctermfg=DarkGreen gui=NONE guifg=DarkGreen
  hi Underlined  term=underline cterm=underline ctermfg=141 gui=underline guifg=#af87ff
  hi Visual      ctermbg=238 guibg=Gray27

  hi! link StatusLine Normal
  hi! link TabLineFill TabLine

  " }}}

  " In Vim, this defines the GUI color `:ColorName` for each of the palette
  " colors and `!ColorName` for each original value.  It then rewrites existing
  " highlight groups using `ColorName` (with no `:` or `!`) to use `:ColorName`.
  " (`g:PaletteNormal` corresponds to `:Background` and `:Foreground`.)
  " In Neovim, it rewrites the highlight groups to use the color value directly.
  call PaletteApply()
endfunction

command SyntaxFixes : call SyntaxFixes()
function SyntaxFixes()
  " General fixes {{{2

  " These groups use Special by default, which is semantically incorrect
  hi link cssUnicodeEscape SpecialChar
  hi link htmlSpecialChar SpecialChar
  hi link javaScriptSpecial SpecialChar
  hi link jsonEscape SpecialChar
  hi link pythonEscape SpecialChar
  hi link rubyStringEscape SpecialChar
  hi link rustEscape SpecialChar
  hi link shSpecial SpecialChar
  hi link typeScriptSpecial SpecialChar
  hi link vimEscape SpecialChar

  " Don't highlight string delimiters separately
  hi link jsonQuote jsonString
  hi link rubyStringDelimiter rubyString
  hi link shQuote shString

  " JavaScript/TypeScript {{{2

  " Use TypeScript syntax for JavaScript files
  if &syntax == "javascript"
    set syntax=typescript
  endif

  " Use correct semantics for special JavaScript names
  hi link javaScriptFunction Operator
  hi link javaScriptMessage Special
  hi link javaScriptGlobal Special
  hi link javaScriptIdentifier Special
  hi link javaScriptMember Special
  hi link javaScriptDeprecated Error
  hi link typescriptGlobalMethod Special
  hi link typescriptIdentifier Special
  hi link typescriptBOMWindowProp Identifier
  hi link typescriptBOMWindowMethod Identifier
  hi link typescriptVariable Operator
  if &syntax == "javascript"
    syn clear javaScriptIdentifier
    syn keyword javaScriptOperator var let
    syn keyword javaScriptIdentifier globalThis this super arguments
  elseif &syntax == "html"
    syn clear javaScriptIdentifier
    syn keyword javaScriptOperator contained var let
    syn keyword javaScriptIdentifier contained globalThis this super arguments
  elseif &syntax == "typescript"
    syn keyword typescriptIdentifier
    \ globalThis arguments console self document event history location navigator window
  endif

  " Use Identifier for TypeScript DOM attributes
  call SyntaxLinkMatch('^typescript.*\(Prop\|Method\)$', '^Keyword$', "Identifier")

  " Don't default to Special for JavaScript in HTML
  if &syntax == "html"
    hi link javaScript NONE
  endif

  " For <https://github.com/jonsmithers/vim-html-template-literals>
  hi link jsThis jsGlobalObjects

  " PHP {{{2

  " echo, print; should not be used with function syntax
  hi link phpDefine Statement
  " Language constructs normally used with function syntax,
  " but also magic class methods (starting with `__`)
  hi link phpSpecialFunction Special
  hi link phpExit Special
  syn keyword phpExit contained exit die
  syn cluster phpClConst add=phpExit

  " }}}
endfunction

" Add autocmd to apply the above syntax settings
autocmd VimEnter,Syntax,ColorScheme * SyntaxConfig
command SyntaxConfig : call SyntaxConfig()
function SyntaxConfig()
  call SyntaxColors()
  call SyntaxFixes()
endfunction

function SyntaxLinkMatch(name_match, group_match, new_group)  " {{{2
  if has("nvim")
    let groups = nvim_get_hl(0, [])->items()
  else
    let groups = hlget()->mapnew("[v:val['name'], v:val]")
  endif
  for [name, group] in groups
    let link_group = group->get("link", group->get("linksto", ""))
    if !empty(link_group)
      if link_group =~ a:group_match && name =~ a:name_match
        execute ["hi", "link", name, a:new_group]->join(" ")
      endif
    endif
  endfor
endfunction

command PaletteApply : call PaletteApply()  " {{{2
function PaletteApply(
\ palette_ansi = v:null,
\ palette_normal = v:null,
\ palette_extras = v:null,
\)
  let color_names_canonical = [
  \ "black", "darkred", "darkgreen", "darkyellow", "darkblue", "darkmagenta", "darkcyan",
  \ "lightgray", "darkgray", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
  \ "background", "foreground", "brown", "orange", "violet",
  \]

  " color_names_canonical => { name: aliases, ... }
  let color_name_aliases = {}
  for index in range(len(color_names_canonical))
    let name = color_names_canonical[index]
    let color_name_aliases[name] = []
    let color_name_aliases[name] += [name->substitute("gray", "grey", "")]
    if name == "darkgreen"
      let color_name_aliases[name] += ["seagreen"]
    elseif index >= 9 && index <= 14
      let color_name_aliases[name] += ["light" . name]
      if name == "magenta"
        let color_name_aliases[name] += ["purple"]
      endif
    elseif name == "violet"
      let color_name_aliases[name] += ["slateblue"]
    endif
  endfor

  let palette_parts = #{
  \ ansi: !empty(a:palette_ansi) ? a:palette_ansi
  \ : (exists("g:PaletteANSI") ? g:PaletteANSI : []),
  \ normal: !empty(a:palette_normal) ? a:palette_normal
  \ : (exists("g:PaletteNormal") ? g:PaletteNormal : []),
  \ extras: !empty(a:palette_extras) ? a:palette_extras
  \ : (exists("g:PaletteExtras") ? g:PaletteExtras : []),
  \}

  " Convert palette dictionaries to lists,
  " sorted by the order given in color_names_canonical
  for [name, part] in palette_parts->items()
    if type(part) == v:t_dict
      let part_lower = {}
      for [key, value] in part->items()
        let key_index = color_names_canonical->index(key->tolower()->trim(":", 1))
        if key_index > -1
          let part_lower[color_names_canonical[key_index]] = value
        endif
      endfor
      let part_list = []
      for key in color_names_canonical
        for alias in [key] + color_name_aliases[key]
          if part_lower->has_key(alias)
            let part_list += [part_lower[key]]
            break
          endif
        endfor
      endfor
      let palette_parts[name] = part_list
    endif
  endfor

  let palette_list = palette_parts.ansi + palette_parts.normal + palette_parts.extras
  let palette_dict = {}
  for index in range(len(color_names_canonical))
    let name = color_names_canonical[index]
    let value = palette_list[index]
    let palette_dict[name] = value
    for alias in color_name_aliases[name]
      let palette_dict[alias] = value
    endfor
  endfor

  " Rewrite existing highlight groups which use the built-in GUI color names
  if !has("nvim")
    " Vim allows defining new color names, so define ":ColorName" for the new
    " value and "!ColorName" for the original value.
    for [name, value] in palette_dict->items()
      let v:colornames["!" . name] = v:colornames->get(name, value)
      let v:colornames[":" . name] = value
    endfor
    for group in hlget()
      for key in ["guifg", "guibg", "guisp"]
        if group->has_key(key)
          let value = group[key]->tolower()
          if palette_dict->has_key(value)
            call hlset([{ "name": group["name"], key: ":" . value }])
          endif
        endif
      endfor
    endfor
  else
    " Neovim does not allow defining new color names, so the new value must
    " be used directly.  Neovim also does not support hlget() and does not
    " return color names in its equivalent function, so we must use the
    " `highlight` command instead, in order to override _only_ named colors.
    for line in execute("highlight")->trim()->split('\r\?\n\s\@!')
      let parts = line->trim()->split('\s\+')
      if len(parts) >= 3
        let [name, example; spec] = parts
        if ["cleared", "links"]->index(spec[0]) == -1 && spec->index("links") == -1
          for index in range(len(spec))
            if spec[index]->stridx("=") > -1
              let [key, value] = spec[index]->split("=")->map("v:val->tolower()")
              if ["guifg", "guibg", "guisp"]->index(key) > -1
                let spec[index] = [key, palette_dict->get(value, value)]->join("=")
              endif
            endif
          endfor
          call execute(["highlight", name, spec->join(" ")]->join(" "), "")
        endif
      endif
    endfor
  endif

  let g:PaletteAsDict = palette_dict
  let g:PaletteAsList = palette_list
  let g:PaletteNames = color_name_aliases
  let g:PaletteNamesCanonical = color_names_canonical
  return palette_dict
endfunction  " }}}


" File type aliases {{{1

augroup filetype_aliases
  au BufRead,BufNewFile *.gv   set filetype=dot
  au BufRead,BufNewFile *.md   set filetype=markdown
  au BufRead,BufNewFile *.bsh  set filetype=java
  au BufRead,BufNewFile *.phps set filetype=php
  au BufRead,BufNewFile *.v    set filetype=vlang
augroup END


" Treat BusyBox's `/bin/sh` as a POSIX shell  #{{{1

if executable("/bin/sh") && resolve("/bin/sh") =~ '\<busybox\>'
  let g:is_posix = 1
endif


" Enable HTML/CSS syntax inside ES6 tagged templates  {{{1
" (for <https://github.com/Quramy/vim-js-pretty-template.git>)

try
  call jspretmpl#register_tag("html", "html")
  call jspretmpl#register_tag("css", "css")
  autocmd FileType javascript,typescript JsPreTmpl
catch /^Vim\%((\a\+)\)\=:E117:/
endtry


" Spell check {{{1

function ToggleSpellCheck()
  if &spell == 0
    setlocal spell
  else
    setlocal nospell
  endif
endfunction

set spelllang=en_us
nmap <silent> zs :call ToggleSpellCheck()<CR>


" Set term to xterm when running under GNU screen. {{{1
" Fixes Page(Up|Down) and delete keys and possibly other issues.

if match($VIM, "/net\.momodalo\.app\.vimtouch/") > -1
  " Not on Vim Touch (https://github.com/momodalo/vimtouch)
  " because it will lock up
elseif &term == "screen-256color"
  set term=xterm-256color
elseif &term == "screen" || match(&term, "^screen[.-].*$") > -1
  set term=xterm
endif


" Because fuck Windows. {{{1

set bs=2
if !has("nvim")
  fixdel
endif


" GUI options {{{1

if has("gui_running")
  set guioptions=gmLt

  " Font selection
  if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 12,DejaVu\ Sans\ Mono\ 10,Bitstream\ Vera\ Sans\ Mono\ 10,Monospace\ 10
  elseif has("gui_win32")
    set guifont=Ubuntu\ Mono:h12,Consolas:h11,Courier\ New:h11
  endif

  " Window size
  :set columns=96 lines=29
endif


" vim: set foldmethod=marker shiftwidth=1: {{{1
