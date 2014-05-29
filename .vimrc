
scriptencoding utf-8

if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Gist.vim'

call neobundle#end()

filetype plugin indent on



syntax on
set nocompatible
set number
set helplang=ja
set encoding=utf-8
set fencs=utf-8,euc-jp,iso-2022-jp,cp932 
set autoindent smartindent
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set showmatch matchtime=1
set matchpairs+=<:>
set whichwrap+=h,l,<,>,[,],b,s,~
set nowrap
set ruler
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%f:%{substitute(getcwd(),'.*/','','')}\ %m%=%{(&fenc!=''?&fenc:&enc).':'.strpart(&ff,0,1)}\ %l-%v\ %p%%\ %02B
set showcmd
set cmdheight=1
set laststatus=2
set ignorecase
set incsearch
set hlsearch
highlight LineNr ctermbg=grey ctermfg=darkgrey
highlight ZenkakuSpace cterm=underline ctermfg=blue
set lcs=tab:>.
set list
