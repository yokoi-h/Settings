" expand tabs to plain text spaces

set expandtab

" tab space and shift width

set ts=4 sw=4

" show cursor position
set ruler
set nu
set bg=dark

" syntax
syntax on

" status
set laststatus=2
set statusline=%F%r%h%=

" search
set incsearch

" shortcut
nmap <silent> <Tab> 15<Right>
vmap <silent> <Tab> <C-o>15<Right>
nmap <silent> <S-Tab> 15<Left>
vmap <silent> <S-Tab> <C-o>15<Left>

"--------------------------------------------------------------------------
"" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

" runtime path
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" initialize neobundle.vim
call neobundle#rc(expand('~/.vim/bundle'))

" updating neobundle.vim
NeoBundleFetch 'Shougo/neobundle.vim'

" plugins
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'scrooloose/nerdtree' " ディレクトリツリー表示

" detect filetype, enabling plugin/indent
filetype indent on
filetype plugin on

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
          \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
