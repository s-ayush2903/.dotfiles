set nocompatible              " be iMproved, required
filetype off                  " required

" NOTE:-> KEEP PLUGIN COMMANDS BETWEEN VUNDLE#BEGIN/END.
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rnu
set nu rnu
set noswapfile
set incsearch
set noerrorbells
set completeopt-=preview
syntax on
set encoding=utf-8

let mapleader = " "

set background=dark
let g:gruvbox_contrast_light="soft"
nnoremap <leader>R :Black<CR>
nnoremap <leader>w :wincmd w<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>i :YcmCompleter GoToImplementation<CR>
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"DO NOT ADD COMMENTS AND PLUGINS ON THE SAME LINE!!!"
"Follow this for adding plugins:
   "Comment what the plugin does
   "Plugin 'PLUGIN LOCATION(URI)'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf' , { 'do': { -> fzf#install() } }
Plugin 'udalov/kotlin-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'psf/black'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"YCM for autoCompletion
Plugin 'ycm-core/YouCompleteMe'

" For theming
Plugin 'morhetz/gruvbox'

Plugin 'prabirshrestha/vim-lsp'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"SYNTASTIC SETTINGS TO WORK, Use ':help syntastic' for help
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"For NerdTree(Explorer at the left of vi)
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-p> :FZF<CR>
"Opens Tree at the left only when a dir is opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('java', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('c', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('js', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('cpp', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('kt', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('jsx', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"Include the cpp template file present in .vim/templates
:autocmd BufNewFile *.cpp 0r ~/.vim/templates/cppFileInfra.cpp

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
        \ })
    autocmd BufWritePre *.py LspDocumentFormatSync
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.py,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"Live indentation
filetype on
filetype plugin indent on
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4

" Mandatary for me to open vi with Lightline on, as without this
" var set, lightline appears only when dirs are opened not with files only
set laststatus  =2

set expandtab

set autoindent
set smartindent
  set cindent       " more flexible indenting.
    set cino =>s,   " 1 tab after each brace
    set cino+=e0,       " Braces starting on a new line treated the same
    set cino+=n0,       " Treat ifs the same even if there are no braces
    set cino+=f0,       " Functions aren't special either.
    set cino+={0,}0,^0, " No per-brace fiddling.
    set cino+=:0,=s,    " Don't indent "case"s but indent their bodies
    set cino+=l1,       " Cases with braces get no extra indentation
    set cino+=g0,h0,    " No extra indents for "public", "private", etc.
    set cino+=p0,t0,    " No extra indents for function types and locals
    set cino+=+s,       " Continued lines are indented.
    set cino+=cs,C1,N0, " Indent multi-line comments.
    set cino+=)50,*50   " Search wide for unclosed brackets and comments
                " Don't understand the (n un Un wn mn commads
"For compilation
autocmd vimEnter *.cpp map <F8> :w <CR> :!clear ; g++ --std=c++17 %; if [ -f a.out ]; then time ./a.out; rm a.out; fi <CR>

"autocmd BufRead,BufWritePre *.sh normal gg=G

"HELP STUFF AND OTHER INFO GOES HERE
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use :scriptnames to see scripts installed for vim
" :PluginList will work only when you have Vundle installed
" :verbose set history?  -> reveals value of history and where set
colorscheme gruvbox
