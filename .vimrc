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
:set wildmode=list:longest,full   " command <Tab> completion, list matches,
:set formatprg=par\ -jreq         " par formatter
:set formatoptions+=t             " autoformat from vim's formatter
:set textwidth=72                 " for vim's auto formatter
:set spell                        " spell on the fly -- now default!
:set cursorline                   " show where the line is
:set autochdir                    " change directory automagically
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%04.8b]\ [HEX=\%04.4B]\ [LEN=%L]\ [POS=%04l,%04v][%p%%]
:set laststatus=2                 " set the status line visible at all times
:set list                         " show invisibles
:set shell=/bin/zsh\ -l          " set shell to my shell
:hi CursorLine   cterm=NONE ctermbg=235 guibg=black " 8 24 235|51
" Using , as a map leader -- Define ",," to equal a current ,!
:let mapleader = ","

map <leader>s :call WriteAndLoad()<CR>
fun WriteAndLoad()
  :exe ":w"
  :exe ":so ~/.vimrc"
endf

"fun! SetPager()
    " Don't do on these filetypes
    "if &ft =~ 'man'
    "    return
    "endif
    " do something for other filetypes
"endfun

" Use vim as a pager, not less
" Discard pager
:let $MANPAGER=''
" Map the K key to the ReadMan function:
map K :call ReadMan()<CR>

" Only for old files, this switches man read to a new tab
" If the file is new, it stays on the same tab
fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new tab:
  if bufname("%") != 'man-page'
    :exe ":tabe man-page"
    let s:bool_man = "new"
  else
    :exe ":set modified"
    let s:bool_man = "old"
  endif
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":%d"
  :exe ":r!man " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
  " finally set file type to 'man':
  :exe ":set filetype=man nomod nomodified nonumber nolist autoread"
  ":exe "<CR>"
endfun

autocmd FileType man exe ":f man-page"
autocmd FileType man exe ":set modified"
autocmd FileType man exe ":set modifiable"
autocmd FileType * call GitTags()

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

:imap <F1> <Esc>a " AWESOME IDEA!

map <F2> :WMToggle<cr><C-W><C-W>
map <F3> :NERDTreeToggle<CR>
map <F4> :GundoToggle<CR>
map <F5> :TlistToggle<CR>
" = not used anymore
"map <F7> :TlistShowPrototype<cr><C-h>
"map <F5> :set wrap!<CR>" Wrap

" TagList options
" detect unix and mac osx (darwin)
if has("unix")
  let uname = substitute(system("uname"),"\n","","g")
  if uname == "Darwin"
    let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
  else
    let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  endif
endif
let Tlist_WinWidth = 40                 "taglist window width
"let Tlist_Close_On_Select = 1           "close taglist window once we selected something
let Tlist_Exit_OnlyWindow = 1           "if taglist window is the only window left, exit vim
let Tlist_Show_Menu = 1                 "show Tags menu in gvim
let Tlist_Show_One_File = 1             "show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1   "automatically switch to taglist window
let Tlist_Highlight_Tag_On_BufEnter = 1 "highlight current tag in taglist window
let Tlist_Process_File_Always = 1       "even without taglist window, create tags file, required for displaying tag in statusline
"let Tlist_Use_Right_Window = 1          "display taglist window on the right
let Tlist_Display_Prototype = 1         "display full prototype instead of just function name

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" TODO
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR> 
" Grab ctags from folder root; we could use --show-toplevel 
" let g:gitroot="`git rev-parse --show-cdup`"
fun! GitTags()
  let g:gitroot = system("git rev-parse --show-toplevel 2>/dev/null")
" Strip trailing newline and escape
  let g:gitroot = substitute(g:gitroot, "\\n*$","","")
  execute "set tags=" . g:gitroot . "/.git/tags"
endf

" Window Mappings
map <C-J> <C-W>j<C-W>10+
map <C-K> <C-W>k<C-W>10+
map <C-L> <C-W>l<C-W>10+
map <C-H> <C-W>h<C-W>10+
map <C-K> <C-W>k<C-W>10+
map <leader>o o<Esc>
map <leader>O O<Esc>
map <leader>m i<C-M><Esc>
" map <C-S-J> a<CR><Esc>k$

" tab navigation a la firefox
:nmap <C-N> :tabnext<CR>
:map <C-N> :tabnext<CR>
" :imap <Tab> <Esc>:tabnext<CR>i
:nmap <C-P> :tabprevious<CR>
:map <C-P> :tabprevious<CR>
" :imap <S-Tab> <Esc>:tabprevious<CR>i
" :nmap <C-T> :tabe
" :imap <C-T> <Esc>:tabe<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete

augroup filetype
  au! BufRead,BufNewFile *.br     set filetype=breeze
augroup END

" improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold
" Hacks for SQL completion
" let g:ftplugin_sql_omni_key = '<C-C>'

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
" inoremap ,c <C-o>:call NERDComment(0,"toggle")<C-m>

" map <Leader>c ,c<space>

" latex plugin
" let g:tex_flavor='latex'

" Fuzzy Finder 
" ctags -R --extra=+f .
map <Leader>e :FufBuffer<CR>
map <Leader>f :FufFile<CR>
map <Leader>d :FufDir<CR>
map <Leader>mf :FufMruFile<CR>
"map <Leader>m :FufMruCmd<CR>
map <Leader>b :FufBookmark<CR>
map <Leader>t :FufTag<CR>
map <Leader>rf :FufTaggedFile<CR>
map <Leader>j :FufJumpList<CR>
map <Leader>mc :FufChangeList<CR>
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

" Copy between different vim sessions
:map <Leader>C :'a,.w! /tmp/t^v^m
:map <Leader>V :.r /tmp/t^v^m

:map <Leader>c "+y
:map <Leader>v "+p
"
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

"Invisible character colors
highlight NonText guifg=#4a4a59
" highlight SpecialKey guifg=#4a4a59
:hi SpecialKey  cterm=NONE ctermbg=235 guibg=black " 8 24 235|51
":hi NonText     cterm=NONE ctermbg=235 guibg=black " 8 24 235|51
" Use the same symbols as TextMate for tabstops and EOLsA set list
set listchars=tab:_\|,eol:$

" Return to last edit position 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

cmap w!! w !sudo tee >/dev/null %
map ZS :w!!<CR>
" do not forget custom file commands
" :autocmd bufenter *.tex map <F1> :!latex %<CR>

command! Gcc call Gcc()
func! Gcc()
  exec "w"
  exec "!gcc % -o %<"
endfunc

map <leader>2 :Gcc<CR>

" abbreviations
au  BufRead,BufNewFile COMMIT_EDITMSG      iabb <buffer>u Update
au  BufRead,BufNewFile COMMIT_EDITMSG      iabb <buffer>m [Minor]
au  BufRead,BufNewFile *.tex               iabb <buffer>la \lambda{}sh

