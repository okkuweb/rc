#!/bin/bash
location=`dirname $0`
ln -f $location/bash_aliases.bash ~/.bash_aliases
ln -f $location/inputrc.bash ~/.inputrc
ln -f $location/vimrc.vim ~/.vimrc
ln -f $location/tmux.conf ~/.tmux.conf
ln -f $location/tmux.conf.sh ~/.tmux.conf.sh
echo "source ~/.bash_aliases" >> ~/.bashrc
