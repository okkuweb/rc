set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
lua << EOF
require("config.lazy")
dofile(vim.fn.expand("~/.nvimlocal"))
EOF

