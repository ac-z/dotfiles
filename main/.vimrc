"""" This .vimrc is meant to be loaded from Vim *or* NeoVim

""" Opts
set number
set numberwidth=4
set nowrap
set scrolloff=10
set signcolumn=number
set termguicolors
set title
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set signcolumn=auto
set mouse=nvi
syntax on
let g:netrw_browsex_viewer="firefox --private-window"
" Only for TTY
if &term =~ 'linux'
    set notermguicolors
endif

""" Mappings
let g:mapleader=' '
nmap <MiddleMouse> <Nop>
nmap <2-MiddleMouse> <Nop>
nmap <3-MiddleMouse> <Nop>
nmap <4-MiddleMouse> <Nop>

" Cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

""" Colors
" UI elements
colorscheme koehler
hi Normal       guifg=#f2a400 guibg=#000000 gui=Bold

hi LineNr       guifg=bg      guibg=fg gui=Bold    ctermbg=7  ctermfg=0
hi SignColumn   guibg=fg      guifg=bg gui=Bold    ctermbg=7  ctermfg=0

hi VertSplit    guifg=bg      guibg=fg gui=Bold    ctermbg=7  ctermfg=0
hi TabLine      guifg=bg      guibg=fg gui=none    ctermbg=7  ctermfg=0 cterm=none
hi TabLineFill  guifg=bg      guibg=fg gui=none    ctermbg=7  ctermfg=0 cterm=none
hi TabLineSel   guifg=fg      guibg=bg gui=none    ctermbg=0  ctermfg=7

hi StatusLine   guibg=fg      guifg=bg gui=Bold    ctermbg=7  ctermfg=0 cterm=none 
hi StatusLineNC guibg=#303030 guifg=fg gui=Bold    ctermbg=8  ctermfg=7 cterm=none

hi Pmenu        guifg=fg      guibg=#303030        ctermbg=11 ctermfg=0
hi PmenuSel     guifg=bg      guibg=fg gui=Bold    ctermbg=1  ctermfg=0

" Diff
hi DiffAdd    guifg=#FFFFFF guibg=#009000 gui=Bold ctermbg=10 ctermfg=15 cterm=none
hi DiffChange guifg=#000000 guibg=#FFFF00 gui=Bold ctermbg=11 ctermfg=0  cterm=none
hi DiffDelete guifg=#FFFFFF guibg=#D00000 gui=Bold ctermbg=9  ctermfg=15 cterm=none
" Syntax
hi String guifg=yellowgreen ctermfg=2
hi Comment guifg=#909090
" Terminal colors
let g:terminal_ansi_colors = ['#000000', '#ce0000', '#00be00', '#ffee00', '#3575ff', '#923cff', '#00d991', '#f2a400', '#505050', '#ff3e3e', '#95d00f', '#f2a400', '#19bbfb', '#dc00c8', '#00ffd5', '#ffffff']

" Only relevant to nvim
hi DiagnosticWarn guifg=yellow gui=Bold,Reverse
hi DiagnosticHint gui=Bold,Reverse
hi DiagnosticError gui=Bold,Reverse
let g:terminal_color_0 = '#000000'
let g:terminal_color_1 = '#ce0000'
let g:terminal_color_2 = '#00be00'
let g:terminal_color_3 = '#ffee00'
let g:terminal_color_4 = '#3575ff'
let g:terminal_color_5 = '#923cff'
let g:terminal_color_6 = '#00d991'
let g:terminal_color_7 = '#f2a400'
let g:terminal_color_8 = '#505050'
let g:terminal_color_9 = '#ff3e3e'
let g:terminal_color_10 = '#95d00f'
let g:terminal_color_11 = '#f2a400'
let g:terminal_color_12 = '#19bbfb'
let g:terminal_color_13 = '#dc00c8'
let g:terminal_color_14 = '#00ffd5'
let g:terminal_color_15 = '#ffffff'
