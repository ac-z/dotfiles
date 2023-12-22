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
syntax on

" Cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

""" Colors
" UI elements
hi Normal    guifg=#f2a400 guibg=#000000 gui=Bold
hi LineNr    guifg=#000000 guibg=#f2a400 gui=Bold
hi Pmenu     guifg=#f2a400 guibg=#303030 
hi PmenuSel  guifg=#000000 guibg=#f2a400 gui=Bold
hi VertSplit guifg=#000000 guibg=#f2a400 gui=Bold
hi TabLine   guifg=#000000 guibg=#f2a400 gui=none
" Syntax
hi String guifg=yellowgreen
hi Comment guifg=gray
" Only relevant to nvim
hi DiagnosticWarn guifg=yellow gui=Bold,Reverse
hi DiagnosticHint gui=Bold,Reverse
hi DiagnosticError gui=Bold,Reverse
