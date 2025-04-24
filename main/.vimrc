"""" This .vimrc is meant to be loaded from Vim *or* NeoVim

""" Opts
set number
set numberwidth=4
set nowrap
set scrolloff=2
set signcolumn=number
set termguicolors
set title
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set signcolumn=auto
set mouse=nvi
set virtualedit=block
set cmdheight=1
syntax on
let g:netrw_browsex_viewer="setsid firefox -P development-profile"
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
" For getting out of the terminal
tmap <C-W> <C-\><C-n><C-W>

" Cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

""" Colors
" UI elements
colorscheme koehler
hi Normal       guifg=#f2a400 guibg=#000000 gui=Bold

hi LineNr       guifg=bg      guibg=fg gui=Bold    ctermbg=7  ctermfg=0
hi NonText      guifg=#454545      guibg=bg gui=Bold    ctermbg=7  ctermfg=0

hi clear CursorLine
hi clear CursorLineNr
hi clear CursorLineFold
hi clear CursorLineSign
hi link CursorLineNr LineNr
hi link CursorLineFold LineNr
hi link CursorLineSign LineNr

hi VertSplit    guifg=bg      guibg=fg      gui=Bold    ctermbg=7  ctermfg=0
hi TabLine      guifg=fg      guibg=#282828 gui=none    ctermbg=0  ctermfg=7
hi TabLineFill  guifg=bg      guibg=fg      gui=none    ctermbg=7  ctermfg=0 cterm=none
hi TabLineSel   guifg=fg      guibg=#782800 gui=none    ctermbg=0  ctermfg=7

hi StatusLine   guibg=#782800 guifg=fg gui=Bold    ctermbg=7  ctermfg=0 cterm=none 
hi StatusLineNC guibg=#282828 guifg=fg gui=Bold    ctermbg=8  ctermfg=7 cterm=none

" Syntax
hi String guifg=yellowgreen ctermfg=10
hi Comment guifg=#909090
" Terminal colors
let g:terminal_ansi_colors = ['#000000', '#ce0000', '#00be00', '#ffee00', '#3575ff', '#923cff', '#00d991', '#f2a400', '#505050', '#ff3e3e', '#95d00f', '#f2a400', '#19bbfb', '#dc00c8', '#00ffd5', '#ffffff']

""" Only relevant to nvim
" Diagnostics
hi DiagnosticWarn guifg=yellow gui=Bold guibg=#782800
hi DiagnosticHint gui=Bold guibg=#782800 guifg=#FFFFFF
hi DiagnosticError gui=Bold guibg=#782800
" Diff
hi DiffAdd        guifg=#009000 guibg=#282828 gui=Bold ctermfg=10 cterm=none
hi DiffChange     guifg=#19bbfb guibg=#282828 gui=Bold ctermfg=11 cterm=none
hi DiffDelete     guifg=#D00000 guibg=#282828 gui=Bold ctermfg=9  cterm=none
hi GitSignsAdd    guifg=#FFFFFF guibg=#009000 gui=Bold ctermbg=10 ctermfg=15 cterm=none
hi GitSignsChange guifg=#FFFFFF guibg=#19bbfb gui=Bold ctermbg=11 ctermfg=0  cterm=none
hi GitSignsDelete guifg=#FFFFFF guibg=#D00000 gui=Bold ctermbg=9  ctermfg=15 cterm=none
hi link NeoTreeGitAdded Added
hi link NeoTreeGitModified Changed
hi link NeoTreeGitDeleted Removed

hi SignColumn      guibg=fg      guifg=bg gui=Bold    ctermbg=7  ctermfg=0
hi WinBar          guifg=bg      guibg=fg
hi FoldColumn      guifg=bg      guibg=fg
hi clear TroubleIndent
hi TroubleIndent   guifg=fg
hi clear TroubleIndentWs
hi TroubleIndentWs guifg=fg
hi link TroubleIndentFoldClosed TroubleIndent

hi Pmenu          guifg=fg      guibg=#303030        ctermbg=11 ctermfg=0
hi PmenuSel       guifg=bg      guibg=fg gui=Bold    ctermbg=1  ctermfg=0

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
