"vimrc

"Note: This vim script has folded areas. use zr to expand

"this script has multibyte characters
if !has('nvim')
	set encoding=utf-8
endif
set termencoding=utf-8
scriptencoding utf-8
let g:my_home=$HOME . '/'

set nocompatible " must be first line

if has('nvim')
	if filereadable("/usr/local/bin/python2.7")
		let g:python_host_prog="/usr/local/bin/python2.7"
	elseif filereadable("/usr/bin/python2.7")
		let g:python_host_prog="/usr/bin/python2.7"
	endif
	let g:python_host_skip_check=1 "faster loading time
	let g:python3_host_prog="/usr/local/bin/python3.6"
	let g:python3_host_skip_check=1 "faster loading time
endif

" plugin management {{{
"execute pathogen
"execute pathogen#infect()

let no_fancy=str2nr(system('tmux showenv | grep TMUX_NO_FANCY | cut -f2 -d='))
let g:mybundle=g:my_home . ".vim/bundle/"
"Execute vundle vim package manager. This requires pathogen and git with https support. Type ":PluginInstall" for initial installation of packages

if isdirectory(g:mybundle . "Vundle.vim")
	"let g:mybundle=g:mybundle . "Vundle.vim"
	"set rtp+=g:mybundle

	"Use git 'protocol' instead of https to download bundles
	let g:vundle_default_git_proto = 'git'
	set rtp+=~/.vim/bundle/Vundle.vim
	if isdirectory("/usr/local/opt/fzf")
		set rtp+=/usr/local/opt/fzf
	endif
	if isdirectory("~/.fzf")
		set rtp+=~/.fzf
	endif
	call vundle#rc()
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'Shougo/vimproc.vim'
	Plugin 'vim-scripts/CCTree', {'name': 'cctree2'}
	Plugin 'steffanc/cscopemaps.vim'
	Plugin 'vim-scripts/DoxygenToolkit.vim'
	Plugin 'jamessan/vim-gnupg'
	Plugin 'scrooloose/nerdcommenter'
	Plugin 'tpope/vim-surround'
	Plugin 'majutsushi/tagbar'
	Plugin 'vim-scripts/A-better-tcl-indent'
	Plugin 'othree/xml.vim'

	Plugin 'bling/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	"Plugin 'scrooloose/syntastic'
	Plugin 'terryma/vim-multiple-cursors'
	Plugin 'Shougo/denite.nvim'

	Plugin 'tpope/vim-dispatch'
	Plugin 'sheerun/vim-polyglot'
	Plugin 'mhinz/vim-grepper'
	Plugin 'benekastah/neomake'
	Plugin 'vim-scripts/Conque-GDB'
	Plugin 'tpope/vim-fugitive'

	Plugin 'kana/vim-metarw'
	Plugin 'mattn/webapi-vim'
	Plugin 'mattn/vim-metarw-gdrive'
	Plugin 'Shougo/neosnippet'
	Plugin 'Shougo/neosnippet-snippets'
	Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plugin 'airblade/vim-gitgutter'
	if ( no_fancy != "1" )
		Plugin 'ryanoasis/vim-devicons'
	endif
    Plugin 'jdevera/vim-opengrok-search'

	call vundle#end()
endif
" }}}

" basic {{{
"set title
set history=1000 " show a ton of history
syntax on
if !has('nvim')
	set viminfo='50,f9,\"100,:100,%,n~/.viminfo
else
	set viminfo='50,f9,\"100,:100,%,n~/.nviminfo
endif
"Default tab for 4
let s:vtabstop="short"
"Set a statusbar
set statusline=~
"Default backspace like normal
set backspace=2
"Some option desactivate by default (remove the no).
set nobackup
"highlight search
set hlsearch
set incsearch
set ignorecase
"display status line always
set laststatus=2

"Show the position of the cursor.
set ruler
"Show matching parenthese.
set showmatch

"enable file type detection
filetype on 
"enable loading the indent file for specific file types
filetype indent on 
"enable loading the plugin files for specific file types
filetype plugin on 

if !has('gui_running')
	if ($TERM == "screen" || $TERM == "putty-256color" || $TERM == "xterm-256color" || $TERM == "tmux-256color" || has('gui_vimr'))
		set fillchars=vert:\│
		if isdirectory(g:mybundle . 'vim-colors-solarized') 
