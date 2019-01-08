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
set cindent
set cinkeys-=0#
set indentkeys-=0#

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
colorscheme molokai

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
nnoremap <C-j> <C-E>j
nnoremap <C-k> <C-Y>k
vnoremap <C-j> <C-E>j
vnoremap <C-k> <C-Y>k

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
map <Leader>rh :w<CR>:! clear && haxe -main % --interp<CR>
map <Leader>rf :w<CR>:! clear && lime test neko -debug<CR>
map <Leader>rj :w<CR>:! clear && runjava .<CR>
map <Leader>rn :w<CR>:! clear && node %<CR>
map <Leader>rp :w<CR>:! clear && perl %<CR>
map <Leader>rl :w<CR>:! clear && love `pwd`<CR>
map <Leader>rb :w<CR>:! clear && bash %<CR>

" Make a breakpoint on underscores
set iskeyword-=_

" Does the opposite of shift + j
nnoremap <Leader>j i<CR><Esc>k$

" Add pasting from default buffer to search
nnoremap <Leader>/ /<C-r>"<CR>
vnoremap <Leader>/ /<C-r>"<CR>

" Make syntax highlighting faster to fix vim performance
set re=1

" Disable vaxe build stuff
let g:vaxe_skip_hxml = 1

" Nerdtree initialisation on empty file argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Make vim show full file path at the bottom
set statusline+=%F

" Fix for gitgutter realtime processing error
set shell=/bin/bash

" Adding some deafult values to column command
cmap column column -t -o " "

" Disable all bells and whistles cos they're annoying
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Open nerdtree
nmap <leader>d :NERDTreeToggle<CR>
" Find current open file in nerdtree
nmap <leader>D :NERDTreeFind<CR>

" Rebind ctrlp to leader + f(ind)
let g:ctrlp_map = '<leader>f'

" Add some stuff to java functions or some shit
let java_highlight_functions=1

" Added mapping for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"

" Yet another paste command (paste from last yank)
nnoremap <Leader>p "0p
vnoremap <Leader>p "0p

" Change 'ctrl+g' to do the same as 'g ctrl+g'
nnoremap <C-g> g<C-g>
vnoremap <C-g> g<C-g>

" Make it so vim reads my bash aliases
let $BASH_ENV = "~/.bash_aliases"

" PC specific vim settings
source ~/.vimlocal
