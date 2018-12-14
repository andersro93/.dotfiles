set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" -- START PLUGINS -- "

" Plugin for managing plugins
Plugin 'VundleVim/Vundle.vim'

" Plugin that enables tree view
Plugin 'scrooloose/nerdtree'

" Plugin for making navigation easier
Plugin 'tpope/vim-vinegar'

" Plugin for showing changes in git
Plugin 'airblade/vim-gitgutter'

" Plugin for nicer status line
Plugin 'itchyny/lightline.vim'

" Plugin for easy file access
Plugin 'ctrlpvim/ctrlp.vim'

" Darker theme
Plugin 'liuchengxu/space-vim-dark'

" Plugin for Python intellisense
Plugin 'davidhalter/jedi-vim'

" Plugin for searching vim files
Plugin 'junegunn/fzf'

" Color preview plugin 
Plugin 'ap/vim-css-color'

" -- END PLUGINS -- "

call vundle#end()
filetype plugin indent on