"			let g:solarized_contrast = 'high'
"			let g:solarized_bold=0
"			let g:solarized_underline=0
"			let g:solarized_italic=0
			"let g:solarized_visibility='high'
			let g:solarized_termcolors=256
			if (has("gui_vimr"))
				set background=light
			else
				set background=dark
			endif
			let g:solarized_termtrans = 1
			colorscheme solarized
		endif
	else
		set fillchars=vert:\|
	endif
else
		set fillchars=vert:\│
		let g:solarized_contrast = 'high'
		let g:solarized_bold=0
		let g:solarized_underline=0
		let g:solarized_italic=0
		"let g:solarized_visibility='high'
		let g:solarized_termcolors=256
		set background=dark
		let g:solarized_termtrans = 1
		colorscheme solarized
endif

" This is a list of directories which will be searched when using the
"	|gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
set path+=/vobs/projects/springboard/fabos
set path+=/vobs/projects/springboard/fabos/src/include
set path+=/vobs/projects/springboard/fabos/src/

" ignore whitespace in diff
set diffopt+=iwhite

if s:vtabstop == 'short'
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
else
	set tabstop=8
	set shiftwidth=8
	set softtabstop=8
endif

"for persistent-undo (vim 7.3 only)
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"give 3 line context
set scrolloff=3

"add cstyle comments to quickfix
set errorformat+=%f:\ %l:\ %m
set t_Co=256
"enable mouse support (+scroll wheel) on terminal
"set term=xterm-256color
set mouse=a
if !has('nvim')
	set ttymouse=xterm2
endif

"disable indentation during paste mode
set pastetoggle=<F3>

"disable certain files in tab completion for files
set wildignore+=*.o,*.out,*.ko,*.c.style_checked

"change color of vertical split bar
highlight VertSplit ctermfg=darkgrey ctermbg=darkgrey

"Wrapped lines goes down/up to next row, rather than the next line in file
nnoremap j gj
nnoremap k gk

"yank to system clipboard
"nnoremap y "+y
"vnoremap y "+y

"change working directory to that of the current file
cmap cwd lcd %:p:h

" define a group `vimrc` and inititialize
" if you define autocmds without a group, vim registers the same autocmd each
" :source ~/.vimrc and vim executes the same autocmds each occurring event. In
" one word, it's heavy
augroup vimrc
	autocmd!
augroup end

"Restore cursor to file position in previous editing session
autocmd vimrc BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"set window tmux title to current filename
if ($TERM == "screen" || $TERM == "putty-256color" || $TERM == "xterm-256color" || $TERM == "tmux-256color" )
	autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
	autocmd VimLeave * call system("tmux set-window-option automatic-rename")
endif

if has('nvim')
	set inccommand=split
endif

" }}}
" gui basic {{{
if has('gui_running')
	set number
	if isdirectory(g:mybundle . 'vim-colors-solarized') 
		let g:solarized_termcolors=256
	endif
	set background=dark
	colorscheme solarized
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
	set mousemodel=extend
endif
" }}}
" taglist {{{
"for taglist plugin
"let Tlist_Ctags_Cmd="~/linux/bin64/ctags"
"let Tmenu_Ctags_Cmd="~/linux/bin64/ctags"
"set completeopt="menu,preview"
set completeopt=longest,menuone
"set tags=./tags,/vobs/projects/springboard/fabos/src/tags
set tags=./tags,/projects/slxos_dev/ls400966/slx/slxos_main/tags
" }}}
" cscope {{{
if has("cscope")
	"get rid of cscope warning messages
	set nocscopeverbose
	if filereadable ("/Volumes/slxos_dev/slxos_main/cscope.out")
		cscope add /Volumes/slxos_dev/slxos_main/cscope.out /Volumes/slxos_dev/slxos_main
	endif
	if filereadable ("/Volumes/slxos_dev/slxos_sdk/cscope.out")
		cscope add /Volumes/slxos_dev/slxos_sdk/cscope.out /Volumes/slxos_dev/slxos_sdk
	endif
	if filereadable ("/projects/slxos_dev/ls400966/slx/slxos_main/cscope.out")
		cscope add /projects/slxos_dev/ls400966/slx/slxos_main/cscope.out /projects/slxos_dev/ls400966/slx/slxos_main
	endif
	if filereadable ("/projects/slxos_dev/ls400966/slx/slxos_sdk/cscope.out")
		cscope add /projects/slxos_dev/ls400966/slx/slxos_sdk/cscope.out /projects/slxos_dev/ls400966/slx/slxos_sdk
	endif

	set cscopequickfix="s-,c-,d-,i-,t-,e-"
endif

