#!/bin/bash
# Update repositories
OS=`cat /etc/issue | grep -io "ubuntu\|debian\|centos"`
os=${OS,,}

# Install required bash cli tools
if [ "$os" == "debian" ] || [ "$os" == "ubuntu" ] ; then
    sudo apt-get update && sudo apt-get install curl git vim-gtk tmux tree unp
elif [ "$os" == "centos" ]; then
    sudo yum check-update && sudo yum install curl git vim-gtk tmux tree unp
else
    checkOS=1
fi

if [ $checkOS ]; then
    read -p "Are you using a filthy Windows system? (y/n)" answer
    if [ "$answer" == "y" ]; then
        touch `dirname $0`/windows && echo "1" >> `dirname $0`/windows
        windows=1
    fi
fi

# Install vim dependencies
if [ $windows ]; then
    mkdir -p ~/vimfiles/autoload ~/vimfiles/bundle && \
    curl -LSso ~/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    cd ~/vimfiles/bundle
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    cd ~/.vim/bundle
fi

if [ $windows -ne 1 ]; then
    git clone https://github.com/airblade/vim-gitgutter
    git clone https://github.com/nathanaelkane/vim-indent-guides
fi
git clone https://github.com/tpope/vim-sensible.git
git clone https://github.com/tomasr/molokai
git clone https://github.com/jiangmiao/auto-pairs
git clone https://github.com/tpope/vim-surround
git clone https://github.com/jimsei/winresizer
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/kana/vim-fakeclip
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/airblade/vim-rooter
git clone https://github.com/ctrlpvim/ctrlp.vim
git clone https://github.com/SirVer/ultisnips
git clone https://github.com/honza/vim-snippets
