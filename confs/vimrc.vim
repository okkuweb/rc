" - INFO -
" Plugin folder for gvim on windows is 'vimfiles'
" and name of the rc file is '_vimrc'
"
" - DEFECTIVE PLUGINS ON WINDOWS -
" vim-gitgutter
" vim-indent-guides
"
" - CONFIGURATIONS -

" Set environment variables for gitgutter

if !has('nvim')
    let $TMP = $HOME . "/.vim/tempfiles/"
    let $TMPDIR = $HOME . "/.vim/tempfiles/"
else
    let $TMP = $HOME . "/.nvim/tempfiles/"
    let $TMPDIR = $HOME . "/.nvim/tempfiles/"
endif

if !has('nvim')
    " Execute pathogen plugins
    call plug#begin()
    " List your plugins here
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'airblade/vim-gitgutter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'mbbill/undotree'
    Plug 'simeji/winresizer'
    call plug#end()
endif

" Start syntax highlighting
if !has('nvim')
    syntax on
endif

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
set backup
if !isdirectory($HOME."/.vim/tempfiles")
    call mkdir($HOME."/.vim/tempfiles", "p")
endif
if !isdirectory($HOME."/.nvim/tempfiles")
    call mkdir($HOME."/.nvim/tempfiles", "p")
endif
if has('nvim')
    set backupdir=~/.nvim/tempfiles/
    set directory=~/.nvim/tempfiles/
else
    set backupdir=~/.vim/tempfiles/
    set directory=~/.vim/tempfiles/
endif

" Rebind leader key
let mapleader=" "

" Rebind enter to colon
map <Enter> :

" Rebind gitgutter keys
map <Leader>< <Plug>(GitGutterPrevHunk)
map <Leader>> <Plug>(GitGutterNextHunk)
map <Leader>, <Plug>(GitGutterPrevHunk)
map <Leader>. <Plug>(GitGutterNextHunk)

" colorscheme
if !has('nvim')
    colorscheme molokai
endif

" Add numbers to vim sidebar
set number

" Set escape from insert mode to jk
imap jk <Esc>
imap Jk <Esc>
imap jK <Esc>
imap JK <Esc>
imap kj <Esc>
imap Kj <Esc>
imap kJ <Esc>
imap KJ <Esc>

" Add newlines with enter without going to insert mode
nmap <Leader>o o<Esc>
nmap <Leader>O O<Esc>

" Make a buffer file to home folder for copying between vims
"vmap <C-y> :w! ~/.vimbuffer<CR>
nmap <C-y> :.w! ~/.vimbuffer<CR>
vmap <C-y> "ny:new ~/.vimbuffer<CR>VG"nP:w<CR>:bdelete!<CR>:let @"=@0<CR>

" Paste from buffer
map <C-p> :r ~/.vimbuffer<CR>

" Toggle paste mode with F10
if !has('nvim')
    set pastetoggle=<F10>
else
" I mean, just bring pastetoggle back pls
    nnoremap <silent> <F10> :set paste!<cr>
    inoremap <silent> <F10> <esc>:set paste!<cr>i
endif

" Set line number toggle
if !has('nvim')
    noremap <silent> <F9> :set number!<CR>:GitGutterToggle<CR>
else
" Some things are just so much harder in nvim
    noremap <silent> <F9> :set invnumber<CR>:call ToggleStatusColumn()<CR>:GitGutterToggle<CR>
    inoremap <silent> <F9> <esc>:set invnumber<CR>:call ToggleStatusColumn()<CR>:GitGutterToggle<CR>i
endif

function! ToggleStatusColumn()
    exe "set statuscolumn=" .. (&statuscolumn == "" ? "%!v:lua.require'snacks.statuscolumn'.get()" : "")
endfunction

" Traverse one line at a time
nnoremap <C-j> <C-E>j
nnoremap <C-k> <C-Y>k
vnoremap <C-j> <C-E>j
vnoremap <C-k> <C-Y>k

" Make search case insensitive and only sensitive when using uppercase letters
set ignorecase
set smartcase

" Set persistent undo
if !has('nvim')
    set undofile
    set undodir=~/.vim/tempfiles
endif
set undolevels=1000
set undoreload=10000

" Hotkey for resetting syntax highlighting
noremap <Leader>l <Esc>:syntax sync fromstart<CR>

" Settings for indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_default_mapping = 0
nmap <silent> <Leader>g <Plug>IndentGuidesToggle
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
cmap W!! w !sudo tee % > /dev/null

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

" Run file in interpreter
if !has('nvim')
    nnoremap <Leader>rj :w<CR>:! clear && node %<CR>
    nnoremap <Leader>rp :w<CR>:! clear && perl %<CR>
    nnoremap <Leader>rb :w<CR>:! clear && bash %<CR>
    nnoremap <Leader>re :w<CR>:! clear && expect %<CR>
    nnoremap <Leader>rg :w<CR>:! clear && go run %<CR>
    nnoremap <Leader>rG :w<CR>:! clear && go build -o app && ./app<CR>
else
    nnoremap <Leader>rj :w<CR>:! node %<CR>
    nnoremap <Leader>rp :w<CR>:! perl %<CR>
    nnoremap <Leader>rb :w<CR>:! bash %<CR>
    nnoremap <Leader>re :w<CR>:! expect %<CR>
    nnoremap <Leader>rg :w<CR>:! go run %<CR>
    nnoremap <Leader>ri :w<CR>:GoImports<CR>
    nnoremap <Leader>bg :w<CR>:TermExec cmd="gogo"<CR>
endif

" Make a breakpoint on underscores
set iskeyword-=_

" Does the opposite of shift + j
nnoremap <Leader>j i<CR><Esc>k$