"create cscope in local directory (used in cctree plugin i.e. :CCTreeLoadDB)
"after calling this function, use <C-\>> or <C-\><
function! UpdateCscope()
	execute ":silent !cscope -b -R -q"
	execute ":redraw!"
	execute ":silent CCTreeLoadDB cscope.out"
	execute ":redraw!"
	echohl StatusLine | echo "CCTreeDB loaded" | echohl None
endfunction
nnoremap <F4> :call UpdateCscope()<C-M>
"
" if cursor points to status=-xxx, use ~swuser/bin/asic_err to find error code
" constant. Used in fostrace files
function! CscopeNumeric()
	if (strpart(expand("<cWORD>"), 0, 8) == "status=-")
		let err_code=strpart(expand("<cWORD>"), 7)
		let err_str=system('~swuser/bin/asic_err '.l:err_code)
		execute ":tag " . l:err_str
	else
		execute ":tag " . expand("<cword>")
	endif
endfunction
autocmd vimrc BufRead *.trc nnoremap g] :call CscopeNumeric()<C-M>

" if cursor points to status=-xxx, use ~swuser/bin/asic_err to find error code
" constant. Used in fostrace files
function! CscopeNumericSplit()
	if (strpart(expand("<cWORD>"), 0, 8) == "status=-")
		let err_code=strpart(expand("<cWORD>"), 7)
		let err_str=system('~swuser/bin/asic_err '.l:err_code)
		execute ":stag " . l:err_str
	else
		execute ":stag " . expand("<cword>")
	endif
endfunction
autocmd vimrc BufRead *.trc nnoremap <C-w>] :call CscopeNumericSplit()<C-M>
" }}}
" c files {{{
" Set some sensible defaults for editing C-files
augroup cprog
  " Remove all cprog autocommands
  autocmd!

	"set textwidth=80

  " When starting to edit a file:
  " For *.c and *.h files set formatting of comments and set C-indenting on
  " custom indentation rules in cinoptions
  autocmd BufRead *.cpp,*.c,*.h set formatoptions=croql cindent smartindent cinoptions=:0,l1,g0,t0,(4,U1,W1,m1 comments=sr:/*,mb:*,el:*/,://

  " autocmd BufRead *.cpp,*.hpp set formatoptions=croql cindent tabstop=4 shiftwidth=4 softtabstop=4 comments=sr:/*,mb:*,el:*/,://

  " set lines with num_chars > 80 color
  if exists('+colorcolumn')
	  "autocmd BufRead *.cpp,*.hpp,*.c,*.h set colorcolumn=80
  endif
augroup END
" }}}
" zip,egg,xpi files {{{
au BufReadCmd *zip,*.egg,*.xpi call zip#Browse(expand("<amatch>"))
" }}}
" gzip files {{{
" Also, support editing of gzip-compressed files. DO NOT REMOVE THIS!
" This is also used when loading the compressed helpfiles.
augroup gzip
  " Remove all gzip autocommands
  autocmd!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPre,FileReadPre	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . %:r

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
augroup END
" }}}
" bz2 files {{{
augroup bzip2
  " Remove all bzip2 autocommands
  autocmd!

  " Enable editing of bzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.bz2 set bin
  autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=2|'[,']!bunzip2
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=1 nobin|execute ":doautocmd BufReadPost " . %:r
  autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save

  autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
augroup END
" }}}
" key maps {{{
" saves a copy of the file
map ;s   :up \| saveas! %:p:r-<C-R>=strftime("%y%m%d")<CR>-bak.txt \| 3sleep \| e #<CR> 
"map f5 to :make
nmap <silent> <F5> :wa<CR>:make<CR>
"nmap <silent> <F7> :cn<CR>
"nmap <silent> <F6> :cp<CR>
nmap <silent>  <F16> :lne<CR>
nmap <silent>  <F15> :lpr<CR>

" re indent whole file
nmap <silent> ;i :%!indent -bap -bl -bli4 -br -brs -ce -nbbo -psl -cdw -cbi0 -cli0 -sc -ci4 -cdw -nbc -nbfda -ss -hnl -i4 -sob -l80 -ncs -npcs -nprs -nfc1 -saf -sai -saw -sbi0 -sob -ts4 -ut -nlp -bs -ppi0 -il0<CR>

"update ctags for omni completion. usage: :call UpdateTags()
function! UpdateTags()
	execute ":silent !ctags -R --language-force=C --c-kinds=+p --fields=+iaS --extra=+q ./"
	execute ":redraw!"
	echohl StatusLine | echo "C tags updated" | echohl None
