" Anders Refsdal Olsen vim configuration

" Set backspace behavior "
set backspace=indent,eol,start

" Sets the leader character "
let mapleader = ","

" Enables line numbers "
set number


"--- Visuals ---"

" Colorscheme "
colorscheme atom-dark

" Terminal colors "
set t_CO=256

" Font "
set guifont=Fira_Code:h17

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

"--- Plugins ---"
so ~/.vim/plugins.vim

"--- Auto-commands ---"
"Sources the .vimrc file on save"

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"--- Advanced ---"
set shell=/bin/bash
