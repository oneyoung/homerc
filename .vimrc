" ###############>>general<<###################
" key mapping
map <C-F7> <ESC>:tabp<CR>
map <C-F8> <ESC>:tabn<CR>
"a short cut to search a text
map <F4> <ESC>/\<<C-R>=expand("<cword>")<CR>\><CR>

" file type
filetype on
filetype plugin on
syntax on

set nocompatible
set hlsearch
set ignorecase
set mouse=a
set number
set foldmethod=indent

" indent
set autoindent
set smartindent
set noexpandtab
set ts=4
set shiftwidth=4
set smarttab
set fdm=indent
set fdc=4

" display the tab and end char
set list
set listchars=tab:>.,trail:-


" ###############>>Plugins<<###################
" ==> cscope <==
	"add any cscope database in the current dirctory
	" GNU global has higher priority than cscope
	if filereadable("GTAGS")
		set csprg=gtags-cscope
		cs add GTAGS
	elseif filereadable("cscope.out")
		cs add cscope.out
	"else add the database pointed to by environment variable
	elseif $CSCOPE_DB !=""
		cs add $CSCOPE_DB
	endif

	set csto=0
	set cscopeverbose

	" key mapping
	map <S-F11>  <ESC>:cs add cscope.out<CR>
	map <C-F11>  <ESC>:cscope find 
	"   's'   symbol: find all references to the token under cursor
	"   'g'   global: find global definition(s) of the token under cursor
	"   'c'   calls:  find all calls to the function name under cursor
	"   't'   text:   find all instances of the text under cursor
	"   'e'   egrep:  egrep search for the word under cursor
	"   'f'   file:   open the filename under cursor
	"   'i'   includes: find files that include the filename under cursor
	"   'd'   called: find functions that function under cursor calls
	map <F3>s <ESC>:cs find s <C-R>=expand("<cword>")<CR><CR>
	map <F3>g <ESC>:cs find g <C-R>=expand("<cword>")<CR><CR>
	map <F3>c <ESC>:cs find c <C-R>=expand("<cword>")<CR><CR>
	map <F3>t <ESC>:cs find t <C-R>=expand("<cword>")<CR><CR>
	map <F3>e <ESC>:cs find e <C-R>=expand("<cword>")<CR><CR>
	map <F3>f <ESC>:cs find f <C-R>=expand("<cfile>")<CR><CR>
	map <F3>i <ESC>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	map <F3>d <ESC>:cs find d <C-R>=expand("<cword>")<CR><CR>
	" split way
	nmap <C-F3>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-F3>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-F3>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-F3>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-F3>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-F3>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-F3>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-F3>d :scs find d <C-R>=expand("<cword>")<CR><CR>
	" vsplit way
	nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

	"fun Update_cscope_database()
	"	execute "cscope -bkq -i cscope.file &"
	"	execute "cs reset"
	"endfun
	"
	"map <C-F12> :call Update_cscope_database()<CR>
	"
	"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	"                \ | wincmd p | diffthis

" ==> JavaBrowser <==
	"let JavaBrowser_Sort_Type = "order"
	let JavaBrowser_Compact_Format = 1
	let jbrowser_cpp_ctags_args = '--language-force=c++ --c++-types=fc'
	let jbrowser_cpp_tag_types = 'class function'

" ==> vimwiki <==
	" paste block
	map <C-P> <ESC>o{{{class="brush: cpp" ><CR><ESC>gpo}}}<ESC>
	"create the link page
	map <C-L> <ESC>dwi[[<ESC>pbea]]<ESC>
	"bold the word
	map <C-B> <ESC>dwi*<ESC>pbea*<ESC>
	let g:vimwiki_use_mouse=1
	let g:vimwiki_list = [{'path': '/home/oneyoung/vimwiki/',
	\ 'html_header': '/home/oneyoung/vimwiki_html/header.tpl',
	\ 'path_html': '/home/oneyoung/vimwiki_html/',
	\ 'auto_export': 1 ,
	\ 'nested_syntaxes': {'python': 'python', 'c++': 'cpp', 'c': 'c'} }]

	let g:vimwiki_list_ignore_newline=0
	"let g:vimwiki_list = [{'html_header': '~/vimwiki_html/header.tpl'}]
	"let wiki = {}
	"let wiki.path = 'vimwiki'
	"let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c': 'c'}
	"let g:vimwiki_list = [wiki]

	"for armasm plugin
	"let asmsyntax='armasm'
	"let filetype_inc='armasm'