endfunction
nnoremap <F2> :call UpdateTags()<C-M>
"show visible tabs. usage: :call Tabdisplaytoggle()
function! Tabdisplaytoggle()
	highlight SpecialKey ctermfg=1
	set list
	set listchars=tab:T>
endfunction

" fold everything else except word on cursor. use zr to display more context, zm
" to display less context. Useful for filtering by OIDs in fostrace files
function! ZFilter()
	let ctbg=synIDattr(synIDtrans(hlID('Normal')), 'bg')
	if (l:ctbg == "")
		execute ":highlight Folded ctermbg=black"
	else
"		execute ":highlight Folded ctermbg=" . l:ctbg
	endif
	execute ":setlocal foldexpr=(getline(v:lnum)=~'" . expand("<cword>") . "')?0:(getline(v:lnum-1)=~'" . expand("<cword>") . "')\\|\\|(getline(v:lnum+1)=~'" . expand("<cword>") . "')?1:2 foldmethod=expr foldlevel=0 foldcolumn=2 foldtext= fillchars=\" \""
endfunction
nnoremap ;z :call ZFilter()<C-M>

" }}}
" fostrace syntax highlighting {{{
"enable asictrace syntax highlighting
autocmd vimrc BufRead,BufNewFile *.trc set filetype=fostrace
" }}}
" rastrace syntax highlighting {{{
"enable RAS trace syntax highlighting
autocmd vimrc BufRead,BufNewFile *.RAS*.txt set filetype=rastrace
" }}}
" ttrci syntax highlighting {{{
"highlight required fields in ttrci files
function! s:DetectNode()
	if getline(1) =~ '# REQUIRED Field'
		set filetype=ttrci
	elseif getline(1) =~ 'RCI CLI Context'
		set filetype=ttrci
	elseif getline(2) =~ 'exec expect'
		set filetype=tcl
	elseif getline(3) =~ 'exec expect'
		set filetype=tcl
	endif
endfunc
autocmd vimrc BufNewFile,BufRead * call s:DetectNode()
" }}}
" clearcase {{{
"command line completion for ctdiffg
com! -nargs=0 -complete=command Ctdiffg exec
			\ "!ctdiffg ".resolve(expand("%"))." &"
"command line completion for xlsvtree
com! -nargs=0 -complete=command Xlsvtree exec
			\ "!xlsvtree ".resolve(expand("%"))." &"
" }}}
" tagbar {{{
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_compact = 1
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
nmap <silent> <F10> <Plug>ToggleProject
" }}}
" doxygen {{{
"doxygen syntax highlighting
let g:load_doxygen_syntax=1
" }}}
" syntastic {{{
" if isdirectory(g:mybundle . "syntastic") 
	" if has('nvim') " disable syntastic for nvim, will use neomake instead
		" autocmd VimEnter * silent call SyntasticToggleMode()
	" else
		" if !has('gui_running')
			" if ($TERM == "screen" || $TERM == "putty-256color")
				" set fillchars=vert:\│
				" let g:syntastic_error_symbol = '✗'
				" let g:syntastic_style_error_symbol = '✗'
				" let g:syntastic_warning_symbol = '⚠'
				" let g:syntastic_style_warning_symbol = '⚠'
			" endif
		" else
				" let g:syntastic_error_symbol = '✗'
				" let g:syntastic_style_error_symbol = '✗'
				" let g:syntastic_warning_symbol = '⚠'
				" let g:syntastic_style_warning_symbol = '⚠'
		" endif
		" let g:syntastic_c_auto_refresh_includes = 1
		" " load bcm project include file
		" if getcwd() =~ 'fabos/src/sys/dev/asic/bcm56'
			" source ~/.vimrc_syntastic_bcm
		" elseif getcwd() =~ 'fabos/src/sys/dev/asic/wlv' || getcwd() =~ 'fabos/src/sys/dev/asic/hawk'
			" source ~/.vimrc_syntastic_wlv
		" elseif getcwd() =~ 'fabos/src/lp/dce/hslagt/bxp'
			" "autocmd vimrc BufNewFile,BufRead *.c,*.h set filetype=cpp
			" autocmd vimrc BufReadPre *.cpp,*.c,*.hpp,*.h let g:syntastic_cpp_checkers = ['cstyle', 'gcc']
			" source ~/.vimrc_syntastic_bxp
		" endif

		" autocmd vimrc BufReadPre *.cpp,*.c let g:syntastic_c_checkers = ['cstyle', 'gcc']
		" "autocmd vimrc BufReadPre *.cpp,*.c let g:syntastic_c_checkers = ['cstyle']
		" autocmd vimrc BufReadPre *.hpp,*.h let g:syntastic_c_checkers = ['gcc']
		" let g:syntastic_aggregate_errors = 1
		" let g:syntastic_id_checkers = 0
		" let g:syntastic_c_check_header = 0
		" let g:syntastic_c_no_include_search = 1
		" let g:syntastic_c_no_default_include_dirs = 1
		" "let g:syntastic_c_compiler = 'powerpc-linux-gnu-gcc'
		" let g:syntastic_check_on_wq = 0
		
		" "autocmd vimrc BufWritePre *.c,*.cpp,*.hpp,*.h unlet b:syntastic_c_includes
	" endif
