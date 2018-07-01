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

"{{{ -> ultisnips
""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="s-<tab>"
let g:ultisnips_python_style="jedi"
"}}}

"{{{ -> Gundo
""""""""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_help = 0
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

" -> Sneak {{{
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#label = 1
" }}}
