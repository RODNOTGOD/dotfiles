""""""""""""""""""""""""""""""""""""""""""""""""""
" Base enviroment for the vim area
"
""""""""""""

" -> General
"""""""""""""
set history=500

filetype plugin on
filetype indent on

set autoread

try
    " set undodir=~/.vim/temp_dirs/undodir
    set undodir=~/.local/share/nvim/temp_dirs/undodir
    set undofile
catch
endtry

set mouse=n
set path+=**

" -> Gui
"""""""""
syntax on

set so=7
set scrolloff=3

set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ruler

set cmdheight=2

set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

set lazyredraw

set magic

" set showmatch
" set mat=2

hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" disable audio
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=1


set tags+=.tags

" -> Color
"""""""""""

if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

try
	colorscheme tender
catch
endtry

set background=light
set background=dark

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8
set ffs=unix,dos,mac

" -> File handling
"""""""""""""""""""

set nobackup
set nowb
set noswapfile

" -> tabs

set noexpandtab
set smarttab

set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai
set si
set wrap

" -> Buffer and panes
""""""""""""""""""""""

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -> Status line
"""""""""""""""""

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