" Add pasting from default buffer to search
nnoremap <Leader>/ /<C-r>"<CR>
vnoremap <Leader>/ /<C-r>"<CR>

" Make syntax highlighting faster to fix vim performance
set re=1

" Make vim show full file path at the bottom
set statusline+=%F

" Fix for gitgutter realtime processing error
set shell=/bin/bash

" Disable all bells and whistles cos they're annoying
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Yet another paste command (paste from last yank)
noremap <Leader>P "0p
" Yet another paste command (paste from clipboard)
noremap <leader>p "+p
" Yet another copy command (copy to clipboard)
noremap <leader>y "+yy

" Change 'ctrl+g' to do the same as 'g ctrl+g'
nnoremap <C-g> g<C-g>
vnoremap <C-g> g<C-g>

" Better keys for going to the end and beginning of the line
nnoremap <Leader>a $
vnoremap <Leader>a $
nnoremap <Leader>i ^
vnoremap <Leader>i ^

" Go up the file stack
nnoremap <Leader>b <C-T>

" Leader + Enter makes an enter press instead of ":"
nnoremap <Leader><CR> <CR>

" Make it so vim reads my bash aliases
let $BASH_ENV = "~/.bash_aliases"

" Remove all trailing whitespace
nnoremap <Leader>T :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <Leader>t :tabnew<CR>

" Close scratchpad
nnoremap <Leader>c :pc<CR>

" Disable modeline for its security issues
set nomodeline

" Add an additional increment binding
nnoremap <C-i> <C-a>
" Unbind default increment binding 
" (it causes too many code errors since it's the same as tmux prefix)
nnoremap <C-a> <Nop>

set laststatus=2

" Set 2 space indentation for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Define a global variable to track the warning counter
if !exists('g:warning_counter')
    let g:warning_counter = 1
endif

" Define a function that inserts a logging statement based on filetype
function! InsertWarning()
    let l:logs = {
        \ 'c': 'printf("WARNING %d: Debug checkpoint\\n", ' . g:warning_counter . ');',
        \ 'cpp': 'std::cout << "WARNING ' . g:warning_counter . ': Debug checkpoint" << std::endl;',
        \ 'java': 'System.out.println("WARNING ' . g:warning_counter . ': Debug checkpoint");',
        \ 'javascript': 'console.warn("WARNING ' . g:warning_counter . ': Debug checkpoint");',
        \ 'typescript': 'console.warn("WARNING ' . g:warning_counter . ': Debug checkpoint");',
        \ 'python': 'import warnings; warnings.warn("WARNING ' . g:warning_counter . ': Debug checkpoint")',
        \ 'ruby': 'warn "WARNING ' . g:warning_counter . ': Debug checkpoint"',
        \ 'go': 'log.Printf("WARNING %d: Debug checkpoint", ' . g:warning_counter . ')',
        \ 'rust': 'eprintln!("WARNING ' . g:warning_counter . ': Debug checkpoint");',
        \ 'php': 'trigger_error("WARNING ' . g:warning_counter . ': Debug checkpoint", E_USER_WARNING);',
        \ 'swift': 'print("WARNING ' . g:warning_counter . ': Debug checkpoint")',
        \ 'perl': 'warn "WARNING ' . g:warning_counter . ': Debug checkpoint";',
        \ 'sh': 'echo "WARNING ' . g:warning_counter . ': Debug checkpoint" >&2',
        \ 'bash': 'echo "WARNING ' . g:warning_counter . ': Debug checkpoint" >&2',
        \ 'html': '<script>console.warn("WARNING ' . g:warning_counter . ': Debug checkpoint");</script>',
        \ 'xml': '<!-- WARNING ' . g:warning_counter . ': Debug checkpoint -->',
        \ 'css': '/* WARNING ' . g:warning_counter . ': Debug checkpoint */',
        \ 'lua': 'print("WARNING ' . g:warning_counter . ': Debug checkpoint")',
        \ 'vim': 'echowarn "WARNING ' . g:warning_counter . ': Debug checkpoint"',
        \ 'haskell': 'putStrLn $ "WARNING ' . g:warning_counter . ': Debug checkpoint"',
        \ 'lisp': '(warn "WARNING ' . g:warning_counter . ': Debug checkpoint")',
        \ 'clojure': '(println "WARNING ' . g:warning_counter . ': Debug checkpoint")'
        \ }
    
    " Get current filetype
    let l:ft = &filetype
    
    " Default log for unknown filetypes
    let l:log = 'print("WARNING ' . g:warning_counter . ': Debug checkpoint")'
    
    " Use specific log if available
    if has_key(l:logs, l:ft)
        let l:log = l:logs[l:ft]
    endif
    
    " Get current indentation
    let l:indent = matchstr(getline('.'), '^\s*')
    
    " Insert the log statement at the line after the current cursor position with indentation
    let l:line = line('.')
    call append(l:line, l:indent . l:log)
    
    " Move cursor to the newly inserted line
    call cursor(l:line + 1, len(l:indent) + 1)
    
    " Increment the counter for next time
    let g:warning_counter += 1
endfunction

" Function to reset the warning counter
function! ResetWarningCounter()
    let g:warning_counter = 1
    echo "Warning counter reset to 1"
endfunction

" Map leader+w to the warning function
nnoremap <leader>w :call InsertWarning()<CR>

" Map leader+r to reset the warning counter
nnoremap <leader>R :call ResetWarningCounter()<CR>

" Undotree toggle binding
nnoremap <leader>u :UndotreeToggle<CR>

" Close window and force close
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Make it so that closing windows doesn't resize other windows
set noequalalways

" PC specific vim settings
source ~/.vimlocal.vim
