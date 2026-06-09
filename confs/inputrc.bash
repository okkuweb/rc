# Perform file completion in a case insensitive fashion
set completion-ignore-case on

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Treat hyphens and underscores as equivalent
set completion-map-case on

# Disable bell
set bell-style none

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
Space:magic-space

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[C": forward-char
"\e[D": backward-char

set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string \1\e[5 q\2
set vi-cmd-mode-string \1\e[1 q\2

$if mode=vi
set keymap vi-insert
"\ew": history-search-backward
"\ex": history-search-forward

set keymap vi-command
"\ew": history-search-backward
"\ex": history-search-forward
"ciw": "lbcw"
"diw": "lbdw"
"yiw": "lbyw"
"ciW": "lBcW"
"diW": "lBdW"
"yiW": "lByW"
$endif



