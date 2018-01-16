"  $$$$$$\  $$\                         $$\                 $$\    $$\ $$$$$$\ $$\      $$\ $$$$$$$\   $$$$$$\
" $$  __$$\ \__|                        $$ |                $$ |   $$ |\_$$  _|$$$\    $$$ |$$  __$$\ $$  __$$\
" $$ /  \__|$$\ $$$$$$\$$$$\   $$$$$$\  $$ | $$$$$$\        $$ |   $$ |  $$ |  $$$$\  $$$$ |$$ |  $$ |$$ /  \__|
" \$$$$$$\  $$ |$$  _$$  _$$\ $$  __$$\ $$ |$$  __$$\       \$$\  $$  |  $$ |  $$\$$\$$ $$ |$$$$$$$  |$$ |
"  \____$$\ $$ |$$ / $$ / $$ |$$ /  $$ |$$ |$$$$$$$$ |       \$$\$$  /   $$ |  $$ \$$$  $$ |$$  __$$< $$ |
" $$\   $$ |$$ |$$ | $$ | $$ |$$ |  $$ |$$ |$$   ____|        \$$$  /    $$ |  $$ |\$  /$$ |$$ |  $$ |$$ |  $$\
" \$$$$$$  |$$ |$$ | $$ | $$ |$$$$$$$  |$$ |\$$$$$$$\          \$  /   $$$$$$\ $$ | \_/ $$ |$$ |  $$ |\$$$$$$  |
"  \______/ \__|\__| \__| \__|$$  ____/ \__| \_______|          \_/    \______|\__|     \__|\__|  \__| \______/
"                             $$ |
"                             $$ |
"                             \__|
"{{{ --> Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'

Plug 'wellle/targets.vim'
Plug 'mbbill/undotree'
Plug 'ajh17/VimCompletesMe'
Plug 'owickstrom/vim-colors-paramount'
Plug 'wincent/loupe'
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

"}}}

"{{{ --> Env Settings
set background=dark
colorscheme paramount

set path+=**

set undodir=~/.vim/undodir
set undofile

