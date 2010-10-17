if ! has("gui_running")
    set t_Co=256
endif
:syntax enable
" feel free to choose :set background=light for a different style
:set background=dark
:colors peaksea 
:set number
:set numberwidth=2
:helptags ~/.vim/doc
" snipMate Plugin
:filetype plugin on

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1

""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""""
"let g:miniBufExplorerMoreThanOne = 2 
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 20
let g:miniBufExplSplitBelow=0
"let g:bufExplorerSortBy = "name"
"autocmd BufRead,BufNew :call UMiniBufExplorer
"map <leader>u :TMiniBufExplorer<cr>:TMiniBufExplorer<cr>

" WinManager mappings
map <F7> :FirstExplorerWindow<cr>
map <F8> :BottomExplorerWindow<cr>
map <F5> <c-w><c-w>
map <c-w><c-t> :WMToggle<cr>
