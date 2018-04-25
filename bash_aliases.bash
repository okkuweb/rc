## Use .bashrc for local changes

# Add colors to linux terminal with tmux support
TERM="screen-256color"

# Make vim the default text editor
EDITOR="vim"

# Command history longer and better formatting
HISTSIZE=500000
HISTFILESIZE=100000
HISTTIMEFORMAT="%d.%m.%y %T "

# Avoid duplicates in history
export HISTCONTROL=erasedups:ignoreboth

# Don't record some commands
export HISTIGNORE="&:[  ]*:exit:ls:bg:fg:history:clear"

# Expand the bang command before running it
shopt -s histverify

# Fix bash history in tmux sessions by appending to history file
shopt -s histappend

# Ensures common history for all sessions
export PROMPT_COMMAND='history -a'

# Save multi-line commands as one command
shopt -s cmdhist

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Update window size after every command
shopt -s checkwinsize

## PS1 aka bash prompt settings
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[\033[38;5;202m\]@\[$(tput sgr0)\]\[\033[38;5;208m\]\h\[$(tput sgr0)\]\[\033[38;5;202m\]\$(parse_git_branch):\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\n\[\033[38;5;202m\]>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
## Backup PS1
#export PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u@\h\$(parse_git_branch):\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\w\\$ \[$(tput sgr0)\]"


# Start chrome from terminal a bit easier
alias chrome="google-chrome"

# Extract any archive by just writing "extract"
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# List self-installed npm packages
alias nodelist="npm list -g --depth=0"

# Start browser-sync server in current folder
alias simpleserver="browser-sync start --server \".\" --files \"./**/*\""

# Add 256 colors to tmux
alias tmux="tmux -2"

# Alias vi to vim
alias vi="vim"

# Make moving and copying files safer by making it confirm overwrite
alias cp="cp -i"
alias mv="mv -i"

# Restart wifi
alias wifirestart="sudo systemctl restart NetworkManager"

# Alias shorthands
alias ls="ls --color"
alias la="ls -a --color"
alias l="ls --color"
alias ll="ls -l --color"
alias lr="ls -R --color"
alias lla="ls -la --color"

# Tmux aliases
alias amux="tmux at -t"
alias lmux="tmux ls"
alias nmux="tmux new -s"

# Recursive grep with perl regexes
alias grip="grep -riPHn"

# Git aliases
alias gs="git status"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"

# Disable ctrl-s to suspend
stty -ixon

# Alias for current date in folder format
alias today="date +%Y-%m-%d"

# Aliases for going up the directory
repeat() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}");  }

for i in {1..20}; do
    a=$(repeat '.' $i)
    d=$(repeat '../' $i)
    
    alias .$a="cd ${d}"
    alias .$i="cd ${d}"
done

# Alias for starting the ssh agent
alias startagent="eval \"$(ssh-agent -s)\""

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
