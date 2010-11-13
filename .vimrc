" """""""""""""""""""""""
" TODO Add the SuperTab plugin and pathogen util
" http://www.vim.org/scripts/script.php?script_id=1643
" """""""""""""""""""""""
if ! has("gui_running")
    set t_Co=256
endif
:syntax enable
" feel free to choose :set background=light for a different style
:set background=dark
:colors peaksea 
:set number
:set numberwidth=2
:set hlsearch
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
map <F2> :WMToggle<cr>

" NERDTree mappings
map <F3> :NERDTreeToggle<CR>

" Window Mappings
map <C-J> <C-W>j<C-W>10+
map <C-K> <C-W>k<C-W>10+
map <C-L> <C-W>l<C-W>10+
map <C-H> <C-W>h<C-W>10+
map <C-K> <C-W>k<C-W>10+

" tab navigation like firefox
:nmap <Tab> :tabnext<CR>
:map <Tab> :tabnext<CR>
" :imap <Tab> <Esc>:tabnext<CR>i
:nmap <S-Tab> :tabprevious<CR>
:map <S-Tab> :tabprevious<CR>
" :imap <S-Tab> <Esc>:tabprevious<CR>i
:nmap <C-T> :tabnew<CR>
:imap <C-T> <Esc>:tabnew<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let g:ftplugin_sql_omni_key = '<C-C>'

