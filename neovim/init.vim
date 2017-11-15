set nocompatible
filetype off

"{{{ Vim-Plug Check
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"{{{ Env Variables
set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

let $NVIM_CONF='~/.config/nvim/init.vim'
let $NVIM_CONFDIR='~/.config/nvim'
let $NVIM_DIR='~/.local/share/nvim'
"}}}

"{{{ Github Plugins
Plug 'vim-syntastic/syntastic', {'for': 'nasm'}
Plug 'sjl/gundo.vim'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'amix/open_file_under_cursor.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mattn/emmet-vim', {'for': ['html', 'htmldjango', 'css', 'javascript', 'xml']}
Plug 'vim-scripts/vis'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'neomake/neomake'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-clang', {'for' : ['c', 'cpp'] }
Plug 'zchee/deoplete-jedi', {'for' : 'python'}
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx']}
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do' : 'npm install && npm install -g tern' }
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'maksimr/vim-jsbeautify', {'for'  : ['javascript', 'javascript.jsx']}
Plug 'lervag/vimtex', {'for' : ['tex', 'plaintex']}
Plug 'wincent/loupe'
Plug 'dag/vim-fish', {'for': 'fish'}

" Non maintained plugins
Plug 'file:///home/kragendor/.local/share/nvim/local-plugs/betterdigraphs_utf8'

call plug#end()
"}}}

"{{{ Mappings

" Leader mapping
"""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
let maplocalleader = ","

" Movement
"""""""""""
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
" nnoremap <C-y> 3<C-y>

nnoremap <C-e> 3<C-e>
noremap <expr> <C-y> (line("w0") <= 1 ? "k" : "3\<C-y>")

inoremap <C-H> <C-W>

nnoremap <leader>i :set cursorline!<CR>

vnoremap >> >gv
vnoremap << <gv

nmap <M-;> oi<ESC>gcckJfis
imap <M-;> <ESC>oi<ESC>gcckJfis

" Terminal mapping
"""""""""""""""""""
noremap <F2> :vsplit<CR><C-w>l:set nornu<CR>:set nonu<CR>:terminal<CR>
tnoremap <C-[> <C-\><C-n>

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
" map <leader>ss :setlocal spell!<cr>

" quickfix menu
nnoremap <localleader>co :silent! copen <BAR> lopen<CR>
nnoremap <localleader>cc :silent! cclose <BAR> lclose<CR>
" nnoremap <localleader>cn :silent! cn <BAR> lN<CR>
" nnoremap <localleader>cp :silent! cp <BAR> lp<CR>


nnoremap <C-n> :call NumberToggle()<cr>


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

command! MakeTags !ctags -f .tags -R .

" Visual modes
"""""""""""""""
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap v <C-v>
nnoremap <C-v> v
vnoremap v <C-v>
vnoremap <C-v> v

"}}}

"{{{ Functions
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

function! Internetify()
	let l:currLine = getline('.')
	let l:splice = join(split(l:currLine))

	for l:name in ["-o-", "-moz-", "-webkit-"]
		let l:compatLine = "\t" . l:name . l:splice . "\n"
		let o = @o
		let @o = l:compatLine
		normal! "oP
		let @o = o
	endfor
endfunction

function! Beautify()
	let l:fileType = &ft
	if l:fileType ==  'html'
		call HtmlBeautify()
	elseif l:fileType == 'css'
		call CSSBeautify()
	elseif l:fileType == 'javascript'
		call JsBeautify()
	elseif l:fileType == 'json'
		call JsonBeautify()
	elseif l:fileType == 'jsx'
		call JsxBeautify()
	endif
endfunction

" Windows and pane movement
""""""""""""""""""""""""""""
nnoremap 0 ^

" Clear highlighting
" map <silent> <leader><cr> :noh<cr>

" Switch through panes
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

" buffer commands
nnoremap <TAB> :b#<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>
map <leader>bn :Bnew<cr><C-w>L
" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" Tab commands
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext

nnoremap <M-l> :call Beautify()<cr>

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

command! Bnew call <SID>CreateNewBuf()
fun! <SID>CreateNewBuf()
	new
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endf

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

function! NumberToggle()
    if(&relativenumber == 1)
        set nornu
    else
        set relativenumber
		set nu
    endif
endfunc

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

" Delete Brackets if together
function! CloseBrackets(cmd)
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
		" return "\<BS>\<DEL>"
		return a:cmd+"\<DEL>"
	else
		" return "\<BS>"
		return a:cmd
	endif
endfunction

"}}}

"{{{ Source local environment
source $NVIM_CONFDIR/env.vim
source $NVIM_CONFDIR/plugins.vim
source $NVIM_CONFDIR/filetypes.vim
try
	source .local.vim
catch
endtry
"}}}

"{{{ Colors
color onedark
"}}}
