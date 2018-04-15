#!/bin/bash
# Check current folder
location=`dirname $0`
# Link files to appropriate locations
ln -fv $location/bash_aliases.bash ~/.bash_aliases
ln -fv $location/inputrc.bash ~/.inputrc
ln -fv $location/vimrc.vim ~/.vimrc
ln -fv $location/tmux.conf ~/.tmux.conf
ln -fv $location/fbtermrc ~/.fbtermrc
mkdir ~/.w3m
ln -fv $location/w3mkeymap ~/.w3m/keymap
mkdir ~/.config/i3
ln -fv $location/i3config ~/.config/i3/config
mkdir ~/.config/polybar
ln -fv $location/polybarconfig ~/.config/polybar/config
ln -fv $location/polybarlaunch.sh ~/.config/polybar/launch.sh
ln -fv $location/Xresources ~/.Xresources
ln -fv $location/nethackrc ~/.nethackrc

# Add a local vimrc file
touch ~/.vimlocal
touch ~/.tmuxlocal.conf

# Check if source .bash_aliases already present in .bashrc and add it there if not
check=`grep "bash_aliases" ~/.bashrc`
if [ "$check" ]
then
    echo "Source ~/.bash_aliases already present in .bashrc"
else
    echo "Added source ~/.bash_aliases to .bashrc"
    printf "\n# Source bash aliases\nsource ~/.bash_aliases" >> ~/.bashrc
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
