"{{{ -> bufExplorer plugin
""""""""""""""""""""""""""""""
" let g:bufExplorerDefaultHelp=0
" let g:bufExplorerShowRelativePath=1
" let g:bufExplorerFindActive=1
" let g:bufExplorerSortBy='name'
" map <Leader>o :BufExplorer<cr>
"}}}

"{{{ -> YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-P> <Plug>yankstack_substitute_newer_paste
"}}}

"{{{ -> FZF
""""""""""""""""""""""""""""""
nmap <C-o> :Buffers<CR>
nmap <leader>f :History<CR>
nmap <leader>/ :Ag<CR>
nmap <C-_> :Lines<CR>
nmap <C-F> :Files<CR>
"}}}

"{{{ -> CTRL-P
""""""""""""""""""""""""""""""
" let g:ctrlp_working_path_mode = 0

" let g:ctrlp_map = '<c-f>'
" map <C-o> :CtrlPBuffer<CR>
" map <Leader>j :CtrlP<cr>
" map <Leader>f :CtrlPMRUFiles<CR>

" let g:ctrlp_max_height = 20
" let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
"}}}

"{{{ -> ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'
"}}}

"{{{ -> snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
"}}}

"{{{ -> ultisnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}

"{{{ -> Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH
"}}}

"{{{ -> Gundo
""""""""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_help = 0
"}}}

"{{{ -> Drag Visual
""""""""""""""""""""""""""""""
vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')
let g:DVB_TrimWS = 1
"}}}

"{{{ -> Better Digraphs
""""""""""""""""""""""""""""""
inoremap <expr> <C-K> BDG_GetDigraph()
"}}}

"{{{ -> List Trans
""""""""""""""""""""""""""""""
nmap <localleader>l :call ListTrans_toggle_format()<CR>
vmap <localleader>l :call ListTrans_toggle_format('visual')<CR>
"}}}

"{{{ -> Vmath
""""""""""""""""""""""""""""""
vmap <silent><expr> <leader>m++ VMATH_YankAndAnalyse()
nmap <silent>       <leader>m++ vip++
"}}}

"{{{ -> Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
"}}}

"{{{ -> VimFiler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimfiler_as_default_explorer = 1
map <leader>nn :VimFiler<CR>
map <leader>nf :VimFilerBufferDir<CR>
map <leader>nt :VimFilerExplorer<CR>
"}}}

"{{{ -> vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
"}}}

"{{{ -> Better White Space
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:better_whitespace_filetypes_blacklist=['markdown', 'diff', 'gitcommit', 'unite', 'qf', 'help']
"}}}

"{{{ -> Emmet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
			\ 'php' : {
			\   'extends' : 'html',
			\   'filters' : 'c',
			\ },
			\ 'xml' : {
			\   'extends' : 'html',
			\ },
			\ 'haml' : {
			\   'extends' : 'html',
			\ },
			\ }
"}}}

"{{{ -> lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ], ['ctrlpmark'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'neomake_errors', 'neomake_warnings', ] ]
      \ },
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'fileencoding': 'LightLineFileencoding',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'neomake_errors': 'LightLineNeomakeErrors',
      \   'neomake_warnings': 'LightLineNeomakeWarnings',
      \ },
      \ 'component_type': {
      \   'neomake': 'error',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ' '
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

function! LightLineNeomakeErrors()
  if !exists(":Neomake") || ((get(neomake#statusline#QflistCounts(), "✖", 0) + get(neomake#statusline#LoclistCounts(), "✖", 0)) == 0)
    return ''
  endif
  return '✖:'.(get(neomake#statusline#LoclistCounts(), '✖', 0) + get(neomake#statusline#QflistCounts(), '✖', 0))
endfunction

function! LightLineNeomakeWarnings()
  if !exists(":Neomake") || ((get(neomake#statusline#QflistCounts(), "⚠", 0) + get(neomake#statusline#LoclistCounts(), "⚠", 0)) == 0)
    return ''
  endif
  return '⚠:'.(get(neomake#statusline#LoclistCounts(), '⚠', 0) + get(neomake#statusline#QflistCounts(), '⚠', 0))
endfunction
"}}}

"{{{ -> Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

function! s:goyo_enter()
	silent !tmux set status off
	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	set nolist
	set noshowcmd
	set scrolloff=999
	color onedark
	" ...
endfunction

function! s:goyo_leave()
	silent !tmux set status on
	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	set list
	set showcmd
	set scrolloff=3
	color onedark
	" ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"}}}

"{{{ -> Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" Python
let g:syntastic_python_checkers=['flake8']

" Javascript
let g:syntastic_javascript_checkers = ['jslint']
"}}}

"{{{ -> neomake (syntax checker)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Every write
autocmd! BufWritePost * nested Neomake

" Python
let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['flake8']

" Cpp
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++-5.0',
   \ 'args': ['-std=c++11', '-fsyntax-only', '-Wunused', '-Wall', '-Wextra'],
   \ }

" JS
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd User NeomakeFinished nested call lightline#update()
set statusline+=\ %#ErrorMsg#%{neomake#statusline#QflistStatus('qf:\ ')}
"}}}

"{{{ -> Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
nnoremap <silent> <leader>d :GitGutterToggle<cr>
"}}}

"{{{ -> Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gc :Gcommit<Space>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gl :silent! Glog<CR>
nnoremap <Leader>gL :silent! Glog<CR>:set nofoldenable<cr>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gk :!git checkout<Space>
nnoremap <Leader>gb :Gblame<CR>
" nnoremap <Leader>gb :Gblame<CR> nnoremap <Leader>go :Git checkout<Space>
set diffopt+=filler,vertical
"}}}

"{{{ -> Rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
" \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
let g:rainbow_conf = {
   \   'guifgs': ['royalblue1', 'darkgoldenrod3', 'seagreen3', 'indianred1'],
   \   'ctermfgs': ['37', '109', '132', '75'],
   \   'operators': '_,_',
   \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
   \   'separately': {
   \       '*': {},
   \       'tex': {
   \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
   \       },
   \       'lisp': {
   \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
   \       },
   \       'vim': {
   \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
   \       },
   \       'html': {
   \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'] ,
   \       },
   \       'css': 0,
   \   }
   \}
let g:vimfiler_force_overwrite_statusline = 0
let g:unite_force_overwrite_statusline = 0
"}}}

"{{{ -> Vim-Devicons
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:webdevicons_enable_vimfiler = 1
"}}}

"{{{ -> Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <C-f> :Unite -no-split -buffer-name=files -start-insert file_rec/async<CR>
" nnoremap <C-o> :Unite -no-split -buffer-name=buffer -start-insert buffer<CR>
" nnoremap <Leader>u :Unite grep:. -buffer-name=grep<CR>
" nnoremap <Leader>f :Unite -no-split -buffer-name=mru -start-insert file_mru<CR>

" " Custom mappings for the unite buffer
" autocmd FileType unite call s:unite_settings()
" function! s:unite_settings()
" 	" Enable navigation with control-j and control-k in insert mode
" 	imap <buffer> <C-j>   <Plug>(unite_select_next_line)
" 	imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
" endfunc
""}}}

"{{{ -> Eclim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EclimFileTypeValidate = 0

fun! SetupProject()
	let s:file = expand('~/.eclim/.eclimd_instances')
	if filereadable(s:file)
		!cp ~/Templates/JavaVim.template .local.vim
	endif
endf
"}}}

"{{{ -> Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-5.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
"}}}

"{{{ -> Vim-Easy-Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

"{{{ -> Loupe
map <silent> <leader><cr> <Plug>(LoupeClearHighlight)
"}}}