set statusline=\ %{GetMode()}\ \|%<%{GetFileName()}%{&modified?'\|\ +\ ':''}%{&readonly?'\|\ \ ':''}%h%w\|%{StatuslineGit()}%=\|\ %{''!=#&filetype?&filetype:'none'}\ \|\ L:%l/%L\ C:%v\ 
" set statusline=\ %{GetMode()}\ \|%<%{GetFileName()}%{&modified?'\|\ +\ ':''}%{&readonly?'\|\ \ ':''}%h%w\|%{StatuslineGit()}%=\|%{GetEncoding()}\|%{&modifiable?&expandtab?'\ spaces\ ':'\ tabs\ ':''}\|\ %{&ff}\ \|\ %{''!=#&filetype?&filetype:'none'}\ \|\ %p%%\ \|\ %l:%v\ 
set hlsearch

set expandtab
set shiftwidth=4
set tabstop=4

set number
set magic
set lazyredraw
set hidden

set list
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set noshowmode

set foldcolumn=1

set foldmethod=marker
set foldmarker={{{,}}}

set mouse=n
"}}}

"{{{ --> Plugin Configure
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

let g:mapleader = "\<Space>"
let g:maplocalleader = ","
"}}}

"{{{ --> Mappings
map <leader>ev :e ~/.vimrc<cr>

map <leader>w :w!<cr>
map <leader>x ZZ

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

nnoremap c* *Ncgn

vnoremap >> >gv
vnoremap << <gv

inoremap <expr> <C-l> "\<Right>"
inoremap <expr> <C-h> "\<Left>"

nnoremap <C-e> 3<C-e>
noremap <expr> <C-y> (line("w0") <= 1 ? "k" : "3\<C-y>")

noremap v <C-v>
noremap <C-v> v

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

map <leader>cd :cd %:p:h<cr>:pwd<cr>

" -> Parenthesis/bracket
"""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" --> Window Panes
"""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-l> <C-w>l
map <C-k> <C-w>k

nnoremap <leader>s :split<cr>
nnoremap <leader>v :vsplit<cr>

nmap <C-Up> <C-W>+
nmap <C-Down> <C-W>-
nmap <C-Left> <C-W><
nmap <C-Right> <C-W>>

" buffer commands
nnoremap <TAB> :b#<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>
map <leader>bn :Bnew<cr><C-w>L

" Tab commands
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext

nnoremap <silent> <localleader>co :silent! copen <bar> silent! lopen<cr>
nnoremap <silent> <localleader>cc :silent! cclose <bar> silent! lclose<cr>

map <F9> :w!<cr>:silent make<cr>:cw<cr>

nnoremap <tab> :b#<cr>


nnoremap <leader>nn :let g:netrw_liststyle = 0<CR>:let g:netrw_browse_split = 0<CR>:Explore<CR>
nnoremap <leader>nt :let g:netrw_liststyle = 3<CR>:let g:netrw_browse_split = 4<CR>:Vexplore<CR>

map <F5> :UndotreeToggle<cr>

nmap <leader><cr> <Plug>(LoupeClearHighlight)

nmap <C-_> :Lines<cr>
nmap <C-F> :Files<cr>
nmap <leader>f :History<cr>
nmap <leader>o :Buffers<cr>

"}}}

"{{{ --> Autocmds
autocmd FileType c set makeprg=make\ %:t:r

autocmd FileType netrw setl bufhidden=delete
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

highlight SpecialKey ctermfg=DarkGrey guifg=DimGrey
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType c match OverLength /\%81v.\+/

highlight ExtraWhiteSpace ctermbg=red ctermfg=white guibg=#592929
2match ExtraWhiteSpace /\s\+\%#\@<!$/

autocmd InsertLeave * redraw!
autocmd InsertEnter * :set nu | set rnu
autocmd InsertLeave * :set nornu

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufReadPost * call TabsOrSpaces()

"}}}

"{{{ --> Functions
""""""""""""""""""

command! Bclose call <SID>BufcloseCloseIt()
command! Bnew call <SID>CreateNewBuf()
command! StripWhitespace call StripTrailingWhitespace()

function! GetEncoding()
    return strlen(&fileencoding) > 0 ? ' ' . &fileencoding . ' ' : ''
endfunction

function! GetFileName()
    let l:filename = expand('%:t')
    return strlen(l:filename) > 0 ? ' ' . l:filename . ' ' : ''
endfunction

function TabsOrSpaces()
    " Determines whether to use spaces or tabs on the current buffer.
    if getfsize(bufname("%")) > 256000
        " File is very large, just use the default.
        return
    endif

    let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

    if numTabs > numSpaces
        setlocal noexpandtab
    endif
endfunction

function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? ' ' . l:branchname . ' |' : ''
endfunction

function! GetMode()
    let l:currmode = mode()
    if l:currmode ==# 'n'
        return 'NORMAL'
    elseif l:currmode ==# 'i'
        return 'INSERT'
    elseif l:currmode ==# 'v'
        return 'VISUAL'
    elseif l:currmode ==# 'V'
        return 'V-LINE'
    elseif l:currmode ==# ''
        return 'V-BLOCK'
    elseif l:currmode ==# 's'
        return 'SELECT'
    elseif l:currmode ==# 'S'
        return 'S-LINE'
    elseif l:currmode ==# ''
        return 'S-BLOCK'
    elseif l:currmode ==# 'R'
        return 'REPLACE'
    endif
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! <SID>CreateNewBuf()
    new
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
endfunction

function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

function! NetrwMapping()
    nmap <buffer> h -
    nmap <buffer> l <cr>
    nmap <buffer> <silent>qq :bd<cr>:silent! windo close<cr>l
endfunction
"}}}
