" Anders Refsdal Olsen Neovim configuration
"
" For more information, please visit https://github.com/andersro93
"

" Disable old vi compatibility
set nocompatible

" Set leader character
let mapleader = ","

""" Plugins
" Ensure that plug is installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Navigation
Plug 'scrooloose/nerdtree'                      " Filesystem sidebar
Plug 'junegunn/fzf'                             " Dependency for fzf related plugins
Plug 'junegunn/fzf.vim'                         " Search or go to any file

" Coding assitance
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense tool
Plug 'ctrlpvim/ctrlp.vim'                       " Search plugin
Plug 'chrisbra/Colorizer'                       " Color highlighter
Plug 'ianks/vim-tsx'                            " TSX Highlighter
Plug 'leafgarland/typescript-vim'               " TSX Highlighter
Plug 'scrooloose/syntastic'                     " Syntax Highlighter
Plug 'sheerun/vim-polyglot'                     " Syntax Highlighter

" Preview assistance
Plug 'iamcco/markdown-preview.nvim'             " Markdown preview

" Prescence plugins
Plug 'aurieh/discord.nvim'                      " Discord prescence

" Git helpers
Plug 'airblade/vim-gitgutter'                   " Shows git diff next to line numbers
Plug 'rhysd/git-messenger.vim'                  " Git history viewer

" Template
Plug 'vim-airline/vim-airline'                  " Template engine
Plug 'vim-airline/vim-airline-themes'           " Templates for template engine
Plug 'ryanoasis/vim-devicons'                   " Icons for files
Plug 'dracula/vim', { 'as': 'dracula' }         " Dracula theme

call plug#end()

""" Basic configuration

" Highlight matching bracket/char
set showmatch

" Ignore case on matching
set ignorecase

" Add numbers to each line
set number

" Encoding
set encoding=UTF-8

""" Visual settings

" Enable color support
set termguicolors

" Enable syntax
syntax enable

" Color template
colorscheme dracula

" Plugin customization
let g:airline#extensions#tabline#enabled = 1

""" Searching settings
" Highlight results from search
set hlsearch


""" Tab settings
" Set amount of spaces for a tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Convert tabs to space
set expandtab

" Autoident the next line after return
set autoindent


""" Assistance settings
" Add basic completion
set wildmode=longest,list

" Ignore certain files in nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

"" Syntastic settings
" Add info to statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Global COC plugins
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-omnisharp', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']


""" Mouse settings
" Middle-click to paste
set mouse=v


""" Hotkeys

" Open config files
nmap <leader>ev :tabedit $HOME/.config/nvim/init.vim<CR>
nmap <leader>ei :tabedit $HOME/.config/i3/config<CR>
nmap <leader>eb :tabedit $HOME/.bashrc<CR>
nmap <leader>ezsh :tabedit $HOME/.zshrc<CR>

" Search for anything
nmap <leader><Space> :Files<CR>

" Code helper
inoremap <silent><expr> <c-space> coc#refresh()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Tab completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <c-space>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Show documentation
nnoremap <silent> <c-p> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Open filetree
nmap <leader>1 :NERDTreeToggle<cr>

" Toggle spell-check
nnoremap <leader>s :set invspell<CR>

" Navigate tabs
nmap <leader><left> :tabp<cr>
nmap <leader><right> :tabn<cr>

" Open Git history
nmap <leader>gm :GitMessenger<cr>

""" Shell settings
" Set the shell to use
set shell=/bin/bash


""" Scripts
" Autosource init.vim on save
augroup autosourcin,
	autocmd!
	autocmd BufWritePost init.vim source %
augroup END


""" Syntax highlighting for files
" Typescript files
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" CUDA files
au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cuh set ft=cuda

