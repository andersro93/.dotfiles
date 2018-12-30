" Anders Refsdal Olsen vim configuration

"--- Plugins ---"
so ~/.vim/plugins.vim

"--- General ---"

" Set backspace behavior "
set backspace=indent,eol,start

" Sets the leader character "
let mapleader = ","

" Enables line numbers "
set number

" Set indent based on filetype
filetype plugin indent on

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

"--- Visuals ---"

" Colorscheme "
colorscheme space-vim-dark

" Terminal colors "
set t_CO=256

" Font "
set guifont=Fira_Code:h18

" Syntax highlighting "
syntax enable

" Linespace "
set linespace=15

" Borders in split mode off "
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set showtabline=2
set guioptions-=e
"--- Searching ---"
set hlsearch

"--- Split Management ---"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>


"--- Mappings ---"

" Open vim files "
nmap <Leader>ev :tabedit ~/.vimrc<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>

" Simple highlight removal "
nmap <Leader><space> :nohlsearch<cr>

" NERDTree Toogle "
nmap <Leader>1 :NERDTreeToggle<cr>

" CtrlPBuffTag "
nmap <Leader>R :CtrlPBufTag<cr>

nmap <Leader>f :tag<space>

" Tab Navigation "
nmap <C-Left> :tabp<cr>
nmap <C-Right> :tabn<cr>

" Save shortcut "
map <C-S> :w<cr>

"--- Auto-commands ---"
"Sources the .vimrc file on save"

augroup autosourcin,
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"--- Advanced ---"
set shell=/bin/bash
