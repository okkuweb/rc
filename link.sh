#!/bin/bash
location=`dirname $0`
ln -f $location/bash_aliases ~/.bash_aliases
ln -f $location/inputrc ~/.inputrc
ln -f $location/init.vim ~/.config/nvim/init.vim

