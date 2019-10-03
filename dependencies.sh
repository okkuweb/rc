#!/bin/bash
# Update repositories
OS=`cat /etc/issue | grep -io "ubuntu\|debian\|centos\|mint"`
os=${OS,,}

# Install required bash cli tools
if ping -c 1 github.com &> /dev/null; then
    if [ "$os" == "debian" ] || [ "$os" == "ubuntu" ] || [ "$os" == "mint" ] ; then
        sudo apt update && sudo apt install htop curl git vim-gtk tmux tree bash-completion
    elif [ "$os" == "centos" ]; then
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
            touch `dirname $0`/windows && echo "1" >> `dirname $0`/windows
            windows=1
        fi
    fi
fi

# Install vim dependencies
if [ "$windows" ]; then
    mkdir -p ~/vimfiles/autoload ~/vimfiles/bundle && \
    curl -LSso ~/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    if [ -z "$windows" ]; then
        cp -rfv `dirname $0`/opt_deps/* ~/.vim/bundle
    fi
    cp -rfv `dirname $0`/deps/* ~/.vim/bundle
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    if [ -z "$windows" ]; then
        cp -rfv `dirname $0`/opt_deps/* ~/.vim/bundle
    fi
    cp -rfv `dirname $0`/deps/* ~/.vim/bundle
fi

