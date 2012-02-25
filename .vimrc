filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" """""""""""""""""""""""
" TODO Add the SuperTab plugin and pathogen util
" http://www.vim.org/scripts/script.php?script_id=1643
" Add plugins (last vimcasts) + double ",>,( etc + % for ' , > (
" """""""""""""""""""""""
" if ! has("gui_running")
    set t_Co=256
" endif
:syntax enable
" feel free to choose :set background=light for a different style
:set background=dark
:colors peaksea 
:set number
:set numberwidth=2
:set ts=2 sts=2 sw=2 expandtab smartindent
" Usability options
" :set virtualedit=onemore          " allow for cursor beyond last character
:set history=1000                 " Store a ton of history (default is 20)
:set backspace=indent,eol,start   " backspace for dummys
:set incsearch                    " find as you type search
:set hlsearch                     " highlight search terms
:set ignorecase                   " case insensitive search
:set smartcase                    " case sensitive when uc present
:set wildmenu                     " show list instead of just completing
:set wildmode=list:longest,full   " comand <Tab> completion, list matches,
:set formatprg=par\ -jreq         " par formatter
:set formatoptions+=t             " autoformat from vim's formatter
:set textwidth=72                 " for vim's auto formatter
" Using , as a map leader -- Define ",," to equal a current ,!
:let mapleader = ","

:helptags ~/.vim/doc
" snipMate Plugin
:filetype plugin indent on

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
map <F2> :WMToggle<cr><C-W><C-W>

" NERDTree mappings
map <F3> :NERDTreeToggle<CR>

" SpellCheck
map <F4> :set spell!<CR>

" Wrap
"map <F5> :set wrap!<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Ctags
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 40
map <F6> :TlistToggle<cr><C-h>
map <F7> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" TODO
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR> 

" Window Mappings
map <C-J> <C-W>j<C-W>10+
map <C-K> <C-W>k<C-W>10+
map <C-L> <C-W>l<C-W>10+
map <C-H> <C-W>h<C-W>10+
map <C-K> <C-W>k<C-W>10+

map <C-S-J> a<CR><Esc>k$


" tab navigation a la firefox
:nmap <C-N> :tabnext<CR>
:map <C-N> :tabnext<CR>
" :imap <Tab> <Esc>:tabnext<CR>i
:nmap <C-P> :tabprevious<CR>
:map <C-P> :tabprevious<CR>
" :imap <S-Tab> <Esc>:tabprevious<CR>i
" :nmap <C-T> :tabe
" :imap <C-T> <Esc>:tabe<CR>

" AWESOME IDEA!
:imap <F1> <Esc>a

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete
" improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold
" Hucks for SQL completion
let g:ftplugin_sql_omni_key = '<C-C>'

" Options for Ruby Completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ? "\<lt>C-n>" : "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" . "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" . "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
" inoremap <expr> <C-Space> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-Space> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" HOW TO REMAP COMMENTS TO CTRL-/ AND CTRL-S-/
inoremap ,c <C-o>:call NERDComment(0,"toggle")<C-m>
" map <Leader>c ,c<space>

" latex plugin
let g:tex_flavor='latex'

" Fuzzy Finder 
" ctags -R --extra=+f .
map <Leader>e :FufBuffer<CR>
map <Leader>f :FufFile<CR>
map <Leader>d :FufDir<CR>
map <Leader>mf :FufMruFile<CR>
map <Leader>m :FufMruCmd<CR>
map <Leader>b :FufBookmark<CR>
map <Leader>t :FufTag<CR>
map <Leader>rf :FufTaggedFile<CR>
map <Leader>j :FufJumpList<CR>
map <Leader>c :FufChangeList<CR>
map <Leader>q :FufQuickfix<CR>
map <Leader>l :FufLine<CR>
map <Leader>h :FufHelp<CR>
" remaping ; to :
map ; :
noremap ;; ;
" edit command-line
map q; q:
" This is for pasting
" We need to add for spelling etc
:set pastetoggle=<Leader>p  
" Add for real esc in insert mode
imap <C-c> <Esc>

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Return to last edit position 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

cmap w!! w !sudo tee >/dev/null %
map ZS :w!!<CR>
" do not forget custom file commands
" :autocmd bufenter *.tex map <F1> :!latex %<CR>
