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

hi LineNr       guifg=bg      guibg=fg gui=Bold    ctermbg=7  ctermfg=0 cterm=Bold
hi SignColumn   guibg=fg      guifg=bg gui=Bold    ctermbg=7  ctermfg=0 cterm=Bold

hi VertSplit    guifg=bg      guibg=fg gui=Bold    ctermbg=0  ctermfg=7
hi TabLine      guifg=bg      guibg=fg gui=none    ctermbg=7  ctermfg=0 cterm=none
hi TabLineSel   guifg=fg      guibg=bg gui=none    ctermbg=0  ctermfg=7

hi StatusLine   guibg=fg      guifg=bg gui=Bold    ctermbg=1  ctermfg=15 cterm=bold 
hi StatusLineNC guibg=#303030 guifg=fg gui=Bold    ctermbg=7  ctermfg=0 cterm=none

hi Pmenu        guifg=fg      guibg=#303030        ctermbg=5 ctermfg=0
hi PmenuSel     guifg=bg      guibg=fg gui=Bold    ctermbg=7  ctermfg=0

" Diff
hi DiffAdd    guifg=#FFFFFF guibg=#009000 gui=Bold ctermbg=2 ctermfg=15
hi DiffChange guifg=#000000 guibg=#FFFF00 gui=Bold ctermbg=3 ctermfg=0
hi DiffDelete guifg=#FFFFFF guibg=#D00000 gui=Bold ctermbg=1 ctermfg=15
" Syntax
hi String guifg=yellowgreen
hi Comment guifg=#909090
" Only relevant to nvim
hi DiagnosticWarn guifg=yellow gui=Bold,Reverse
hi DiagnosticHint gui=Bold,Reverse
hi DiagnosticError gui=Bold,Reverse
