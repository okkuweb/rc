#!/bin/bash
# Update repositories
location=`dirname $0`
apt=`which apt`
yum=`which yum`

# Install required bash cli tools
if [ "$apt" ]; then
    sudo apt update && sudo apt install htop curl git vim tmux tree bash-completion
elif [ "$yum" ]; then
    sudo yum check-update && sudo yum install htop curl git vim tmux tree bash-completion
else
    checkOS=1
fi

# Install vim dependencies
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

