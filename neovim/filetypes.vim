"{{{ -> Terminal Buffer
""""""""""""""""""""""""""""""
augroup term_enter
	au TermOpen * set nonu | set nornu
augroup end
"}}}

" -> Vim section {{{
 autocmd FileType vim setlocal keywordprg=":help"
" }}} -> Vim section

"{{{ -> Python section
""""""""""""""""""""""""""""""
let g:python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au Filetype python packadd vim-flake8
au Filetype python packadd deoplete-jedi

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- <esc>a
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
au FileType python setlocal cindent
au FileType python setlocal cinkeys-=0#
au FileType python setlocal indentkeys-=0#
au FileType python setlocal makeprg=python3\ -m\ flake8\ %
"}}}

"{{{ -> Json
""""""""""""""""""""
au FileType json setlocal tabstop=2
au FileType json setlocal shiftwidth=2
au FileType json setlocal expandtab
"}}}

"{{{ -> Html section
""""""""""""""""""""""""""""""
let g:html_indent_inctags = "style,html,body,head,tbody"
let g:html_indent_autotags = "th,td,tr,tfoot,thead"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
augroup html_editor
	au Filetype html,htmldjango,css,javascript,xml,php,eruby packadd emmet-vim
	au Filetype html,htmldjango setlocal tabstop=2
	au Filetype html,htmldjango setlocal shiftwidth=2
	au Filetype html,htmldjango nnoremap <silent> <buffer> <localleader>o :call RenderHtml()<CR><CR>
	au Filetype html,htmldjango inoremap <silent> <buffer> <C-l> <ESC>:call emmet#moveNextPrev(0)<CR>
	au Filetype html,htmldjango inoremap <silent> <buffer> <C-h> <ESC>:call emmet#moveNextPrev(1)<CR>
	au Filetype css nnoremap <silent> <buffer> <localleader>i :call Internetify()<CR>
	au Filetype css inoremap <silent> <buffer> <localleader>i :call Internetify()<CR>
	au FileType html,htmldjango,css setlocal omnifunc=csscomplete#CompleteCSS
augroup end
"}}}

"{{{ -> Lisp section
""""""""""""""""""""""""""""""
au Filetype lisp setlocal tabstop=2
au Filetype lisp setlocal shiftwidth=2
au Filetype lisp setlocal expandtab
"}}}

"{{{ -> Git section
""""""""""""""""""""""""""""""
au Filetype gitcommit setlocal spell
"}}}

"{{{ -> Markdown section
""""""""""""""""""""""""""""""
au Filetype markdown packadd vim-markdown

au Filetype markdown command! Openmd call RenderMarkdown()
au Filetype markdown command! -nargs=1 Ngrep vimgrep "<args>" $NOTES_DIRECTORY/**/*.md
au Filetype markdown nnoremap <buffer> <localleader>[ :Ngrep 
au Filetype markdown nnoremap <buffer> <localleader>es :call EditCodeBlock()<CR>
au Filetype markdown nnoremap <buffer> <localleader>o :w<CR>:Openmd<CR><CR>
au Filetype markdown nnoremap <buffer> <localleader>ep :w!<CR>:exe "!pandoc -o ~/Documents/" . fnameescape(expand('%:p:t:r')) . ".pdf < " . fnameescape(expand('%:p')) . " "<cr>
au Filetype markdown nnoremap <buffer> <localleader>eP :w!<CR>:exe "!pandoc -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".pdf " . fnameescape(expand('%:p:h')) . "/*.md" <cr>
au Filetype markdown nnoremap <buffer> <localleader>eh :w!<CR>:exe "!pandoc -s -r markdown -f markdown_mmd -w html -o " . fnameescape(join([expand('%:p:h'), expand('%:p:t:r')], "/")) . ".html < " . fnameescape(expand('%:p')) . " "<cr>
au Filetype markdown nnoremap <buffer> <localleader>eH :w!<CR>:exe "!pandoc -s -r markdown -f markdown_mmd -w html -o " . fnameescape(join([expand('%:p:h'), expand('%:p:h:t')], "/")) . ".html " . fnameescape(expand('%:p:h')) . "/*.md"<cr>
au Filetype markdown nnoremap <buffer> <localleader>eb :w!<CR>:exe "!pandoc -V fontsize=8pt " . fnameescape(expand('%:p')) . " -t beamer -o ".  fnameescape(expand('%:p:r')) . ".pdf"<CR>
au Filetype markdown setlocal shiftwidth=2
au Filetype markdown setlocal tabstop=2
au Filetype markdown setlocal expandtab
au Filetype markdown setlocal spell
au Filetype markdown setlocal wrap
au Filetype markdown setlocal textwidth=80
"}}}

"{{{ -> JavaScript section
"""""""""""""""""""""""""""""""
au Filetype javascript,javascript.jsx packadd deoplete-ternjs
au Filetype javascript,javascript.jsx packadd tern_for_vim

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript nnoremap <silent> <buffer> K <esc>:TernDoc<CR>

au FileType javascript imap <buffer> <c-t> $log();<esc>hi
au FileType javascript imap <buffer> <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi
au Filetype javascript setlocal tabstop=4
au Filetype javascript setlocal shiftwidth=4
au Filetype javascript setlocal expandtab

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
"}}}

" -> Ruby section {{{
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

au Filetype ruby,xruby packadd vim-ruby
au Filetype ruby,xruby packadd vim-rails
au Filetype ruby,xruby packadd vim-rake

au Filetype ruby,eruby set tabstop=2
au Filetype ruby,eruby set shiftwidth=2
au Filetype ruby,eruby set expandtab
au Filetype ruby,eruby nnoremap <silent> <buffer> <localleader>o :!firefox localhost:3000 2>/dev/null &<CR>
" }}} -> Ruby

"{{{ -> Assembly section
"""""""""""""""""""""""""""""""
au FileType asm setlocal ft=nasm
au FileType asm setlocal commentstring=;\ %s
"}}}

"{{{ -> Latex section
au FileType plaintex setlocal ft=tex
au FileType tex setlocal expandtab
au FileType tex setlocal tabstop=2
au FileType tex setlocal shiftwidth=2
au FileType tex setlocal spell
au FileType tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
"}}}

"{{{ -> C section
au Filetype c,cpp packadd deoplete-clang

au Filetype c highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au Filetype c match OverLength /\%121v.\+/
au FileType c setlocal commentstring=//\ %s
au FileType cpp setlocal commentstring=//\ %s
"}}}

" -> Quickfix {{{
autocmd QuickFixCmdPost [^l]* cwindow
" }}} -> Quickfix
