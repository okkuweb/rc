# Recursive grep with perl regexes
if command -v rg &> /dev/null
then
    alias grip="rg -iPHnM 1000 -g '!node_modules' -g '!puppeteer'"
    alias grp="rg -PHnM 1000 -g '!node_modules' -g '!puppeteer'"
else
    # Recursive grep with perl regexes
    alias grip="grep --color=auto -riPHn"
    alias grp="grep --color=auto -rPHn"
	# Recursive grip that cuts out files that have too long lines
	function gut () {
		if [ -z "$1" ]; then echo "Provide a parameter"
		else grep --color=always -riPHn $1 | cut -c1-320
		fi
	}
	function gt () {
		if [ -z "$1" ]; then echo "Provide a parameter"
		else grep --color=always -rPHn $1 | cut -c1-320
		fi
	}
fi

# A thing to make aliases work in vim shell
shopt -s expand_aliases

# List self-installed npm packages
alias nodelist="npm list -g --depth=0"

# Add 256 colors to tmux
alias tmux="tmux -2"

# Alias vi to vim
alias vi="nvim"
# Alias vim to nvim
alias vim="nvim"

# Make moving and copying files safer by making it confirm overwrite
alias cp="cp -i"
alias mv="mv -i"

# Alias shorthands
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias l="ls --color=auto"
alias ll="ls -l --color=auto"
alias lr="ls -R --color=auto"
alias lla="ls -la --color=auto"

# Tmux aliases
alias amux="tmux at -t"
alias lmux="tmux ls"
alias nmux="tmux new -s"
alias rmux="tmux kill-session -t"

# Recursive grip that cuts out files that have too long lines
function gut () {
    if [ -z "$1" ]; then echo "Provide a parameter"
    else grep --color=always -riPHn $1 | cut -c1-320
    fi
}
function gt () {
    if [ -z "$1" ]; then echo "Provide a parameter"
    else grep --color=always -rPHn $1 | cut -c1-320
    fi
}

# Git aliases
alias gs="git status"
alias gc="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log"
alias gr="git diff --name-only | uniq | xargs nvim"

# Alias for current date in folder format
alias today="date +%Y-%m-%d"

# Alias for starting the ssh agent
alias startagent="eval \"$(ssh-agent -s)\""

# Aliases for going up the directory
function repeat() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}");  }

for i in {1..20}; do
    a=$(repeat '.' $i)
    d=$(repeat '../' $i)
    
    alias .$a="cd ${d}"
    alias .$i="cd ${d}"
done

# Watch file and run command when changes happen
function watchit () {
    path=$1
    shift
    cmd=$*
    sha=0
    update_sha() {
        sha=`ls -lR --time-style=full-iso $path | sha1sum`
    }
    update_sha
    previous_sha=$sha
    build() {
        echo -en " building...\n\n"
        $cmd
        echo -en "\n--> resumed watching."
    }
    compare() {
    update_sha
    if [[ $sha != $previous_sha ]] ; then
        echo -n "change detected,"
        build
        previous_sha=$sha
    fi
    }

    echo -en "--> watching \"$path\"."
    while true; do
        compare
        sleep 1
    done
}

# Grep coloring
alias grep="grep --color=auto"

[ -x /usr/bin/lesspipe  ] && eval "$(SHELL=/bin/sh lesspipe)"

if command -v fd &> /dev/null; then
    alias fd='fd'
elif command -v fdfind &> /dev/null; then
    alias fd='fdfind'
elif command -v fd-find &> /dev/null; then
    alias fd='fd-find'
fi

alias resetbluetooth="sudo systemctl restart bluetooth && sudo rmmod btusb && sudo modprobe btusb"

alias big='du -ah . | sort -rh | head -20'
alias big-files='ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n20'

alias gnollhack="TERM=xterm-256color gnollhack -T"
alias sil="sil -mgcu -uDelver -r"

alias gogo="go build -o app ./... && ./app"

# Start vim in leetcode mode
alias leet="nvim -c Leet"

# Switch lofree function keys to actual function keys
alias lofreeswitch="echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode"

