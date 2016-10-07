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
colorscheme molokai
let g:molokai_original = 1
hi MatchParen      ctermfg=208 ctermbg=233 cterm=bold 

" Add numbers to vim sidebar
set number

" Add system clipboard as the default clipboard
if has('unnamedplus')
   set clipboard=unnamed,unnamedplus
endif

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

