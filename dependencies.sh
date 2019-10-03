#!/bin/bash
# Update repositories
location=`dirname $0`
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
            touch "$location/windows" && echo "1" >> $location/windows
            windows=1
        fi
    fi
fi

# Install vim dependencies
if [ "$windows" ]; then
    mkdir -p ~/vimfiles/autoload ~/vimfiles/bundle && \
    ln -fv $location/confs/prop/pathogen.vim ~/vimfiles/autoload/pathogen.vim
    cp -rfv $location/deps/vim_deps/* ~/vimfiles/bundle
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    ln -fv $location/confs/prop/pathogen.vim ~/.vim/autoload/pathogen.vim
    cp -rfv $location/opt_deps/vim_opt_deps/* ~/.vim/bundle
    cp -rfv $location/deps/vim_deps/* ~/.vim/bundle
fi

