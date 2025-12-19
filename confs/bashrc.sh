if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
    export TERM="xterm-256color"
fi

export COLORTERM=truecolor

# Make nvim the default text editor
export EDITOR="nvim"

# Command history longer and better formatting
export HISTSIZE=2000000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%d.%m.%y %T "
# Avoid duplicates in history
export HISTCONTROL=erasedups:ignoreboth

# Expand the bang command before running it
shopt -s histverify

# Fix bash history in tmux sessions by appending to history file
shopt -s histappend

# Ensures common history for all sessions
export PROMPT_COMMAND="history -a"

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
    local branch
    branch=$(git branch 2> /dev/null | sed -n '/^\*/s/^\* //p')
    
    # If first argument is "paren" or "()", wrap in parentheses
    if [[ "$1" == "paren" || "$1" == "()" ]]; then
        [[ -n "$branch" ]] && branch=" ($branch)"
    fi
    
    echo "$branch"
}
export PS1="\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[\033[38;5;202m\]@\[$(tput sgr0)\]\[\033[38;5;208m\]\h\[$(tput sgr0)\]\[\033[38;5;202m\]\$(parse_git_branch 'paren'):\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\n\[\033[38;5;202m\]>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

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

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULES="wayland;fcitx;ibus"
export MOSH_SERVER_NETWORK_TMOUT=604800

if [[ $- == *i* ]]
then
    stty -ixon
fi

# Run bash alias file
if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
fi
# Run machine specific bash commands
if [ -f ~/.bash_local.sh ]; then
    . ~/.bash_local.sh
fi

