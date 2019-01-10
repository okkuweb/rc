#!/bin/bash
# Check current folder
location=`dirname $0`
if [ -f $location/windows ]; then
    windows=1
fi

# Check if bashrc is updated
backupcheck=`grep screen-256color`
# And back it up if it hasn't been updated
if [ "$backupcheck" -eq "0" ]; then
    cp ~/.bashrc ~/.bashrc.bak
    rm ~/.bash_profile
    echo "MOVE ALL YOUR LOCAL CONFIGURATIONS FROM ~/.bashrc.bak to ~/.bash_local"
fi

# Link files to appropriate locations
if [ $windows ]; then
    ln -fv $location/vimrc.vim ~/_vimrc
    touch ~/.vimlocal
    mkdir ~/vimfiles/colors
    ln -fv $location/molokai.vim ~/vimfiles/colors
    echo "Filthy windows files updated..."
    exit 1
fi

ln -fv $location/bashrc.bash ~/.bashrc
ln -fv $location/bash_aliases.bash ~/.bash_aliases
ln -fv $location/inputrc.bash ~/.inputrc
ln -fv $location/vimrc.vim ~/.vimrc
ln -fv $location/tmux.conf ~/.tmux.conf
ln -fv $location/fbtermrc ~/.fbtermrc
mkdir ~/.w3m
ln -fv $location/w3mkeymap ~/.w3m/keymap
ln -fv $location/nethackrc ~/.nethackrc
mkdir ~/.vim/colors
ln -fv $location/molokai.vim ~/.vim/colors

# Add a local vimrc file
touch ~/.vimlocal
touch ~/.tmuxlocal.conf
touch ~/.bash_local

# Check if source .bash_aliases already present in .bashrc and add it there if not
check=`grep "bash_aliases" ~/.bashrc`
if [ "$check" ]
then
    echo "REMOVE 'source ~/.bash_aliases' FROM YOUR BASHRC PLEASE! (caps so you see this)"
fi

# Add git configurations to system
if [ -f ~/.gitconfig ]; then
    checkContent=`grep "\[user\]" ~/.gitconfig`
    if [ "$checkContent" ]; then
        content=`head -3 ~/.gitconfig`
        cp -f $location/gitconfig.ini ~/.gitconfig
        echo -e "$content\n$(cat ~/.gitconfig)" > ~/.gitconfig
        echo "Updated gitconfig"
    else
        printf "Adding Git configuration\n"
        read -p "First and last name: " name
        read -p "E-mail address: " email
        cp -f $location/gitconfig.ini ~/.gitconfig
        user="[user]\n    name = $name\n    email = $email\n"
        echo -e "$user$(cat ~/.gitconfig)" > ~/.gitconfig
    fi
else
    printf "Adding Git configuration\n"
    read -p "First and last name: " name
    read -p "E-mail address: " email
    cp -f $location/gitconfig.ini ~/.gitconfig
    user="[user]\n    name = $name\n    email = $email\n"
    echo -e "$user$(cat ~/.gitconfig)" > ~/.gitconfig
fi

echo "System files updated!"
