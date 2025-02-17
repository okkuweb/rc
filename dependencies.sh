#!/bin/bash
# Update repositories
location=`dirname $0`
apt=`which apt`
yum=`which yum`

# Install required bash cli tools
if [ "$apt" ]; then
    sudo apt update && sudo apt install htop curl git vim-gtk tmux tree bash-completion
elif [ "$yum" ]; then
    sudo yum check-update && sudo yum install htop curl git vim-gtk tmux tree bash-completion
else
    checkOS=1
fi

# Install vim dependencies
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
ln -fv $location/confs/prop/pathogen.vim ~/.vim/autoload/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/tpope/vim-surround
git clone https://github.com/tpope/vim-repeat
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/jiangmiao/auto-pairs
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/tpope/vim-sensible
cd -

