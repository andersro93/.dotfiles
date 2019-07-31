" Anders Refsdal Olsen Neovim configuration
"
" For more information, please visit https://github.com/andersro93
"

" Disable old vi compatibility
set nocompatible

" Set leader character
let mapleader = ","

""" Plugins
" Vundle specific config
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

"" Plugins for vundle to manage
" Vundle itself, mandatory
Plugin 'VundleVim/Vundle.vim'

" Navigation
Plugin 'scrooloose/nerdtree'                    " Filesystem sidebar
Plugin 'junegunn/fzf'                           " Dependency for fzf related plugins
Plugin 'junegunn/fzf.vim'                       " Search or go to any file

" Coding assitance
Plugin 'ctrlpvim/ctrlp.vim'                     " Search plugin
Plugin 'vim-syntastic/syntastic'                " Syntax highlighter
Plugin 'Shougo/deoplete.nvim'                   " Autocompletion tool
Plugin 'vim-scripts/indentpython.vim'           " Python autoindent
Plugin 'lvht/phpcd.vim'                         " PHP - intellisense
Plugin 'zchee/deoplete-jedi'                    " Python - intellisense
Plugin 'sebastianmarkow/deoplete-rust'          " Rust - intellisense
Plugin 'gabrielelana/vim-markdown'              " Markdown - intellisense
Plugin 'zchee/deoplete-clang'                   " Clang - intellisense
Plugin 'chrisbra/Colorizer'                     " Color highlighter

" Prescence plugins
Plugin 'aurieh/discord.nvim'                    " Discord prescence

" Git helpers
Plugin 'airblade/vim-gitgutter'                 " Shows git diff next to line numbers
Plugin 'rhysd/git-messenger.vim'                " Git history viewer

" Template
Plugin 'vim-airline/vim-airline'                " Template engine
Plugin 'vim-airline/vim-airline-themes'         " Templates for template engine
Plugin 'ryanoasis/vim-devicons'                 " Icons for files
Plugin 'dracula/vim'                            " Nice development template

" Vundle specific config
call vundle#end()
filetype plugin indent on


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

" Enable intellisense
let g:deoplete#enable_at_startup = 1

" Ignore certain files in nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

"" Syntastic settings
" Add info to statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" When to check for syntax errors
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"" Syntax highlighter for languages
let g:syntastic_python_pylint_exe = 'python3 -m pylint3'

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
" CUDA files
au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cuh set ft=cuda