" ==> taglist <==
	set updatetime=1000

" ==> lookupfiles <==
	let g:LookupFile_TagExpr = string('./filenametags')
	let g:LookupFile_MinPatLength=3

" ==> NERD <==
	map <F8>  <ESC>:NERDTreeToggle<CR>
	map <F7> <ESC>:NERDTreeFind<CR> 
	let NERDTreeWinPos='right'

" ==> tagbar <==
	map <F12>  <ESC>:TagbarToggle<CR>
	let g:tagbar_left = 1
	let g:tagbar_width = 25

" ==> exVim <==
	"source ~/.vim/.vimrc_ex
	"au BufNewFile,BufEnter * set cpoptions+=d

" ==> txt2tags <==
	au BufNewFile,BufRead *.t2t set ft=txt2tags

" ==> python <==
	source ~/.vimrc_py


" ###############>>Functions<<###################
function Fix_coding_style()
	" remove the trail space or tabs
	%s/[\t ]\+$//ge
	" add a space before line start with "*"
	%s/^*/ */ge
	" "/*comment*/" --> "/* comment */"
	%s/\/\*\(\w\)\@=/\/\* /ge
	%s/\(\w\)\@<=\*\// \*\//ge
	" "){" --> ") {"
	%s/){/) {/ge
	" add a space between "var{" --> "var {"
	%s/\(\w\)\@<={/ {/ge
	" "func ()" --> "func()"
	%s/\(\w\)\@<= \+(/(/ge
	" "array []" --> "array[]"
	%s/\(\w\)\@<= \+\[/\[/ge
	" "if(" --> "if ("
	%s/\(if\|for\|while\|switch\)\@<=(/ (/ge
	" remove space before "(" and after ")"
	%s/\((\@<= \+\|\( \+\))\@=\)//ge
	" remove space before "[" and after "]"
	%s/\([\@<= \+\|\( \+\)]\@=\)//ge
	" "}var" --> "} var"
	%s/\(}\)\w\@=/} /ge
	" "}\n else" --> "} else"
	%s/}\n[\t ]\+else/} else/ge
	" change space indent to tab
	%s/^    /\t/ge
	" ",var" --> ", var"
	%s/\(,\)\S\@=/, /ge
	" add space between operator: + -
	%s/\(\w\|)\|}\) *\(+\|-\|=\) *\(\w\|(\|{\)/\1 \2 \3/ge
	%s/\(\w\|)\|}\) *\(==\|!=|\|\/=\|\*=\|-=\|+=\|<<=\|>>=\|^=\||=\|&=\) *\(\w\|(\|{\)/\1 \2 \3/ge
	%s/\(\w\|)\|}\) *\(&&\|||\) *\(\w\|(\|{\)/\1 \2 \3/ge
	%s/\(\w\|)\|}\) *\(>\|>=\|<\|<=\) *\(\w\|(\|{\)/\1 \2 \3/ge
	%s/return \+- \+/return -/ge
	%s/#include \+< \+/#include </ge
	%s/< \(\w\+@\)\@=/</ge
	let loop = 15
	while loop > 0
		%s/\(^\t\+\)\@<=    /\t/ge
		" %s/\t    /\t\t/ge
		let loop = loop - 1
	endwhile
endfunction

function Html_autocmd()
	setlocal expandtab
	setlocal nolisp
	setlocal autoindent
	setlocal sw=2 sts=2 sta
	set ft=htmldjango
endfunction

" ###############>>commands<<###################
" a command to empty quickfix window content
command Cclear call setqflist([])


" ###############>>autocmd<<###################
" filetype support for django template
autocmd BufNewFile,BufRead *.html,*.django,*.htmldjango  call Html_autocmd()
autocmd BufNewFile,BufRead *.c,*.h  set ts=8 sw=8
