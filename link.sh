#!/bin/bash

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
ln -sfv `pwd`/confs/bashrc.sh ~/.bashrc
ln -sfv `pwd`/confs/bash_aliases.sh ~/.bash_aliases.sh
ln -sfv `pwd`/confs/inputrc.bash ~/.inputrc
ln -sfv `pwd`/confs/vimrc.vim ~/.vimrc
ln -sfv `pwd`/confs/tmux.conf ~/.tmux.conf
ln -sfv `pwd`/confs/w3mkeymap ~/.w3m/keymap
ln -sfv `pwd`/confs/molokai.vim ~/.vim/colors
mkdir -p ~/.config/xremap/
ln -sfv `pwd`/confs/xremap.yml ~/.config/xremap/config.yml
mkdir -p ~/.config/nvim
ln -sfv `pwd`/confs/nvimrc.lua ~/.config/nvim/init.lua
ln -sfv `pwd`/confs/nvimrc.lua ~/.nvimrc.lua
mkdir -p ~/.config/ghostty/
ln -sfv `pwd`/confs/config.ghostty ~/.config/ghostty/
ln -sfv `pwd`/confs/tab-style.css ~/.config/ghostty/
mkdir -p ~/.config/nvim/after/plugin
ln -sfv `pwd`/confs/nvim/markdown.lua ~/.config/nvim/after/plugin/
ln -sfv `pwd`/confs/nvim/lsp.lua ~/.config/nvim/after/plugin/
mkdir -p ~/.config/dunst
ln -sfv `pwd`/confs/dunstrc ~/.config/dunst/
ln -sfv `pwd`/confs/dunstrc ~/.dunstrc
mkdir -p ~/.config/swaylock
ln -sfv `pwd`/confs/swaylock ~/.config/swaylock/config
mkdir -p ~/.config/sway
ln -sfv `pwd`/confs/sway ~/.config/sway/config
ln -sfv `pwd`/confs/sway ~/.sway
touch ~/.config/sway/sway-local
ln -sfv `pwd`/confs/sway-local ~/.sway-local
mkdir -p ~/.config/waybar
ln -sfv `pwd`/confs/waybar.jsonc ~/.config/waybar/config.jsonc
ln -sfv `pwd`/confs/waybar.jsonc ~/.waybar.jsonc
ln -sfv `pwd`/confs/waybar.css ~/.config/waybar/style.css
ln -sfv `pwd`/confs/waybar.css ~/.waybar.css
mkdir -p ~/.local/share/fonts
ln -sfv `pwd`/confs/fonts/* ~/.local/share/fonts/

if [[ -f "$HOME/.gitskip" ]]; then
    if [[ -f "$HOME/.gitconfig" ]]; then
        echo "Skipping gitconfig link"
    else
        cp -v "$(pwd)/confs/gitconfig.ini" "$HOME/.gitconfig"
    fi
else
    ln -sfv "$(pwd)/confs/gitconfig.ini" "$HOME/.gitconfig"
fi

# Add a local vimrc file
touch ~/.vimlocal.vim
touch ~/.nvimlocal.lua
touch ~/.tmuxlocal.conf
touch ~/.bash_local.sh

echo "System files updated!"
