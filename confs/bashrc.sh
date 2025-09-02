if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
    export TERM="xterm-256color"
fi


# Run bash alias file
if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
fi
# Run machine specific bash commands
if [ -f ~/.bash_local.sh ]; then
    . ~/.bash_local.sh
fi

# Make nvim the default text editor
EDITOR="nvim"

# Command history longer and better formatting
HISTSIZE=2000000
HISTFILESIZE=100000
HISTTIMEFORMAT="%d.%m.%y %T "
# Avoid duplicates in history
export HISTCONTROL=erasedups:ignoreboth

# Expand the bang command before running it
shopt -s histverify

# Fix bash history in tmux sessions by appending to history file
shopt -s histappend

# Ensures common history for all sessions
if [ -n "$(type -t autojump)" ]; then
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
else
    export PROMPT_COMMAND="history -a"
fi

# Save multi-line commands as one command
shopt -s cmdhist

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Update window size after every command
shopt -s checkwinsize

## PS1 aka bash prompt settings
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[\033[38;5;202m\]@\[$(tput sgr0)\]\[\033[38;5;208m\]\h\[$(tput sgr0)\]\[\033[38;5;202m\]\$(parse_git_branch):\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\n\[\033[38;5;202m\]>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
## Backup PS1
#export PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u@\h\$(parse_git_branch):\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\w\\$ \[$(tput sgr0)\]"

# Extract any archive by just writing "unp"
unp () {
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

## BETTER DIRECTORY NAVIGATION ##
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# Fix for screen-256color less search highlight
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ ! -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

export GOPATH=~/.go

PATH=$PATH:~/.local/games:~/.local/bin:/usr/local/go/bin:~/.go/bin:~/.n/bin:~/.cargo/bin

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

export N_PREFIX=$HOME/.n