" endif
" neomake {{{
if has('nvim') " neomake only works on nvim, syntastic for vim
	if isdirectory(g:mybundle . "neomake") 
		"let g:neomake_verbose=3
		let g:neomake_logfile=g:my_home . 'error.log'

		highlight clear SignColumn
		"highlight SignColumn bg=darkgrey

		let g:neomake_open_list=2
		if getcwd() =~ 'fabos/src/lp/dce/hslagt/bxp'
			source ~/.nvimrc_neomake_bxp
			autocmd! BufWritePost *.cpp,*.c Neomake
		else
			if getcwd() =~ 'fabos/src/sys/lib/pptm'
				source ~/.nvimrc_neomake_pptm
				autocmd! BufWritePost *.cpp,*.c Neomake
			elseif getcwd() =~ 'fabos/src/lp/dce/hslagt'
				source ~/.nvimrc_neomake_hslagt
				autocmd! BufWritePost *.cpp,*.c Neomake
			endif
		endif
		" function! neomake#makers#ft#sh#EnabledMakers()
			" return ['shellcheck']
		" endfunction
		let g:neomake_info_sign={'text': '⚠', 'texthl': 'NeomakeErrorMsg'}
		let g:neomake_sh_shellcheck_maker = {
					\ 'args': ['-fgcc' ],
					\ 'errorformat':
					\ '%f:%l:%c: %trror: %m,' .
					\ '%f:%l:%c: %tarning: %m,' .
					\ '%I%f:%l:%c: note: %m',
					\ }
		function! s:PostDetectNode()
			if ( &filetype == "sh" )
				Neomake
			elseif ( &filetype == "python" )
				Neomake
			endif
		endfunc
autocmd! BufWritePost * call s:PostDetectNode()
	endif
endif
" }}}
" }}}
" airline {{{
if isdirectory(g:mybundle . "vim-airline") 
	let g:airline#extensions#syntastic#enabled = 0
	if !has('gui_running')
		if ($TERM == "screen" || $TERM == "putty-256color" || $TERM == "xterm-256color" || $TERM == "tmux-256color"  || has("gui_vimr"))
			if ( no_fancy != "1" )
				let g:airline_powerline_fonts = 1
				"extra nerd-fonts patched fonts
				let g:airline_left_sep = "\uE0c0"
				let g:airline_right_sep = "\uE0c2"
				let g:airline_section_z = airline#section#create(['%3p%% ' . "\uE0A1" . '%{line(".")}/%L ' . "\uE0A3" . '%{col(".")}'])
			else
				let g:airline_section_z = airline#section#create(['%3p%% ' . '%{line(".")}/%L ' . '%{col(".")}'])
			endif
		endif
	else
		if ( no_fancy != "1" )
			let g:airline_powerline_fonts = 1
			"extra nerd-fonts patched fonts
			let g:airline_left_sep = "\uE0c0"
			let g:airline_right_sep = "\uE0c2"
			let g:airline_section_z = airline#section#create(['%3p%% ' . "\uE0A1" . '%{line(".")}/%L ' . "\uE0A3" . '%{col(".")}'])
		else
			let g:airline_powerline_fonts = 0
		endif
	endif
	
	let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
	"let g:airline_section_b = airline#section#create(['%{$view}'])
	"let g:airline_section_c = airline#section#create(['%<', '%t', ' ', 'readonly'])
	"let g:airline_section_y = airline#section#create([''])
	"let g:airline_section_z = airline#section#create(['%3p%% ', 'linenr', ':%3v'])
	"Automatically displays all buffers when there's only one tab open.
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#whitespace#enabled = 0
	"let g:airline_detect_whitespace = 0
    let g:airline_skip_empty_sections = 1


	"function to disable plugins for large files
	function! LargeCfile()
		let f=expand("<afile>")
		if (getfsize(f) > 400000)
			let g:airline#extensions#tagbar#enabled = 0
			let g:tagbar_ctags_bin = "xyz" "hack to disable tagbar for large files
		else
			let g:airline#extensions#tagbar#enabled = 1
			let g:tagbar_ctags_bin = "ctags"
		endif
	endfunction
	function! Leaving()
			let g:airline#extensions#tagbar#enabled = 0
			let g:tagbar_ctags_bin = "xyz" "hack to disable tagbar for large files
	endfunction
	autocmd vimrc BufReadPre *.cpp,*.hpp,*.c,*.h :call LargeCfile()
	"disable tagbar on vba files
	autocmd vimrc BufReadPre *.vba let g:airline#extensions#tagbar#enabled = 0
	autocmd vimrc BufReadPre *.cpp,*.hpp,*.c,*.h :set number
	if (!has("gui_vimr"))
		let g:airline_theme='solarized'
	endif
