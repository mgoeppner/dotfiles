set titlestring=vim\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
set title

" Store swap files at ~/.vim/swp
set directory^=$HOME/.vim/swp//

set nocompatible
set hidden
set backspace=indent,eol,start
set ttimeoutlen=10
set shortmess=I

set tags=tags

set clipboard=unnamed

filetype plugin indent on
syntax on

set completeopt=menuone

" Plugins
call plug#begin('~/.vim/plugins')

" Color Scheme
Plug 'tomasiser/vim-code-dark'

" Editor
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/YouCompleteMe'

Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

" Languages
Plug 'vim-scripts/TagHighlight'

" Java
Plug 'artur-shaik/vim-javacomplete2'

" Go
Plug 'fatih/vim-go'

" Javascript
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'

Plug 'leafgarland/typescript-vim'

"Plant UML
Plug 'aklt/plantuml-syntax'

" PHP
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'nelsyeung/twig.vim'

call plug#end()
let g:phpactorBranch = "develop"

" Color scheme
color codedark

" Powerline supporting settings
set laststatus=2
set showtabline=2
set noshowmode

" Show line numbers
set number relativenumber

" Set line number color to dark grey
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

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

" Code folding
set foldmethod=indent
set foldlevel=99
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax

let g:airline_powerline_fonts=1
let g:airline_theme='hybridcustom'
let g:airline_skip_empty_sections=1
let g:airline_section_z=airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace='Ξ'
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.linenr='¶'

let g:jsx_ext_required=0

let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitHorzSize=38

" Linter conf
let g:ale_php_phpcs_standard='PSR2'

let g:ycm_autoclose_preview_window_after_insertion=1

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

command W w
command Wq wq
" Close buffer without closing splits
command Bd bp\|bd \#

command GenerateCTags !ctags -f ./tags --exclude=".git" --exclude="@.gitignore" --exclude="node_modules" --exclude="*.json" --recurse .

" Navigation
nmap <Tab> :bnext<cr>
nmap <S-Tab> :bprevious<cr>

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

" EasyMotion
nmap <Enter> <Plug>(easymotion-prefix)

" Remap Ctrl-W to Space
nnoremap <Space> <C-w>
