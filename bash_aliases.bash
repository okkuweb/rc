# Changes the terminal colors a bit
export PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u@\h:\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\w\\$ \[$(tput sgr0)\]"

# Start a simple PHP server in current directory
alias phpserver="php -S localhost:8000"

# Start chrome from terminal a bit easier
alias chrome="google-chrome"

# Extract any archive by just writing "extract"
alias extract="unp -U"

# List self-installed npm packages
alias nodelist="npm list -g --depth=0"

# Start browser-sync server in current folder
alias simpleserver="browser-sync start --server \".\" --files \"./**/*\""

# Add 256 colors to tmux
alias tmux="tmux -2"

# Add copy to clipboard alias
alias clip="xclip -sel clip < "

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
