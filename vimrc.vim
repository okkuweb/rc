" Indent automatically
set autoindent
" Make backspace delete over line breaks
set backspace=indent,eol,start
" Autocomplete with ctrl + p
set complete-=i
" Incrementing numbers properly :V I dunno
set nrformats-=octal

" Adjust vim leader key timeout length
set ttimeout
set ttimeoutlen=100

" Make vim search while typing
set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Always show status of the open file as in file location
set laststatus=2
" Shows the line number and percents in the right of the status bar
set ruler
" Autocompletion in command line mode
set wildmenu

" Prevents the cursor from going to the bottom of the screen
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Sets utf-8 character encoding in gui mode probably
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" I really don't know what this does
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j 
endif

" Please what does this do? :<
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" This does something when the default shell is fsh I guess
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/bin/bash
endif

" Reload vim file with :e I guess :I
set autoread

" Add some more vim command history
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" What does this do?
inoremap <C-U> <C-G>u<C-U>

" And what is this even?
" vim:set ft=vim et sw=2:

" Tab fixes
set smarttab
" Make tabs 4 spaces
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" makes the spaces feel like real tabs
set softtabstop=4

" colorscheme
let g:molokai_original = 1
colorscheme molokai
hi MatchParen      ctermfg=208 ctermbg=233 cterm=bold 

" Add numbers to vim sidebar
set number

" Set escape from insert mode to jj
imap jj <Esc>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Change emmet expand hotkey to ctrl + e + ,
let g:user_emmet_leader_key='<C-E>'

" Change tab completion direction
let g:SuperTabDefaultCompletionType = "<c-n>"

" Set neosnippet expand binding
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Add newlines with enter without going to insert mode
nmap <C-o> o<Esc>

" Make Esc escape from terminal mode in neovim terminal
tnoremap <Esc> <C-\><C-n>

" Activate color highlighting
let g:colorizer_auto_filetype='css,html,scss,less,sass,js,ts'

" Make jj exit insert mode in terminal mode
tmap jj <Esc>

" Make a buffer file to home folder for copying between vims
vmap <C-y> y:let @a = @<CR>:sp ~/.vimbuffer<CR>ggdG:let @" = @a<CR>p:w<CR>:bdelete!<CR> " This monstrosity isn't that elegant...
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
