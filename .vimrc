" meinside's .vimrc file for vim and neovim,
" created by meinside@gmail.com,
"
" last update: 2018.07.02.
"
" XXX - for neovim:
"
" $ pip3 install --upgrade neovim

""""""""""""""""""""""""""""""""""""
" settings for nvim
"
"
" for nvim, symbolic link '~/.vimrc' to '~/.config/nvim/init.vim'
if !filereadable(expand('~/.config/nvim/init.vim'))
	silent !mkdir -p ~/.config/nvim
	silent !ln -sf ~/.vimrc ~/.config/nvim/init.vim
endif
if has('nvim')	" settings for nvim only
    set termguicolors
    colo pablo
    set mouse-=a	" not to enter visual mode when dragging text
    let g:go_term_enabled = 1	" XXX - it needs to be set for 'delve' (2017.02.10.)
else	" settings for vim only
    set t_Co=256
    colo elflord
endif

""""""""""""""""""""""""""""""""""""
" settings for vim-plug (https://github.com/junegunn/vim-plug)
if has('nvim')
    " for nvim
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    " for vim
    if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Specify a directory for plugins
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Useful plugins
Plug 'jiangmiao/auto-pairs'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-ragtag'	" TAG + <ctrl-x> + @, !, #, $, /, <space>, <cr>, ...
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1
Plug 'airblade/vim-gitgutter'	" [c, ]c for prev/next hunk
let g:gitgutter_highlight_lines = 1
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 0	" :IndentLinesToggle
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-sleuth'
Plug 'johngrib/vim-f-hangul'	" can use f/t/;/, on Hangul characters

" For autocompletion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}	" XXX - python3 needed ($ pip3 install --upgrade neovim)
    let g:deoplete#enable_at_startup = 1
endif

" For snippets
" - Ruby: https://github.com/honza/vim-snippets/blob/master/UltiSnips/ruby.snippets
" - Go: https://github.com/honza/vim-snippets/blob/master/UltiSnips/go.snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"   " <tab> for next placeholder
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"    " <shift-tab> for previous placeholder
let g:UltiSnipsEditSplit = "vertical"

" For source file browsing, XXX: ctags is needed! ($ brew install ctags)
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" For uploading Gist (:Gist / :Gist -p / ...)
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" For syntax checking
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
if exists('*SyntasticStatuslineFlag')
    set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" For LanguageServer
if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': './install.sh'}
    let g:LanguageClient_serverCommands = {}
    let g:LanguageClient_changeThrottle = 0.5
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F3> :call LanguageClient#textDocument_rename()<CR>
endif

" For Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}

" For Dart
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
let dart_html_in_string=v:true
let g:syntastic_dart_checkers = ['dartanalyzer']
if has('nvim')
    " $ pub global activate dart_language_server
    let g:LanguageClient_serverCommands.dart = ['dart_language_server']
endif

" For Go
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
if has('nvim')
    Plug 'jodosha/vim-godebug', {'for': 'go'}	" For :GoToggleBreakpoint / :GoDebug ($ brew install go-delve/delve/delve)
    Plug 'zchee/deoplete-go', {'for': 'go', 'do': 'make'}	" For autocompletion
endif
let g:go_fmt_command = "goimports"	" auto import dependencies
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:syntastic_go_checkers = ['go', 'errcheck', 'golint']
let g:syntastic_aggregate_errors = 1

" For Haskell
if has('nvim')
    Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

    " $ git clone https://github.com/haskell/haskell-ide-engine --recursive
    " $ cd haskell-ide-engine
    " $ stack --stack-yaml=stack-8.2.2.yaml install
    let g:LanguageClient_serverCommands.haskell = ['hie', '--lsp']

    " For hoogle
    " $ stack exec -- hoogle generate
endif

" For Python
if has('nvim')
    Plug 'zchee/deoplete-jedi', {'for': 'python'}	" For autocompletion
endif

" For JavaScript frameworks
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'	" React
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
Plug 'posva/vim-vue'	" Vue.js

" For vim-codefmt (:FormatLines, :FormatCode)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

"
""""""""

" Initialize plugin system
call plug#end()
"
""""""""""""""""""""""""""""""""""""

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup	" do not keep a backup file, use versions instead
set history=50	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching
set cindent
set ai
set smartindent
set nu
set ts=4
set sw=4
set sts=4
set fencs=ucs-bom,utf-8,korea
set termencoding=utf-8
set wildmenu	" visual autocomplete for command menu
set showbreak=↳
set breakindent

" for running correct rvm ruby (not osx's default ruby) in zsh
set shell=/bin/bash

" Don't use Ex mode, use Q for formatting
map Q gq

" file browser (netrw)
" :Ex, :Sex, :Vex
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
" <F2> for vertical file browser
nmap <F2> :Vex <CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" For html/javascript/css
	autocmd FileType htm,html,js set ai sw=2 ts=2 sts=2 et
	autocmd FileType css,scss set ai sw=2 ts=2 sts=2 et

	" For programming languages
	" Golang
	autocmd FileType go set ai sw=4 ts=4 sts=4 noet
	" Ruby
	autocmd FileType ruby,eruby,yaml set ai sw=2 ts=2 sts=2 et
	" Python
	autocmd FileType python set ai sw=2 ts=2 sts=2 et
	" Haskell
	autocmd FileType haskell set ai sw=2 ts=2 sts=2 et
	" Dart
	autocmd FileType dart set ai sw=2 ts=2 sts=2 et

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
		    \ if line("'\"") > 0 && line("'\"") <= line("$") |
		    \   exe "normal g`\"" |
		    \ endif
    augroup END
else
    set autoindent		" always set autoindenting on
endif " has("autocmd")

