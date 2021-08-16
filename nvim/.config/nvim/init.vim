"""""""""""
" General "
"""""""""""

if has("win64") || has("win32") || has("win16")
    let g:os = "windows"
else
    let g:os = "unix"
endif

if g:os == "windows"
    let g:python3_host_prog  = "C:/Users/andrey/AppData/Local/Programs/Python/Python38/python.exe"
endif

function! Dot(path)
    if g:os == "windows"
        return "~/AppData/Local/nvim/" . a:path
    endif
    return "~/.config/nvim/" . a:path
endfunction

let g:init_file = Dot("init.vim")
command! SourceVimrc execute 'source ' . g:init_file | setlocal iminsert=0
command! OpenVimrc execute 'e ' . g:init_file

set history=500

" unix as the standard file type
set ffs=unix,dos,mac

set mouse=a

set iminsert=0
set keymap=russian-jcukenwin
set viewoptions=folds,cursor
autocmd BufRead *.* silent setlocal iminsert=0

" disable this shit
set nofoldenable
" auto read when file is changed from the outside
set autoread
autocmd FocusGained,BufEnter * checktime

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" |
    \ endif

" automatically creating directory
autocmd BufWritePre *
    \ if !isdirectory(expand('<afile>:p:h')) |

function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

autocmd BufWritePre,FileWritePre,FileAppendPre,FilterWritePre *
    \ :call <SID>StripTrailingWhitespaces()

""""""""""""""
" GENERAL/UI "
""""""""""""""

" autocmd UIEnter *
    " \ GuiFont! JetBrainsMono\ NF:h13

" 7 line to the cursor
set so=7

set number

set nowrap

" english is default language
let $LANG="en"
set langmenu=en

" always show current position
"set ruler

" highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

" height of the command bar
set cmdheight=1

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

" show matching brackets
set showmatch

" no bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""
" Colors and fonts "
""""""""""""""""""""

" enable syntax highlighting
syntax enable

" enable 256 colors in terminal
set t_Co=256
set termguicolors

" default colors
colorscheme zellner

"""""""""""
" Backups "
"""""""""""

" turn backup off
set nobackup
set nowb
set noswapfile

""""""""""
" Indent "
""""""""""

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set autoindent
set smartindent

"""""""""""
" Mapping "
"""""""""""

let mapleader = "\\"
nmap <leader>vo :OpenVimrc<cr>
nmap <leader>vs :SourceVimrc<cr>:noh<cr>
nmap <leader>s :w<cr>
nmap <leader>q :q<cr>

tnoremap <Esc> <C-\><C-n>

" exit insert mode
inoremap jk <esc>
inoremap jj <esc>
inoremap kj <esc>

""""""""""""""""""
" Mapping/Moving "
""""""""""""""""""

" fast up and down screen
nnoremap <leader>u <c-u>
nnoremap <leader>d <c-d>

" disable highlight
nnoremap <silent> <leader><cr> :noh<cr>
nnoremap <space> /
nnoremap <leader><space> ?

" buffers
nnoremap <leader>bb :buffers<cr>:b<space>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bl :bnext<cr>
nnoremap <leader>bh :bprev<cr>

" tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove<space>
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>

" windows
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key, '[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

map <silent> <leader>h :call WinMove('h')<CR>
map <silent> <leader>j :call WinMove('j')<CR>
map <silent> <leader>k :call WinMove('k')<CR>
map <silent> <leader>l :call WinMove('l')<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>0 :Goyo<cr>

"""""""""""""""""""
" Mappign/Editing "
"""""""""""""""""""

vnoremap > >gV
vnoremap < <gV

nnoremap <leader>r <c-r>

inoremap <C-l> <C-^>

"""""""""""
" Plugins "
"""""""""""

if g:os == "windows"
  call plug#begin('~/AppData/Local/nvim/plugged')
else
  call plug#begin('~/.config/nvim/plugged')
endif

nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pc :PlugClean<cr>
Plug 'xolox/vim-misc'

""""""""""""""""""""""
" Plugins/Navigation "
""""""""""""""""""""""

Plug 'preservim/nerdtree'
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="right"

Plug 'preservim/tagbar'
nnoremap <leader>t :Tagbar<cr>
let g:tagbar_left=0
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_sort=0
let g:tagbar_compact=1

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
nnoremap <leader>f :FZF<cr>

Plug 'easymotion/vim-easymotion'
map <leader>a <Plug>(easymotion-overwin-f)
map <leader>a <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

"""""""""""""""""""
" Plugins/Editing "
"""""""""""""""""""

Plug 'matze/vim-move'
Plug 'jiangmiao/auto-pairs'


"""""""""""""""
" Plugins/GIT "
"""""""""""""""

" command wrapper
Plug 'tpope/vim-fugitive'

" nerdtree integration
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Ignored'   :'☒',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?',
    \ }

" commit browser
Plug 'junegunn/gv.vim'

" show diffs in sign column
Plug 'airblade/vim-gitgutter'

" branch managment
Plug 'sodapopcan/vim-twiggy'

""""""""""""""""""""""""""
" Plugings/Auto Complete "
""""""""""""""""""""""""""

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
    endif
endfunction

let g:coc_global_extensions = [
      \'coc-clangd',
      \'coc-rls',
      \]

""""""""""""""""
" Plugins/Rust "
""""""""""""""""

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave=1
autocmd BufRead,BufNewFile *.rs set filetype=rust
autocmd Filetype rust nnoremap <leader>5 :Cargo build<cr>
autocmd Filetype rust nnoremap <leader>6 :Cargo run<cr>

"""""""""""""""""
" Plugins/Style "
"""""""""""""""""

" start screen
Plug 'mhinz/vim-startify'

" editing just text
Plug 'junegunn/goyo.vim'

" icons
Plug 'ryanoasis/vim-devicons'

Plug 'xolox/vim-colorscheme-switcher'

Plug 'chriskempson/base16-vim'

call plug#end()

colorscheme base16-gruvbox-dark-hard
