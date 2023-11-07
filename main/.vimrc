"""" This .vimrc is meant to be loaded from Vim *or* NeoVim

""" Opts
set number
set numberwidth=4
set scrolloff=10
set signcolumn=number
set termguicolors
set laststatus=2
set tabstop=4
syntax on

""" Colors
" UI elements
hi LineNr    guifg=#000000 guibg=#f2a400 gui=Bold
hi Pmenu     guifg=#f2a400 guibg=#303030 
hi PmenuSel  guifg=#000000 guibg=#f2a400 gui=Bold
hi VertSplit guifg=#000000 guibg=#f2a400 gui=Bold
" Syntax
hi String guifg=yellowgreen
hi Comment guifg=gray
" Only relevant to nvim
hi DiagnosticWarn guifg=yellow gui=Bold,Reverse
hi DiagnosticHint gui=Bold,Reverse
hi DiagnosticError gui=Bold,Reverse