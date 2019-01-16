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

" Coding assitance
Plugin 'vim-syntastic/syntastic'                " Syntax highlighter

" Git helpers
Plugin 'airblade/vim-gitgutter'                 " Shows git diff next to line numbers



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


"" Syntastic settings
" Add info to statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" When to check for syntax errors
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" Syntax highlighter for languages
let g:syntastic_python_pylint_exe = 'python3 -m pylint3'

""" Mouse settings
" Middle-click to paste
set mouse=v


""" Hotkeys

" Toggle spell-check
nnoremap <leader>s :set invspell<CR>


""" Scripts
" Autosource init.vim on save
augroup autosourcin,
	autocmd!
	autocmd BufWritePost init.vim source %
augroup END
