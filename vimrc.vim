" - INFO -
" Plugin folder for gvim on windows is 'vimfiles'
" and name of the rc file is '_vimrc'
"
" - DEFECTIVE PLUGINS ON WINDOWS -
" vim-gitgutter
" vim-indent-guides
"
" - CONFIGURATIONS -
" Execute pathogen plugins
execute pathogen#infect()

" Add vim syntax highlighting to vimlocal
au BufNewFile,BufRead .vimlocal setlocal ft=vim

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
imap Jj <Esc>
imap jJ <Esc>
imap JJ <Esc>

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
noremap <F9> :set invnumber<CR>:GitGutterToggle<CR>

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
hi Folded ctermbg=236
hi Folded ctermfg=75

" Stop # and * from going to the next element instantly
nmap <silent> * :let @/='\<'.expand('<cword>').'\>'<CR>
nmap <silent> # :let @/='\<'.expand('<cword>').'\>'<CR>

" Save current file as sudo if opened without sudo
cmap w!! w !sudo tee % > /dev/null

" Add mouse support to vim
set mouse=a

" Add scrolling while in insert mode
inoremap <C-k> <C-x><C-y>
inoremap <C-j> <C-x><C-e>

" Gitgutter settings
set updatetime=250
let g:gitgutter_max_signs = 600

" Adding splitting to vim
nnoremap <C-w>% :vsplit<CR>
nnoremap <C-w>" :split<CR>

" Add hotkey for new tabs
nnoremap <C-t> :tabnew<CR>

" Run file in interpreter
map <Leader>rh :! clear && haxe -main % --interp<CR>
map <Leader>rj :! clear && node %<CR>
map <Leader>rp :! clear && perl %<CR>
map <Leader>rl :! clear && love `pwd`<CR>

" Make a breakpoint on underscores
set iskeyword-=_

" Does the opposite of shift + j
nnoremap <Leader>j i<CR><Esc>k$

" Add pasting from default buffer to search
nnoremap <Leader>/ /<C-r>"<CR>
vnoremap <Leader>/ /<C-r>"<CR>

" Make syntax highlighting faster to fix vim performance
set re=1

" PC specific vim settings
source ~/.vimlocal
