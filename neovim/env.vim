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
set formatoptions+=j
set complete+=kspell

autocmd InsertEnter * :set nu | set rnu
autocmd InsertLeave * :set nornu

" -> Gui
"""""""""
let NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on

set so=7
set scrolloff=3

set inccommand=split

set wildmenu
set wildignore+=*/.hg/*,*/.svn/*,*/.DS_Store

set ruler

set cmdheight=1

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

set foldmethod=marker
set foldmarker={{{,}}}

set tags+=.tags

" hidden characters
set nu

set noshowmode
set list
set listchars=tab:\ \ ,trail:·,extends:❯,precedes:❮
set showbreak=↪

let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()

highlight Comment cterm=italic
highlight htmlArg cterm=italic
highlight xmlAttrib cterm=italic
highlight Type cterm=italic
highlight Normal ctermbg=none

" -> Color
"""""""""""
" set termguicolors
set background=dark

try
	color apprentice
catch
endtry

hi Normal guibg=NONE ctermbg=NONE
highlight Comment cterm=italic
highlight ExtraWhiteSpace ctermbg=red ctermfg=white guibg=#592929
2match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!
hi! TermCursorNC ctermbg=8


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

let g:netrw_browsex_viewer= "xdg-open"

" -> Buffer and panes
""""""""""""""""""""""

" Specify the behavior when switching between buffers
try
  " set switchbuf=useopen,usetab,newtab
  set switchbuf=useopen,usetab
  set stal=1
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -> Status line
"""""""""""""""""

set laststatus=2
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set statusline=\ %{GetMode()}\ \|%<%{GetFileName()}%{&modified?'\ +\ \|':''}%{&readonly?'\ \ \|':''}%h%w%{StatuslineGit()}%=\|\ %{''!=#&filetype?&filetype:'none'}\ \|\ L:%l/%L\ C:%v\ 

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
