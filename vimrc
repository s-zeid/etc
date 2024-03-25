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


" Custom commands {{{1

command! Pdf execute "!pdf \"%\""


" Color scheme & overrides {{{1

let s:colorscheme = "default"
set background=light
syn on
autocmd BufRead,BufNewFile * syn sync minlines=200 maxlines=200

execute "colorscheme " . s:colorscheme
autocmd VimEnter,BufNew,BufRead,BufNewFile,FileType,Syntax,ColorScheme * SyntaxConfig
command SyntaxConfig : call SyntaxConfig()
function SyntaxConfig()
  if g:colors_name != "default"
    return
  endif
  if has("gui_running")
    hi Normal      cterm=NONE ctermbg=NONE gui=NONE guifg=White guibg=#3b3b3b
    hi Statement   term=bold ctermfg=Brown gui=bold guifg=Brown
  else
    hi Normal      cterm=NONE ctermbg=NONE gui=NONE
    hi Statement   term=bold ctermfg=DarkYellow gui=bold guifg=Brown
  endif
  hi Comment     cterm=bold ctermfg=Blue gui=bold guifg=#aaaaff
  hi Constant    ctermfg=Red guifg=LightRed
  hi DiffChange  ctermbg=DarkMagenta guibg=DarkMagenta
  hi Directory   cterm=bold ctermfg=Blue gui=bold guifg=Blue
  hi FoldColumn  cterm=NONE ctermbg=NONE guibg=NONE guifg=fg
  hi Folded      ctermfg=Blue ctermbg=242 guifg=#aaaaff guibg=#6c6c6c
  hi Ignore      ctermfg=Black
  hi LineNr      ctermfg=130 guifg=#c0795f
  hi PreProc     ctermfg=DarkCyan guifg=DarkCyan
  hi Search      ctermfg=Black ctermbg=LightCyan guifg=Black guibg=Yellow
  hi Special     term=NONE ctermfg=141 gui=NONE guifg=#af87ff
  hi SpecialChar cterm=bold,underline ctermfg=Red gui=bold guifg=Red
  hi SpellBad    term=reverse ctermbg=224 ctermfg=Black gui=undercurl guisp=Red
  hi SpellLocal  term=underline ctermbg=DarkBlue gui=undercurl guisp=DarkCyan
  hi SpellRare   ctermbg=LightMagenta gui=undercurl guisp=Magenta
  hi SpecialKey  cterm=bold ctermfg=Blue gui=bold guifg=Blue
  hi TabLine     cterm=NONE ctermbg=NONE ctermfg=Gray guibg=NONE
  hi TabLineFill cterm=NONE ctermbg=NONE ctermfg=Gray gui=NONE
  hi TabLineSel  cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse
  hi Title       term=NONE ctermfg=141 gui=NONE guifg=#af87ff
  hi Underlined  term=underline cterm=underline ctermfg=141 gui=underline guifg=#af87ff
  hi Visual      ctermbg=242 guibg=#6c6c6c

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
  for group in hlget()
    if group->has_key("linksto") && group["name"]->stridx("typescript") == 0
      if group["linksto"] == "Keyword" && group["name"] =~ '\(Prop\|Method\)$'
        execute "hi link " . group["name"] . " Identifier"
      endif
    endif
  endfor

  " Don't default to Special for JavaScript in HTML
  if &syntax == "html"
    hi link javaScript NONE
  endif

  " For <https://github.com/jonsmithers/vim-html-template-literals>
  hi link jsThis jsGlobalObjects

  " GUI colors {{{2

  if has("gui_running") && exists("*execute")
    let colors = [ "#3f3f3f", "#9ab8d7", "#60b48a", "#8cd0d3", "#c07887", "#dc8cc3", "#dfaf8f", "#dcdcdb", "#606060", "#94bff3", "#72d5a4", "#93e0e4", "#e08c9e", "#ec93d4", "#f0dfaf", "#ffffff" ]

    let default_scheme = split(execute("highlight"), "\n")
    for group in default_scheme
      if stridx(group, "=") > -1
        let group = substitute(group, "xxx", "", "g")
        let group = substitute(group, "gui[bf]g=[#0-9a-zA-Z]*", "", "g")
        if stridx(group, "=") > -1
          let group = substitute(group,  "\\(cterm\\([bf]g\\)=\\(0\\|1\\|2\\|3\\|4\\|5\\|6\\|7\\|8\\|9\\|10\\|11\\|12\\|13\\|14\\|15\\)\\) ", "\\1 gui\\2=__\\3__ ", "g")
          if has("gui_running")
            let i_range = range(len(colors))
          else
            let i_range = [0, 4, 2, 6, 1, 5, 3, 7, 8, 12, 10, 14, 9, 13, 11, 15]
          endif
          for i in range(len(i_range))
            let group = substitute(group, "__".i."__", colors[i_range[i]], "g")
          endfor
          execute("highlight " . group)
        endif
      endif
    endfor
  endif  " }}}
endfunction


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
