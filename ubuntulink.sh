#!/bin/bash
# Check current folder
location=`dirname $0`
# Link files to appropriate locations
ln -f $location/bash_aliases.bash ~/.bash_aliases
ln -f $location/inputrc.bash ~/.inputrc
ln -f $location/vimrc.vim ~/.vimrc
ln -f $location/tmux.conf ~/.tmux.conf

# Check if source .bash_aliases already present in .bashrc and add it there if not
check=`grep "source ~/.bash_aliases" ~/.bashrc`
if [ "$check" ]
then
    echo "Source ~/.bash_aliases already present in .bashrc"
    exit
else
    echo "Added source ~/.bash_aliases to .bashrc"
    printf "\n# Source bash aliases\nsource ~/.bash_aliases" >> ~/.bashrc
fi
