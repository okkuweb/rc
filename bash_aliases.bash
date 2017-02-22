# Add colors to linux terminal
TERM="screen-256color"

# Command history longer and better formatting
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT="%d.%m.%y %T "

# Changes the terminal colors a bit
export PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u@\h:\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\w\\$ \[$(tput sgr0)\]"

# Start a simple PHP server in current directory
alias phpserver="php -S localhost:8000"

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

# Change vim to nvim
alias vi="vim"

# Make a shorthand for bash_aliases
alias editbash="vi ~/.bash_aliases && source ~/.bash_aliases"

# Make moving and copying files safer by making it confirm overwrite
alias cp="cp -i"
alias mv="mv -i"

# Shorthand for cd ..
alias ..="cd .."

# Restart wifi
alias wifirestart="sudo service network-manager restart"

# Alias shorthand for ls -a
alias la="ls -a"

# Alias shorthand for ls
alias l="ls"

# Alias shorthand for ls -l
alias ll="ls -l"

# Alias for recursive ls -R
alias lr="ls -R"

# Alias for calulation tool
alias calc="bc"

# Tmux aliases
alias amux="tmux at -t"
alias lmux="tmux ls"
alias nmux="tmux new -s"

# Recursive grep with perl regexes
alias grip="grep -riP"

# Aliases for going up the directory
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Disable ctrl-s to suspend
stty -ixon

