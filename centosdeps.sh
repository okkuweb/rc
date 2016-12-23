#!/bin/bash
# Update repositories
sudo yum check-update

# Install required bash cli tools
sudo yum install curl git vim tmux

# Install pathogen package manager for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Download molokai colorscheme for vim
cd ~/.vim/bundle
git clone https://github.com/tomasr/molokai
