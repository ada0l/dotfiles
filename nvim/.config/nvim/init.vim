"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => General                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("win64") || has("win32")
    let g:os = "windows"
else
    let g:os = "unix"
endif

if g:os == "unix"
    let g:python3_host_prog = "/usr/bin/python3"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Vim-Plug                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if has('win32') && !has('win64')
    let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
    let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
    if !executable(curl_exists)
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"
    autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'scrooloose/nerdtree'
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'camspiers/lens.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/goyo.vim'

if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif

"" GIT
Plug 'tpope/vim-fugitive'

"" Color
Plug 'chriskempson/base16-vim'
Plug 'dylanaraps/wal.vim'
Plug 'bfrg/vim-cpp-modern'

"" Status line
"Plug 'itchyny/lightline.vim/'
"Plug 'daviesjamie/vim-base16-lightline'

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" python
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

"" html
Plug 'mattn/emmet-vim'

call plug#end()

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Basic                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Enable hidden buffers
set hidden

"" Disable this shit
set nofoldenable

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Turn backup off
set nobackup
set nowb
set noswapfile

set fileformats=unix,dos,mac

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

set keymap=russian-jcukenwin

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Visual Settings                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set ruler
set number
set relativenumber
set nowrap

let no_buffers_menu=1

set mousemodel=popup

set t_Co=256

if &term =~ '256color'
    set t_ut=
endif

set textwidth=80
set colorcolumn=70

"" Disable the blinking cursor.
set gcr=a:blinkon0

set scrolloff=7

"" Use modeline overrides
set modeline
set modelines=10

"" Search mappings: These will make it so that going to the next one in a
"" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Abbreviations                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Function                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Dot(path)
    if g:os == "windows"
        return "~/AppData/Local/nvim/" . a:path
    endif
    return "~/.config/nvim/" . a:path
endfunction

if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Commands                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:init_file = Dot("init.vim")
command! SourceVimrc execute 'source ' . g:init_file |
            \ setlocal iminsert=0
command! OpenVimrc execute 'e ' . g:init_file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Autocommands                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ exe "normal! g'\"" |
            \ endif

"" automatically creating directory
autocmd BufWritePre *
            \ if !isdirectory(expand('<afile>:p:h')) |

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Mappings                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\\"
nmap <leader>vo :OpenVimrc<cr>
nmap <leader>vs :SourceVimrc<cr>:noh<cr>
nmap <leader>s :w<cr>
nmap <leader>q :q<cr>

inoremap jk <esc>
inoremap jj <esc>
inoremap kj <esc<

tnoremap <Esc> <C-\><C-n>

"" => Moving

" disable highlight
nnoremap <silent> <leader><cr> :noh<cr>
nnoremap <space> /
nnoremap <c-space> ?

" buffers
nnoremap <leader>b :buffers<cr>:b<space>

" tabs
nnoremap <leader>e :tabedit <C-r>=expand("%:p:h")<cr>

" cd
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"" => Editing

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap > >gv
vnoremap < <gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

inoremap <c-l> <c-^>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Plugins settings                                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>pli :PlugInstall<cr>
nnoremap <leader>plc :PlugClean<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => NERDTree                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowLineNumbers=2
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 40
let g:NERDTreeWinPos = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => TagBar                                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>t :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_show_linenumbers = 2
let g:tagbar_jump_offset=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => IndentLine                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indentLine_enabled = 0
let g:indentLine_concealcursor = 0
let g:indentLine_char = '|'
let g:indentLine_faster = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Super Tab                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => coc.nvim                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

map <leader>f  <Plug>(coc-format)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => FZF                                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

nnoremap <leader>p :FZF<cr>
nnoremap <leader>b :Buffers<cr>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
    set grepprg=ag\ --nogroup\ --nocolor
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Session management                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Colors                                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let base16colorspace=256 
colorscheme base16-harmonic-light

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => cpp highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Easy motion                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap s <Plug>(easymotion-overwin-f2)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => UltiSnips                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
