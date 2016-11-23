" Plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tomasr/molokai'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'
Plug 'leafgarland/typescript-vim'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'chrisbra/colorizer'
Plug 'tpope/vim-surround'
call plug#end()


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

