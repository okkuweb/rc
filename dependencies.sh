#!/bin/bash
# Update repositories
location=`dirname $0`
apt=`which apt`
yum=`which yum`

# Install required bash cli tools
read -p "Are you operating in an online environment? (y/n)`echo $'\n> '`" answer
if [ "$answer" == "y" ]; then
    if [ "$apt" ]; then
        sudo apt update && sudo apt install htop curl git vim-gtk tmux tree bash-completion
    elif [ "$yum" ]; then
        sudo yum check-update && sudo yum install htop curl git vim-gtk tmux tree bash-completion
    else
        checkOS=1
    fi
else
    echo Install needed linux dependencies manually from deps/linux_deps.\n
fi

if [ "$checkOS" ]; then
    if [ "`cat $location/windows`" ]; then
        windows=1
    else
        read -p "Are you using a filthy Windows system (and git bash)? (y/n)`echo $'\n> '`" answer
        if [ "$answer" == "y" ]; then
            touch "$location/windows" && echo "1" >> $location/windows
            windows=1
        fi
    fi
fi

# Install vim dependencies
if [ "$windows" ]; then
    mkdir -p ~/vimfiles/autoload ~/vimfiles/bundle && \
    ln -fv $location/confs/prop/pathogen.vim ~/vimfiles/autoload/pathogen.vim
    cp -rfv $location/deps/vim/* ~/vimfiles/bundle
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    ln -fv $location/confs/prop/pathogen.vim ~/.vim/autoload/pathogen.vim
    cp -rfv $location/deps/vim_opt/* ~/.vim/bundle
    cp -rfv $location/deps/vim/* ~/.vim/bundle
fi

