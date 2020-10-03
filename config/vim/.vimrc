"""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM environment file
"
"	Gunjae Koo (gunjae.koo@gmail.com)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" "{{{
set nocompatible	"be iMproved
filetype off

set history=256
set exrc
set secure
" "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" "{{{
" Sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Highlight serach results
set hlsearch

" Visual
set foldenable	" turn on folding
set foldmethod=marker	" fold on the marker
set foldlevel=100	"don't autofold anything
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds

set ruler
" "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" "{{{
"Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
" "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" "{{{
" Use spaces instead of tabs
"set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set shiftwidth=4
set noexpandtab

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set si "Smart indent
set cindent	"c-style indent
set nowrap "Wrap lines
"set paste
set pastetoggle=<F2>
" "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug-ins
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" "{{{

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" My bundles here:
"
" original repos on GitHub
" Enable git commands in vim
Plug 'tpope/vim-fugitive'
" NERDTree
Plug 'scrooloose/nerdtree'
" Align codes beautifully
Plug 'godlygeek/tabular'
" Enhance vim status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Class outline viewer
Plug 'majutsushi/tagbar'

" vim-scripts repos
Plug 'vim-scripts/ctags.vim'
Plug 'brookhong/cscope.vim'

" Initialize plugin system
call plug#end()

"
" airline setting
let g:airline_theme='angr'

"
" Tagbar setting
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 40
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

"
" NERDTree setting
" Keymap
nmap <F7> :NERDTreeToggle<CR>
" Open NERDTree when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close vim if only NERDTree tab exists
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" cscope setting
"source ~/.vim/cscope_maps.vim
"if has('cscope')
"	set cscopetag cscopeverbose
"
"	if has('quickfix')
"		set cscopequickfix=s-,c-,d-,i-,t-,e-
"	endif
"
"	cnoreabbrev csa cs add
"	cnoreabbrev csf cs find
"	cnoreabbrev csk cs kill
"	cnoreabbrev csr cs reset
"	cnoreabbrev css cs show
"	cnoreabbrev csh cs help
"
"	if filereadable("./cscope.out")
"		cs add cscope.out
"	endif
"endif

" ctags setting
if filereadable("tags")
	set tag=./tags
elseif $CTAG_DB != ""
	set tag=$CTAG_DB
endif
" "}}}
