"{{{ -> YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-P> <Plug>yankstack_substitute_newer_paste
"}}}

"{{{ -> FZF
""""""""""""""""""""""""""""""
nmap <leader><leader> :Commands<CR>
nmap <leader>o :Buffers<CR>
nmap <leader>f :History<CR>
nmap <leader>/ :Ag<CR>
nmap <C-_> :Lines<CR>
nmap <C-F> :Files<CR>
let g:fzf_height = '25%'
"}}}

"{{{ -> ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'
"}}}

"{{{ -> Supertab
""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = '<c-n>'
"}}}

"{{{ -> ultisnips
""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="s-<tab>"
let g:ultisnips_python_style="jedi"
"}}}

"{{{ -> Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn .git generated'
if executable('ag')
	set grepprg=ag\ --vimgrep\ $*
	set grepformat=%f:%l:%c:%m
else
	set grepprg=/bin/grep\ -nH
endif
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
" vmap  <expr>  <S-LEFT>   DVB_Drag('left')
" vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
" vmap  <expr>  <S-DOWN>   DVB_Drag('down')
" vmap  <expr>  <S-UP>     DVB_Drag('up')
" let g:DVB_TrimWS = 1
"}}}

"{{{ -> Better Digraphs
""""""""""""""""""""""""""""""
" inoremap <expr> <C-K> BDG_GetDigraph()
"}}}

"{{{ -> Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
let g:NERDTreeHijackNetrw=0
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapUpdir='h'
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
"}}}

"{{{ -> Netrw
"""""""""""""""""""""""""""""
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

let g:netrw_altv = 1
let g:netrw_winsize = 15
let g:netrw_preview   = 1

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    nmap <buffer> h -
    nmap <buffer> l <cr>
    nmap <buffer> e %
    nmap <buffer> <silent>qq :bd<CR>:silent! windo close<CR>
endfunction
"}}}

"{{{ -> vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
"}}}

"{{{ -> vim-markdown
"""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
"}}}

"{{{ -> Better White Space
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:better_whitespace_filetypes_blacklist=['markdown', 'diff', 'gitcommit', 'unite', 'qf', 'help']
"}}}

"{{{ -> Emmet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ], ['linter_errors', 'linter_warnings', 'linter_ok' ], ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'fileencoding': 'LightLineFileencoding',
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'lightline#ale#warnings',
	  \   'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
	  \   'linter_warnings': 'warning',
	  \   'linter_errors': 'error',
      \ },
	  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &readonly && &filetype !~# '\v(help|vimfiler|unite|netrw)' ? '' : ''
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

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "⚠"
let g:lightline#ale#indicator_errors = "✖"
"}}}

"{{{ -> Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=120
" let g:goyo_margin_top = 2
" let g:goyo_margin_bottom = 2
let g:goyo_intro = 0
nnoremap <silent> <leader>z :Goyo<cr>

function! s:goyo_enter()
	silent !tmux set status off
	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	silent call lightline#disable()
	set nolist
	set noshowcmd
	set scrolloff=999
	let g:goyo_intro = 1
	" color dracula
	ALEDisable
	" ...
endfunction

function! s:goyo_leave()
	silent !tmux set status on
	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	set list
	set showcmd
	set scrolloff=3
	let g:goyo_intro = 0
	" color dracula
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
	ALEEnable
	silent call lightline#enable()
	call lightline#update()
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

"{{{ -> ALE
" CPP CHECKER
let g:ale_linters = {'cpp': ['clang', 'cppcheck']}
let g:ale_cpp_clang_executable='clang++'
let g:ale_cpp_clang_options='-std=c++14 -Wall -Wextra'

" FLAKE8 CHECKER
let g:ale_python_flake8_options='--max-line-length=110 --ignore=E402'

let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
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
nnoremap <Leader>gL :silent! Glog --<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gk :!git checkout<Space>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>go :Git checkout<Space>
set diffopt+=filler,vertical
"}}}

"{{{ -> Rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
   \ '		html': 0,
   \       'css': 0,
   \   }
   \}
let g:rainbow_active = 1
"}}}

"{{{ -> Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt-=preview
set completeopt+=noinsert
set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang-5.0.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
let g:deoplete#sources#jedi#server_timeout = 40

let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]


if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
"}}}

"{{{ -> Vim-Easy-Align
xmap gea <Plug>(EasyAlign)
nmap gea <Plug>(EasyAlign)
"}}}

"{{{ -> Loupe
map <silent> <leader><cr> <Plug>(LoupeClearHighlight)
"}}}
