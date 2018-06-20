set nocompatible
filetype off

"{{{ Env Variables
set rtp+=~/.fzf
let $NVIM_CONF='~/.config/nvim/init.vim'
let $NVIM_CONFDIR='~/.config/nvim'
let $NVIM_DIR='~/.local/share/nvim'
"}}}

"{{{ Github Plugins

if empty(glob('~/.config/nvim/pack/minpac'))
	silent !git clone https://github.com/k-takata/minpac.git
				\ ~/.config/nvim/pack/minpac/opt/minpac
endif

silent! packadd minpac
if exists('*minpac#init')
	call minpac#init()

	call minpac#add('sjl/gundo.vim')
	call minpac#add('SirVer/ultisnips')
	call minpac#add('romainl/Apprentice')
	call minpac#add('lifepillar/vim-solarized8')
	call minpac#add('scrooloose/nerdtree')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-commentary')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-vinegar')
	call minpac#add('tpope/vim-rsi')
	call minpac#add('tpope/vim-abolish')
	call minpac#add('airblade/vim-gitgutter')
	call minpac#add('nvie/vim-flake8', {'type': 'opt'})
	call minpac#add('honza/vim-snippets')
	call minpac#add('junegunn/vim-easy-align')
	call minpac#add('junegunn/fzf.vim')

	call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})
	call minpac#add('mattn/emmet-vim', {'type': 'opt'})
	call minpac#add('vim-ruby/vim-ruby', {'type': 'opt'})
	call minpac#add('tpope/vim-rails', {'type': 'opt'})
	call minpac#add('tpope/vim-rake', {'type': 'opt'})
	call minpac#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'})
	call minpac#add('zchee/deoplete-clang', {'type': 'opt'})
	call minpac#add('zchee/deoplete-jedi', {'type': 'opt'})
	call minpac#add('carlitux/deoplete-ternjs', {'type': 'opt'})
	call minpac#add('ternjs/tern_for_vim', {'type': 'opt'})
	call minpac#add('AndrewRadev/splitjoin.vim')
	call minpac#add('wincent/loupe')
	call minpac#add('freitass/todo.txt-vim', {'type': 'opt'})

	command! PackUpdate packadd minpac | source $NVIM_CONF | call minpac#update()
	command! PackClean  packadd minpac | source $NVIM_CONF | call minpac#clean()
endif
"}}}

"{{{ Mappings

" Leader mapping
"""""""""""""""""
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Movement
"""""""""""
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

vnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> ^ g^
vnoremap <silent> $ g$

nnoremap <C-e> 3<C-e>
noremap <expr> <C-y> (line("w0") <= 1 ? "k" : "3\<C-y>")

inoremap <C-H> <C-W>
inoremap <C-J> <CR><ESC>O

nnoremap <silent> gm :call cursor(0, len(getline('.')) / 2)<CR>

nnoremap c* *Ncgn

vnoremap >> >gv
vnoremap << <gv

nmap <silent> <M-;> oi<ESC>:Commentary<CR>^d0i<BS><SPACE><ESC>==$:call search('i', 'bc')<CR>s
imap <silent> <M-;> <ESC>oi<ESC>:Commentary<CR>^d0i<BS><SPACE><ESC>==$:call search('i', 'bc')<CR>s


