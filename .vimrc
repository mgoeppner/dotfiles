" Color scheme & syntax highlighting
color desert
syntax on

" Tabs 4 spaces wide, use real tabs not spaces
set noexpandtab
set tabstop=4

" Show line numbers
set numbers

" Set line number color to dark grey
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Access to X window clipboard
set clipboard=unnamedplus

" Nerd Tree mapping
map <F2> :NERDTreeToggle<CR>

" Undo/Redo mappings
map <C-Z> :u<CR>
" map <C-Y> :U<CR> 
