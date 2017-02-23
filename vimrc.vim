" Execute pathogen plugins
execute pathogen#infect()

" Start syntax highlighting
syntax on

" Tab fixes
set smarttab
" Make tabs 4 spaces
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Makes the spaces feel like real tabs
set softtabstop=4
" Make vim indent to next tab spot instead of always indenting 4 spaces
set shiftround
" Make it possible to indent properly in files that do not have a proper filetype
set smartindent

" Set vim temporary files to home folder
if !isdirectory($HOME."/.vim/tempfiles")
    call mkdir($HOME."/.vim/tempfiles", "p")
endif
set backupdir=~/.vim/tempfiles/
set directory=~/.vim/tempfiles/

" Rebind leader key
let mapleader=" "

" Rebind enter to colon
map <Enter> :

" Rebind gitgutter keys
map <Leader>< <Plug>GitGutterPrevHunk
map <Leader>> <Plug>GitGutterNextHunk

" colorscheme
let g:molokai_original = 1
colorscheme molokai
hi MatchParen      ctermfg=208 ctermbg=233 cterm=bold 

" Add numbers to vim sidebar
set number

" Set escape from insert mode to jj
imap jj <Esc>

" Add newlines with enter without going to insert mode
nmap <C-o> o<Esc>

" Make a buffer file to home folder for copying between vims
vmap <C-y> :w! ~/.vimbuffer<CR>
nmap <C-y> :.w! ~/.vimbuffer<CR>
" Paste from buffer
map <C-p> :r ~/.vimbuffer<CR>

" Toggle paste mode with F10
set pastetoggle=<F10>

" Set line number toggle
noremap <F9> :set invnumber<CR>
inoremap <F9> <C-O>:set invnumber<CR>

" Traverse one line at a time
nnoremap <C-j> <C-E>
nnoremap <C-k> <C-Y>
vnoremap <C-j> <C-E>
vnoremap <C-k> <C-Y>

" Make search case insensitive and only sensitive when using uppercase letters
set ignorecase
set smartcase

" Set persistent undo
set undofile
set undodir=~/.vim/tempfiles
set undolevels=1000
set undoreload=10000

" Fix update frequency for gitgutter
set updatetime=250

" Hotkey for resetting syntax highlighting
noremap <Leader>l <Esc>:syntax sync fromstart<CR>

" Settings for indent guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=237
hi IndentGuidesEven ctermbg=236

" Highlight search
set hlsearch

" Set folding to work by indentation
set foldmethod=indent
set foldlevelstart=20
