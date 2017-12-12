set titlestring=vim\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
set title

" Store swap files at ~/.vim/swp
set directory^=$HOME/.vim/swp//

set nocompatible
set hidden
set backspace=indent,eol,start
set ttimeoutlen=10
set shortmess=I

set tags=.git/tags

set clipboard=unnamed

" Powerline supporting settings
set laststatus=2
set showtabline=2
set noshowmode

" Color scheme & syntax highlighting
color desert
syntax on

" Show line numbers
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Show whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set nolist

" Tab configuration
set tabstop=4 shiftwidth=4 expandtab smarttab

" Set line number color to dark grey
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE


" Plugins
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugins')

" Editor
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

" Language
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'shawncplus/phpcomplete.vim'
Plug 'nelsyeung/twig.vim'

call plug#end()

let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:airline_skip_empty_sections=1
let g:airline_section_z=airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled=1
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:jsx_ext_required=0
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitHorzSize=38

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace='Ξ'
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.linenr='¶'

" Linter conf
let g:ale_php_phpcs_standard='PSR2'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

command W w
command Wq wq

command GenerateCTags !ctags -f ./.git/tags

" Navigation
nmap <Tab> :bnext<cr>
nmap <S-Tab> :bprevious<cr>
nmap <backspace> :NERDTreeToggle<cr>

" Command list
nmap <Leader>: :Commands<cr>

" Code searching
nmap <Leader><S-f> :Ag<space>
nmap <Leader>f :Ag<space><C-R><C-W><cr>
nmap <Leader>/ :BLines<space>
nmap <Leader>t :BTag<cr>
nmap <Leader><S-t> :Tags<space>

" Buffer and file navigation
nmap <Leader>` :Buffers<cr>
nmap <Leader><S-tab> :GFiles?<cr>
nmap <Leader><tab> :Files<cr>

" Toggle whitespace
nmap <Leader>w :set list!<cr>

" Remap Ctrl-W to Space
nnoremap <Space> <C-w>
