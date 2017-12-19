#!/bin/bash
# Update repositories
OS=`cat /etc/issue | grep -io "ubuntu\|debian\|centos"`
os=${OS,,}

# Install required bash cli tools
if [ "$os" == "debian" ] || [ "$os" == "ubuntu" ] ; then
    sudo apt-get update && sudo apt-get install curl git vim tmux python-pip
elif [ "$os" == "centos" ]; then
    sudo yum check-update && sudo yum install curl git vim tmux python-pip
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
git clone https://github.com/jimsei/winresizer
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/kana/vim-fakeclip

# Install tmuxp
pip install --user tmuxp
