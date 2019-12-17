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
alias grip="grep --color=always -riPHn"
alias grp="grep --color=always -rPHn"
gut () {
    if [ -z "$1" ]; then echo "Provide a parameter"
    else grep --color=always -riPHn $1 | cut -c1-320
    fi
}
gt () {
    if [ -z "$1" ]; then echo "Provide a parameter"
    else grep --color=always -rPHn $1 | cut -c1-320
    fi
}

# Recursive grip that cuts out files that have too long lines
alias gut="grep -rLZE '.{500}' . | xargs -r0 grep --color=always -iPHn"

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

# Watch file and run command when changes happen
watchit () {
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

# Function to read vim root folder main class in java
runjava () {
    if [ -d "$1" ]; then
        cd $1
        folder=`pwd`
        main=`cat $folder/main.txt`
        if [ -d "$folder" ] && [ -n "$main" ]; then
            find $folder -name \*.java -print > class.list
            if javac @class.list; then
                java $main
            else
                echo "Compilation failed"
            fi
        else
            echo "Invalid parameters"
        fi
    else
        echo "Please provide a directory and add a main.txt with main class name there"
    fi
}

# Grep coloring
alias grep="grep --color=auto"
