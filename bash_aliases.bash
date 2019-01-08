# A thing to make aliases work in vim shell
shopt -s expand_aliases

# List self-installed npm packages
alias nodelist="npm list -g --depth=0"

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
alias rmux="tmux kill-session -t"

# Recursive grep with perl regexes
alias grip="grep -riPHn"

# Git aliases
alias gs="git status"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"

# Alias for current date in folder format
alias today="date +%Y-%m-%d"

# Alias for starting the ssh agent
alias startagent="eval \"$(ssh-agent -s)\""

# Aliases for going up the directory
repeat() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}");  }

for i in {1..20}; do
    a=$(repeat '.' $i)
    d=$(repeat '../' $i)
    
    alias .$a="cd ${d}"
    alias .$i="cd ${d}"
done

