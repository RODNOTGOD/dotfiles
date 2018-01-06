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

call plug#end()

set background=dark
colorscheme paramount

set path+=**

set undodir=~/.vim/undodir
set undofile

set statusline=[%t]%m%r%h%w\ \|%{fugitive#head()}\|\ [%L]\ \|\ [%{&ff}]\ \|\ %y\ \|\ [%p%%]\ \|\ [%l:%v]
set hlsearch

set expandtab
set shiftwidth=4
set tabstop=4

set number

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 1

let g:mapleader = "\<Space>"
let g:maplocalleader = ","

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

map <leader>nn :Explore<cr>
map <F5> :UndotreeToggle<cr>
nmap <leader><cr> <Plug>(LoupeClearHighlight)

autocmd FileType c set makeprg=make\ %:t:r

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType c match OverLength /\%81v.\+/

highlight ExtraWhiteSpace ctermbg=red ctermfg=white guibg=#592929
2match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" --> Functions
""""""""""""""""""

command! Bclose call <SID>BufcloseCloseIt()
command! Bnew call <SID>CreateNewBuf()
command! StripWhitespace call StripTrailingWhitespace()

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0 ? ' [' . l:branchname . '] ' : ''
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
endfunction
