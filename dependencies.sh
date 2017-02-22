#!/bin/bash
# Update repositories
OS=`python -mplatform | grep -io "ubuntu\|debian\|centos"`
os=${OS,,}

# Install required bash cli tools
if [ "$os" == "debian" ] || [ "$os" == "ubuntu" ] ; then
    sudo apt-get update && sudo apt-get install curl git vim tmux
elif [ "$os" == "centos" ]; then
    sudo yum check-update && sudo yum install curl git vim tmux
fi

# Install pathogen package manager for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Download vim plugins
cd ~/.vim/bundle
git clone https://github.com/tpope/vim-sensible.git
git clone https://github.com/tomasr/molokai
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/jiangmiao/auto-pairs
git clone https://github.com/nathanaelkane/vim-indent-guides
git clone https://github.com/tpope/vim-surround

# Download tmux plugins
mkdir -p ~/.tmux && cd ~/.tmux
git clone https://github.com/tmux-plugins/tmux-resurrect

