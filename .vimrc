
"key mapping
map <S-F12>  <ESC>:TlistToggle<CR>
map <S-F11>  <ESC>:cs add cscope.out<CR>
map <C-F11>  <ESC>:cscope find 
map <C-F7>  <ESC>:tabp<CR>
map <C-F8>  <ESC>:tabn<CR>
map <C-F9>  <ESC>:WMToggle<CR>
map <C-F10> <ESC> 1G=G
map <F2> <ESC>o/**OY:**/<ESC>2hi
"nmap z ZZ
"file type
filetype on

set hlsearch

" vimwiki
map <C-P> <ESC>o{{{class="brush: cpp" ><CR><ESC>gpo}}}<ESC>      
"create the link page
map <C-L> <ESC>dwi[[<ESC>pbea]]<ESC>
"bold the word
map <C-B> <ESC>dwi*<ESC>pbea*<ESC>
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_use_mouse=1
let g:vimwiki_list = [{'path': 'vimwiki/',
\ 'html_header': '/home/oneyoung/vimwiki_html/header.tpl',
\ 'path_html': 'vimwiki_html/',
\ 'auto_export': 1 ,
\ 'nested_syntaxes': {'python': 'python', 'c++': 'cpp', 'c': 'c'} }]
let g:vimwiki_list_ignore_newline=0
"let g:vimwiki_list = [{'html_header': '~/vimwiki_html/header.tpl'}]
"let wiki = {}
"let wiki.path = 'vimwiki'
"let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c': 'c'}
"let g:vimwiki_list = [wiki]


"for armasm plugin
let asmsyntax='armasm'
let filetype_inc='armasm'
"for taglist plugin
set updatetime=1000

set number
set foldmethod=indent

let winMangerWindowLayout = 'FileExplorer|TagList'
set autoindent
set smartindent
let g:winManagerWindowLayout = 'BufExplorer|FileExplorer,TagsExplorer'
""for cscope
set csto=0

"add any cscope database in the current dirctory
"global has higher priotiy
if filereadable("GTAGS")
    set csprg=gtags-cscope
    cs add GTAGS
elseif filereadable("cscope.out")
        cs add cscope.out
"else add the database pointed to by environment variable
elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB
endif
set cscopeverbose
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
" Below are three sets of the maps: one set that just jumps to your
" search result, one that splits the existing vim window horizontally and
" diplays your search result in the new window, and one that does the same
" thing, but does a vertical split instead (vim 6 only).
"
" I've used CTRL-/ and CTRL-@ as the starting keys for these maps, as it's
" unlikely that you need their default mappings (CTRL-/'s default use is
" as part of CTRL-/ CTRL-N typemap, which basically just does the same
" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
" If you don't like using 'CTRL-@' or CTRL-/, , you can change some or all
" of these maps to use other keys.  One likely candidate is 'CTRL-_'
" (which also maps to CTRL-/, which is easier to type).  By default it is
" used to switch between Hebrew and English keyboard mode.
"
" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
" that searches over '#include <time.h>" return only references to
" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
" files that contain 'time.h' as part of their name).

" To do the first type of search, hit 'CTRL-/', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.
map <F3>s <ESC>:cs find s <C-R>=expand("<cword>")<CR><CR>
map <F3>g <ESC>:cs find g <C-R>=expand("<cword>")<CR><CR>
map <F3>c <ESC>:cs find c <C-R>=expand("<cword>")<CR><CR>
map <F3>t <ESC>:cs find t <C-R>=expand("<cword>")<CR><CR>
map <F3>e <ESC>:cs find e <C-R>=expand("<cword>")<CR><CR>
map <F3>f <ESC>:cs find f <C-R>=expand("<cfile>")<CR><CR>
map <F3>i <ESC>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
map <F3>d <ESC>:cs find d <C-R>=expand("<cword>")<CR><CR>
" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split horizontally, with search result displayed in
" the new window.
"
" (Note: earlier versions of vim may not have the :scs command, but it
" can be simulated roughly via:
"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-F3>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-F3>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-F3>d :scs find d <C-R>=expand("<cword>")<CR><CR>
" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one (vim 6 and up only)
"
" (Note: you may wish to put a 'set splitright' in your .vimrc
" if you prefer the new window on the right instead of the left
nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"let $EX_DEV='~/.vim/exvim'
"let g:ex_toolkit_path='~/.vim/exvim/toolkit'
"source ~/.vim/exvim/.vimrc_ex
"au BufNewFile,BufEnter * set cpoptions+=d
"

" for global
map <F4>s <ESC>:gtags-cscope  0 <C-R>=expand("<cword>")<CR><CR>
map <F4>g <ESC>:gtags-cscope  1 <C-R>=expand("<cword>")<CR><CR>
map <F4>c <ESC>:gtags-cscope  3 <C-R>=expand("<cword>")<CR><CR>
map <F4>t <ESC>:gtags-cscope  4 <C-R>=expand("<cword>")<CR><CR>
map <F4>e <ESC>:gtags-cscope  6 <C-R>=expand("<cword>")<CR><CR>
map <F4>f <ESC>:gtags-cscope  7 <C-R>=expand("<cfile>")<CR><CR>
map <F4>i <ESC>:gtags-cscope  8 ^<C-R>=expand("<cfile>")<CR>$<CR>
map <F4>r <ESC>:gtags-cscope  r <CR>
map <F4>h <ESC>:gtags-cscope  h <CR>
"