" Abbreviations
""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" Terminal mapping
"""""""""""""""""""
noremap <F2> :vsplit<CR><C-w>l:terminal<CR>i
noremap <leader>t. :terminal<CR>i
noremap <leader>th :vsplit<CR><C-w>h:terminal<CR>i
noremap <leader>tl :vsplit<CR><C-w>l:terminal<CR>i
noremap <leader>tk :split<CR><C-w>k:terminal<CR>i
noremap <leader>tj :split<CR><C-w>j:terminal<CR>i
noremap <leader>tt :tabnew<CR>:terminal<CR>i
noremap <expr> <leader>' ":botright " . winheight(0) / 3 . "split\<CR>:terminal\<CR>i"
tnoremap <C-[> <C-\><C-n>

" Read and Writing files
"""""""""""""""""""""""""
nmap <leader>x ZZ
nmap <leader>w :w!<cr>
command! W w !sudo tee % > /dev/null

" Override vim commands 'gf', '^Wf', '^W^F'
nnoremap gf :call GotoFile("")<CR>
nnoremap <C-W>f :call GotoFile("new")<CR>
nnoremap <C-W><C-F> :call GotoFile("new")<CR>

" *rc editing
nmap <silent> <leader>ev :e $NVIM_CONF<CR>
nmap <silent> <leader>et :e ~/.bashrc<CR>
nmap <silent> <leader>el :e .local.vim<CR>
nmap <silent> <leader>sv :source $NVIM_CONF<CR>

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

" quickfix menu
nnoremap <silent> <localleader>co :silent! copen <BAR> silent! lopen<CR>
nnoremap <silent> <localleader>cc :silent! cclose <BAR> silent! lclose<CR>

" Grep word under cursor
nnoremap <silent> gK :silent! grep! "\b<C-R><C-W>\b"<CR>
xnoremap gK :<C-u>call <SID>VSetSearch('/')<CR>:<C-U>silent! grep! -Q "<C-R>=@/<CR>"<CR>

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
inoremap $4 {<cr>}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" Command mode related
"""""""""""""""""""""""
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>
cno $q <C-\>eDeleteTillSlash()<cr>
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

command! MakeTags !ctags -f .tags -R .

" Visual modes
"""""""""""""""
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/\V<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?\V<C-R>=@/<CR><CR>

nnoremap v <C-v>
nnoremap <C-v> v
vnoremap v <C-v>
vnoremap <C-v> v


" Windows and pane movement
""""""""""""""""""""""""""""
nnoremap 0 ^

" Switch through panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Splitting Commands
map <leader>sk :belowright split<CR>
map <leader>sj :split<CR>
map <leader>sh :botright vsplit<CR>
map <leader>sl :vsplit<CR>

nmap <M-w> <C-W>\|<C-W>_
nmap <M-k> <C-W>k<C-W>\|<C-W>_
nmap <M-j> <C-W>j<C-W>\|<C-W>_
nmap <M-h> <C-W>h<C-W>\|<C-W>_
nmap <M-l> <C-W>l<C-W>\|<C-W>_
nmap <M-r> <C-w>=

nmap <C-Up> <C-W>+
nmap <C-Down> <C-W>-
nmap <C-Left> <C-W><
nmap <C-Right> <C-W>>

" Character Skip trick
inoremap <expr> <C-l> "\<Right>"
inoremap <expr> <C-h> "\<Left>"

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

map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>
"}}}

"{{{ Functions

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

command! StripWhitespace call StripTrailingWhitespace()

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? '('.l:branchname.'):' : ''
endfunction

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


function! Internetify()
    let l:currLine = getline('.')
    let l:splice = join(split(l:currLine))

    for l:name in ["-o-", "-ms-", "-moz-", "-webkit-"]
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

function! GotoFile(w)
    let curword = expand("<cfile>")
    if (strlen(curword) == 0)
        return
    endif
    let matchstart = match(curword, ':\d\+$')
    if matchstart > 0
        let pos = '+' . strpart(curword, matchstart+1)
        let fname = strpart(curword, 0, matchstart)
    else
        let pos = ""
        let fname = curword
    endif

    " check exists file.
    if filereadable(fname)
        let fullname = fname
    else
        " try find file with prefix by working directory
        let fullname = getcwd() . '/' . fname
        if ! filereadable(fullname)
            " the last try, using current directory based on file opened.
            let fullname = expand('%:h') . '/' . fname
        endif
    endif

   " Open new window if requested
    if a:w == "new"
		vert botright split
    endif
    " Use 'find' so path is searched like 'gf' would
    try
       execute 'find ' . pos . ' ' . fname
    catch
       let choice = confirm("Failed to find '" . fname . "'\nCreate file?", "&Yes\n&No", 2)
       if choice == 1
          exec "edit " . fname
       endif
    endtry
endfunction

function! TaskFinder(options)
    cexpr system("taskfinder " . a:options)
endfunction

command! -bar -nargs=* TaskFind call TaskFinder(<q-args>)

function! ScratchEdit(cmd, options)
    exe a:cmd tempname()
    setl buftype=nofile bufhidden=wipe nobuflisted
    if !empty(a:options) | exe 'setl' a:options | endif
endfunction

command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)


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
    setlocal bufhidden=wipe
    setlocal noswapfile
endf

function! CloseCodeBlock(filename, lower_bound, upper_bound)
    exe "normal! gg\"iyG"
    exe 'wincmd l'
    exe a:lower_bound . ',' . a:upper_bound 'd'
    exe (a:lower_bound - 1) . 'pu i'
    echo a:lower_bound
endfunction

function! EditCodeBlock()
    let g:saved_line = line('.')
    let g:buf_name = expand('%:t')
    let g:lower_bound = search("^```\\s*.*$", "bcn")
    let g:upper_bound = search("^```\\s*$", "cn")
    if g:lower_bound < g:upper_bound
        try
            let g:ft = split(getline(g:lower_bound), '\s')[1]
            silent exe "silent " . (g:lower_bound + 1) . ',' . (g:upper_bound - 1) . 'y  u'
            call ScratchEdit('vsplit', 0)
            exe 'pu! u'
            exe 'set ft=' . g:ft
            autocmd BufWipeout <buffer> call CloseCodeBlock(g:buf_name, (g:lower_bound + 1), (g:upper_bound - 1))
        catch
            echo 'bad block'
        endtry
    else
        echo 'Not valid code block'
    endif
endfunction

function! RenderMarkdown()
	if !buffer_exists("!grip")
		term  grip % 8090
		file !grip
		bprev
		exec "sleep 30m"
	endif
	!firefox localhost:8090 2>/dev/null &
endfunction

function! RenderHtml()
	if expand('%:t') ==# 'index.html'
		if !buffer_exists("!SimpleHTTPServer")
			term python2 -m SimpleHTTPServer 8080
			file !SimpleHTTPServer
			bprev
			exec "sleep 30m"
		endif
		!firefox localhost:8080 2>/dev/null &
	else
		!firefox % 2>/dev/null &
	endif
endfunction

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has('win16') || has('win32')
        let g:cmd_edited = substitute(g:cmd, '\\(.*\[\\\\]\\).*', '\\1', '')
    else
        let g:cmd_edited = substitute(g:cmd, '\\(.*\[/\]\\).*', '\\1', '')
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
    return a:cmd . ' ' . expand("%:p:h") . "/"
endfunc
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
