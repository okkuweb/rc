#!/bin/bash
# Check current folder
location=`dirname $0`
if [ -f $location/windows ]; then
    windows=1
fi

cd $location

# Link files to appropriate locations
if [ "$windows" ]; then
    ln -fv $location/confs/vimrc.vim ~/_vimrc
    touch ~/.vimlocal
    mkdir -p ~/vimfiles/colors
    ln -fv $location/confs/molokai.vim ~/vimfiles/colors
    echo "Filthy windows files updated..."
    exit 1
fi

# Check if bashrc is updated
backupcheck=`grep screen-256color ~/.bashrc`
# And back it up if it hasn't been updated
if [ -z "$backupcheck" ]; then
    cp ~/.bashrc ~/.bashrc.bak
    rm ~/.bash_profile
    echo "MOVE ALL YOUR LOCAL CONFIGURATIONS FROM ~/.bashrc.bak to ~/.bash_local"
fi

# Add .bash_profile for tmux
if [ -f ~/.bash_profile ]; then
    checkprofile=`grep bashrc ~/.bash_profile`
    if [ -z "$checkprofile" ]; then
        echo "source ~/.bashrc" >> ~/.bash_profile
        echo "Added .bash_profile"
    fi
else
    echo "source ~/.bashrc" > ~/.bash_profile
    echo "Added .bash_profile"
fi

mkdir -p ~/.w3m
mkdir -p ~/.vim/colors
ln -sfv `pwd`/confs/bashrc.bash ~/.bashrc
ln -sfv `pwd`/confs/bash_aliases.bash ~/.bash_aliases
ln -sfv `pwd`/confs/inputrc.bash ~/.inputrc
ln -sfv `pwd`/confs/vimrc.vim ~/.vimrc
ln -sfv `pwd`/confs/tmux.conf ~/.tmux.conf
ln -sfv `pwd`/confs/w3mkeymap ~/.w3m/keymap
ln -sfv `pwd`/confs/xnethackrc ~/.xnethackrc
ln -sfv `pwd`/confs/xnethackrc ~/.nethackrc
ln -sfv `pwd`/confs/gnollhackrc ~/.gnollhackrc
ln -sfv `pwd`/confs/molokai.vim ~/.vim/colors
mkdir -p ~/.config/xremap/
ln -sfv `pwd`/confs/xremap.yml ~/.config/xremap/config.yml
mkdir -p ~/.config/nvim
ln -sfv `pwd`/confs/nvimrc.vim ~/.config/nvim/init.vim
ln -sfv `pwd`/confs/nvimrc.vim ~/.nvimrc

# Add a local vimrc file
touch ~/.vimlocal
touch ~/.nvimlocal
touch ~/.tmuxlocal.conf
touch ~/.bash_local

# Add git configurations to system
if [ -f ~/.gitconfig ]; then
    checkContent=`grep "\[user\]" ~/.gitconfig`
    if [ "$checkContent" ]; then
        content=`head -3 ~/.gitconfig`
        cp -f $location/confs/gitconfig.ini ~/.gitconfig
        echo -e "$content\n$(cat ~/.gitconfig)" > ~/.gitconfig
        echo "Updated gitconfig"
    else
        printf "Adding Git configuration\n"
        read -p "First and last name: " name
        read -p "E-mail address: " email
        cp -f $location/confs/gitconfig.ini ~/.gitconfig
        user="[user]\n    name = $name\n    email = $email\n"
        echo -e "$user$(cat ~/.gitconfig)" > ~/.gitconfig
    fi
else
    printf "Adding Git configuration\n"
    read -p "First and last name: " name
    read -p "E-mail address: " email
    cp -f $location/confs/gitconfig.ini ~/.gitconfig
    user="[user]\n    name = $name\n    email = $email\n"
    echo -e "$user$(cat ~/.gitconfig)" > ~/.gitconfig
fi

echo "System files updated!"
