" -> Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- <esc>a
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#

" -> Html section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au Filetype html,css set tabstop=2
au Filetype html,css set shiftwidth=2
au Filetype html,css EmmetInstall
au Filetype html command! Openhtml !firefox % >/dev/null 2>/dev/null &
au Filetype html nnoremap <localleader>o :w<CR>:Openhtml<CR><CR>

" -> Lisp section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au Filetype lisp set tabstop=2
au Filetype lisp set shiftwidth=2
au Filetype lisp set expandtab

" -> Git section
""""""""""""""""""""""""""""""
au Filetype gitcommit set spell

" -> Markdown section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au Filetype markdown highlight ColorColumn ctermbg=red
au Filetype markdown call matchadd('ColorColumn', '\%81v', 100)
au Filetype markdown command! Openmd !firefox % >/dev/null 2>/dev/null &
au Filetype markdown command! -nargs=1 Ngrep vimgrep "<args>" $NOTES_DIRECTORY/**/*.md
au Filetype markdown nnoremap <localleader>[ :Ngrep 
au Filetype markdown nnoremap <localleader>o :w<CR>:Openmd<CR><CR>
au Filetype markdown nnoremap <localleader>ep :w!<CR>:exe "!pandoc -s --latex-engine=lualatex -f markdown_mmd -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".pdf < $(find " . fnameescape(expand('%:p:h')) . " -maxdepth 1 -iname \"*.md\")"<cr>
au Filetype markdown nnoremap <localleader>eh :w!<CR>:exe "!pandoc -s -r markdown -f markdown_mmd -w html -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".html < $(find " . fnameescape(expand('%:p:h')) . " -maxdepth 1 -iname \"*.md\")"<cr>
au Filetype markdown set shiftwidth=2
au Filetype markdown set tabstop=2
au Filetype markdown set expandtab
au Filetype markdown set spell

highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%101v', 100)

" -> JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

if exists('$TMUX')
    set term=screen-256color
endif
