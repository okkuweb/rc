#!/bin/bash
# Update repositories
sudo yum check-update

# Install required bash cli tools
sudo yum install curl git vim tmux

# Install pathogen package manager for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Download vim plugins
cd ~/.vim/bundle
git clone https://github.com/tomasr/molokai
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/jiangmiao/auto-pairs
git clone https://github.com/nathanaelkane/vim-indent-guides

# Download tmux plugins
mkdir -p ~/.tmux && cd ~/.tmux
git clone https://github.com/tmux-plugins/tmux-resurrect