endif
" }}}
" denite - ctrlp {{{
if isdirectory(g:mybundle . "denite.nvim") 
    " Change file_rec command.
	call denite#custom#alias('source', 'file_rec/git', 'file_rec')
	call denite#custom#var('file_rec/git', 'command',
				\ ['git', 'ls-files', '-co', '--exclude-standard'])
    call denite#custom#var('file_rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
        call denite#custom#map(
          \ 'insert',
          \ '<C-j>',
          \ '<denite:move_to_next_line>',
          \ 'noremap'
          \)
    call denite#custom#map(
          \ 'insert',
          \ '<C-k>',
          \ '<denite:move_to_previous_line>',
          \ 'noremap'
          \)
    " Change matchers.
    call denite#custom#source(
    \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
    call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_cpsm'])

    " Change sorters.
    call denite#custom#source(
    \ 'file_rec', 'sorters', ['sorter_sublime'])
	nnoremap <silent> <C-p> :Denite buffer file_rec line<cr>
	call denite#custom#var('grep', 'command', ['ag'])
	nnoremap <space>/ :Denite grep:.<cr>
endif
" }}}
" {{{ neocomplcache
"neocomplcache setting
let g:neocomplcache_enable_at_startup = 1
" }}}

" {{{ neo-snippet
if isdirectory(g:mybundle . "neosnippet-snippets")
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	smap <C-k>     <Plug>(neosnippet_expand_or_jump)
	xmap <C-k>     <Plug>(neosnippet_expand_target)
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	let g:neosnippet#snippets_directory='~/.vim/bundle/my-snippets'
endif


" }}}
" {{{ vim-grepper
if isdirectory(g:mybundle . "vim-grepper")
	let g:grepper = {
		\'tools': ['ack', 'git', 'grep'],
		\ 'open': 1,
		\ 'jump': 0,
		\ 'quickfix': 0,
		\}
endif

" }}}
" {{{ opengrok-search
if isdirectory(g:mybundle . "vim-opengrok-search")
	let b:ogs_app_url = 'http://10.59.132.222:8080/slxos/'
endif
" }}}

" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}
" -----------------------------------------------------------------------------
"mappings:
" :cwd - change working directory to that of the current file
" f2 - update ctags
" f3 - pastetoggle (disable autoindent on insert mode)
" f4 - update cscope
" f5 - make
" s-f6 - previous error (in neomake)
" s-f5 - next error (in neomake)
" f9 - toggle tagbar
" ;s - saves a copy of the file in <fname><time>-bak.txt format
" ;i - reindent c file
" ;z - fold everything else except word on cursor. use on trc files
"
"tips:
"use ctrl-n to auto complete  in insert mode
"use "set scrollbind" on all windows you want to synchronously scroll

"fold multiline comments
"set foldmethod=expr
"set foldexpr=getline(v:lnum)=~'^[[:blank:]]*[*/]'?1:0
"set nofoldenable
"set runtimepath to ~/.vim/after to override c omnicompletion function i.e. we

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:clang_stdafx_h = 'brcd_xpliant.h'
let g:chromatica#libclang_path='/scratch/sjc-dsa/lsiao/toolchain/lib'
let g:chromatica#enable_debug=1
let g:chromatica#enable_at_startup=1
let NERDSpaceDelims=1

"use ag instead of grep
set grepprg=ag
"hack to disable tmux split window (breaks on iterm)
let g:tmux_session=1

" vim:foldmethod=marker
