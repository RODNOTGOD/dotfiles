set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command maps for new plugins and shortcuts
" All specified here
"""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\<Space>"
let maplocalleader = ";"

nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>sv :source ~/.vimrc<CR>
nmap <silent> <leader>ez :e ~/.zshrc<CR>

" Splitting Commands
map <leader>\| :vsplit<CR>
map <leader>- :split<CR>

map <leader>\|l :vertical-resize +5<CR>
map <leader>\|h :vertical-resize -5<CR>

map <leader>-k :resize +5<CR>
map <leader>-j :resize -5<CR>

map <leader>x :x!<CR>

" Better buffer
nnoremap <C-o> :CtrlPBuffer<CR>
map <leader>q :CtrlP<CR>

" ALWAYS USE TABS QUEER BOY
set tabstop=4
set noexpandtab

" Copy & Paste
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

"""""""""""""""""""""""""""""
" Fugitive Plugin keybindings
"""""""""""""""""""""""""""""
nnoremap <Leader>gc :Gcommit<Space>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gl :silent! Glog<CR>
nnoremap <Leader>gl :silent! Glog<CR>:set nofoldenable<cr>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gk :!git checkout<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>

"""""""""""""""""""""""""""
" CtrlP Plugin keybindings
"""""""""""""""""""""""""""
map <Leader>f :CtrlPMRUFiles<CR>

"""""""""""""""""""""""""
" Gundo Plugin keybinding
"""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color and visual effects
" Pretties up the place
""""""""""""""""""""""""""""""

color tender
"set background=light
"set background=dark
set nu
set rnu

" Show trailing characters
set noshowmode
set list
" set listchars=eol:¬,tab:»\ ,trail:·,nbsp:⎵
set listchars=eol:¬,tab:»\ ,trail:·

" Multi-cursor highlight fix
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

" Toggles absolute numbers to relative
function! NumberToggle()
    if(&relativenumber == 1)
        set rnu!
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings all placed under here
"""""""""""""""""""""""""""""""""""""""""

:let g:gitgutter_enabled = 1

:let g:org_agenda_files=['~/org/index.org']


" Goyo Vim Plugin
""""""""""""""""""""
function! s:goyo_enter()
	silent !tmux set status off
	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	set nolist
	set noshowcmd
	set scrolloff=999
	color tender
	" ...
endfunction

function! s:goyo_leave()
	silent !tmux set status on
	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	set list
	set showcmd
	set scrolloff=5
	color tender
	" ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Emmet Vim Plugin
"""""""""""""""""""""
let g:user_emmet_install_global = 0
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

" Gundo Vim Plugin
"""""""""""""""""""""
let g:gundo_preview_bottom = 1
let g:gundo_right = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LIGHT LINE SECTION
" Complete functions to a pretty lightline bar
" All functions are found on the lightline github
"""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction


function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ' '
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specification
""""""""""""""""""""""""""""""""""""""

" Org mode
au Filetype org set expandtab

" Html mode
au Filetype html,css set tabstop=2
au Filetype html,css set shiftwidth=2
au Filetype html,css EmmetInstall

" Lisp mode
au Filetype lisp set tabstop=2
au Filetype lisp set shiftwidth=2
au Filetype lisp set expandtab

" Markdown mode
au Filetype markdown command! Openmd !firefox % >/dev/null 2>/dev/null &
au Filetype markdown command! -nargs=1 Ngrep vimgrep "<args>" $NOTES_DIR/**/*.md
au Filetype markdown nnoremap <localleader>[ :Ngrep 
au Filetype markdown nnoremap <localleader>o :Openmd<CR><CR>
au Filetype markdown nnoremap <localleader>ep :w!<cr>:exe "!pandoc -s --latex-engine=lualatex -f markdown_mmd -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".pdf < $(find " . fnameescape(expand('%:p:h')) . " -iname \"*.md\")"<cr>
au Filetype markdown nnoremap <localleader>eh :w!<cr>:exe "!pandoc -r markdown -f markdown_mmd -w html -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".html < $(find " . fnameescape(expand('%:p:h')) . " -iname \"*.md\")"<cr>
au Filetype markdown set expandtab
au Filetype markdown set spell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

try
source ~/.vim_runtime/my_configs.vim
catch
endtry
