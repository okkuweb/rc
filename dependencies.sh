#!/bin/bash
# Update repositories
apt=`which apt`
dnf=`which dnf`
apt_list="htop curl git vim tmux tree bash-completion ripgrep fd-find tar zip wget jq unzip fzf bat"
dnf_list="htop curl git vim tmux tree bash-completion epel-release ripgrep fd-find tar zip wget jq unzip fzf bat"

# Install required bash cli tools
if [ "$apt" ]; then
    sudo apt update && sudo apt install ${apt_list}
elif [ "$dnf" ]; then
    sudo dnf check-update && sudo dnf install ${dnf_list}
fi

# Install vim dependencies
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

