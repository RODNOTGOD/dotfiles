set nocompatible
filetype off

" set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

let $NVIM_CONF='~/.config/nvim/init.vim'
let $NVIM_CONFDIR='~/.config/nvim'
let $NVIM_DIR='/home/kragentu/.local/share/nvim'

" Github Plugins
Plug 'vim-syntastic/syntastic', {'for': 'nasm'}
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/goyo.vim'
Plug 'sjl/gundo.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/snipmate-snippets'
Plug 'amix/open_file_under_cursor.vim'
Plug 'amix/vim-zenroom2'
Plug 'godlygeek/tabular'
Plug 'jacoborus/tender.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript', 'xml']}
Plug 'vim-scripts/vis'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'neomake/neomake'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Non maintained plugins
Plug 'file:///home/kragentu/.local/share/nvim/local-plugs/betterdigraphs_utf8'
Plug 'file:///home/kragentu/.local/share/nvim/local-plugs/dragvisuals'
Plug 'file:///home/kragentu/.local/share/nvim/local-plugs/listtrans'
Plug 'file:///home/kragentu/.local/share/nvim/local-plugs/hlnext'
Plug 'file:///home/kragentu/.local/share/nvim/local-plugs/vmath'

call plug#end()


" Leader mapping
"""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
let maplocalleader = ";"

" Movement
"""""""""""
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

inoremap <C-H> <C-W>

nnoremap <leader>i :set cursorline!<CR>

" Terminal mapping
"""""""""""""""""""
noremap <F2> :vsplit<CR><C-w>l:terminal<CR>
tnoremap <C-]> <C-\><C-n>

" Read and Writing files
"""""""""""""""""""""""""
nmap <leader>x ZZ
nmap <leader>w :w!<cr>
command! W w !sudo tee % > /dev/null

" *rc editing
nmap <silent> <leader>ev :e $NVIM_CONF<CR>
nmap <silent> <leader>sv :source $NVIM_CONF<CR>
nmap <silent> <leader>ez :e ~/.zshrc<CR>

augroup reload_vimrc
	autocmd!
	autocmd bufwritepost $NVIM_CONF nested source $NVIM_CONF
augroup END

" copy and paste
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" spell checking
map <leader>ss :setlocal spell!<cr>

" quickfix menu
nnoremap <localleader>co :call OpenMenu()<CR>
nnoremap <localleader>cc :call CloseMenu()<CR>
nnoremap <localleader>cn :call NextFix()<CR>
nnoremap <localleader>cp :call PrevFix()<CR>
fun! NextFix()
	try
		try
			cn
		catch
			cfir
		endtry
	catch
		try
			lne
		catch
			try
				lfir
			catch
				echom "No errors"
			endtry
		endtry
	endtry
endf

fun! NextFix()
	try
		try
			cn
		catch
			cfir
		endtry
	catch
		try
			lne
		catch
			try
				lfir
			catch
				echom "No errors"
			endtry
		endtry
	endtry
endf

fun! PrevFix()
	try
		try
			cp
		catch
			cla
		endtry
	catch
		try
			lprev
		catch
			try
				lla
			catch
				echom "No errors"
			endtry
		endtry
	endtry
endf

fun! OpenMenu()
	try
		cfir
		copen
	catch
		lopen
	endtry
endf

fun! CloseMenu()
	try
		cfir
		cclose
	catch
		lclose
	endtry
endf

" hidden characters
set nu
set rnu

set noshowmode
set list
set listchars=eol:¬,tab:»\ ,trail:·

nnoremap <C-n> :call NumberToggle()<cr>

function! NumberToggle()
	RainbowToggle
    if(&relativenumber == 1)
        set rnu!
    else
        set relativenumber
    endif
endfunc

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

" Command mode related
"""""""""""""""""""""""
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>
cno $q <C-\>eDeleteTillSlash()<cr>
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

command! MakeTags !ctags -f .tags -R .

" Visual modes
"""""""""""""""
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap v <C-v>
nnoremap <C-v> v
vnoremap v <C-v>
vnoremap <C-v> v

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
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

" Windows and pane movement
""""""""""""""""""""""""""""
nnoremap 0 ^

" Clear highlighting
map <silent> <leader><cr> :noh<cr>

" Swtich through panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Splitting Commands
map <leader>v :vsplit<CR>
map <leader>s :split<CR>

map <leader>vl :vertical-resize +5<CR>
map <leader>vh :vertical-resize -5<CR>

map <leader>sj :resize +5<CR>
map <leader>sk :resize -5<CR>

" Character Skip trick
inoremap <expr> <C-l> "\<Right>"
inoremap <expr> <C-h> "\<Left>"

" Delete empty brackets: {{{1
inoremap <expr> <BS> CloseBrackets()

" Delete Brackets if together
function! CloseBrackets()
	let g:delete_pairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"','<':'>'}
	let line = getline('.')
	let position = col('.') - 2
	let current_char = line[position]
	let next_char = line[position + 1]

	try
		let match_pair = g:delete_pairs[current_char]
	catch
		let match_pair = '  '
	endtry

	if match_pair == next_char
		return "\<BS>\<DEL>"
	else
		return "\<BS>"
	endif
endfunction

" Tab commands
map <leader>bd :Bclose<cr>:tabclose<cr>gT

map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

command! Bclose call <SID>BufcloseCloseIt()
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

" Source local environment
source $NVIM_CONFDIR/env.vim
source $NVIM_CONFDIR/plugins.vim
source $NVIM_CONFDIR/filetypes.vim
try
	source .local.vim
catch
endtry

color gruvbox
set background=dark
hi MatchParen cterm=bold ctermbg=0 ctermfg=6