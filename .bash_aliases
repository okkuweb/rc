# Enables nvm in terminal
export NVM_DIR="/home/webdev/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Changes the terminal colors a bit
export PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u@\h:\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\w\\$ \[$(tput sgr0)\]"

# Enables composer in terminal
# export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Start a simple PHP server in current directory
alias phpserver="php -S localhost:8000"

# Start chrome from terminal a bit easier
alias chrome="google-chrome"

# This enables composer in terminal
alias composer="/usr/local/bin/composer/composer.phar"

# Enable autojump in terminal
. /usr/share/autojump/autojump.sh

# Open file manager in current directory
alias opendir="caja"

# Extract any archive by just writing "extract"
alias extract="unp"

# List self-installed npm packages
alias nodelist="npm list -g --depth=0"

# Start browser-sync server in current folder
alias simpleserver="browser-sync start --server \".\" --files \"./**/*\""

# Add 256 colors to tmux
alias tmux="tmux -2"

# Add copy to clipboard alias
alias clip="xclip -sel clip < "

# Change vim to nvim
alias vi="nvim"
