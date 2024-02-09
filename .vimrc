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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugins')

" Color Scheme
Plug 'tomasiser/vim-code-dark'

" Editor
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'

Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'

" Languages
Plug 'vim-scripts/TagHighlight'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-tsserver', 'coc-clangd']

"Plant UML
Plug 'aklt/plantuml-syntax'

call plug#end()

" coc config
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" end coc config

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
highlight Search ctermfg=NONE ctermbg='Red' guibg='Red' guifg=NONE

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
let g:airline_theme='powerlineish'
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
let g:ale_c_parse_compile_commands = 1

let g:ale_linters = { 'python': ['flake8', 'mypy'] }
let g:ale_fixers = { 'python': ['autoflake', 'black', 'isort'], 'typescript': ['eslint'], 'typescriptreact': ['eslint'] }
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_python_mypy_options = '--ignore-missing-imports --python-version 3.10'
let g:ale_python_black_options = '--line-length=120 --skip-magic-trailing-comma --target-version=py310'
let g:ale_python_isort_options = '--line-length=120 --multi-line=3 --profile=black --py=310 --trailing-comma --project=service --project=test'
let g:ale_typescript_eslint_options = '--fix'
let g:ale_typescriptreact_eslint_options = '--fix'

let g:ale_fix_on_save = 1

let g:ycm_autoclose_preview_window_after_insertion=1

let $FZF_DEFAULT_COMMAND = 'rg --files'

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

set hlsearch

nmap <Leader><S-f> :Rg<space>
nmap <Leader>f :Rg<space><C-R><C-W><cr>
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
nmap z <Plug>(easymotion-overwin-f2)

" Remap Ctrl-W to Space
nnoremap <Space> <C-w>
