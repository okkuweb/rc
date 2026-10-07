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
mkdir -p ~/.local/bin
mkdir -p ~/.config/nvim
mkdir -p ~/.config/xremap/
mkdir -p ~/.config/ghostty/
mkdir -p ~/.config/ghostty-roguelike/ghostty
mkdir -p ~/.config/nvim/after/plugin
mkdir -p ~/.config/dunst
mkdir -p ~/.config/swaylock
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.local/share/fonts
mkdir -p ~/.config/rofi
mkdir -p ~/.config/.ssh
mkdir -p ~/.config/xkb/symbols
mkdir -p ~/.config/xkb/rules
mkdir -p ~/.local/share/applications/
mkdir -p ~/.wallpaper
mkdir -p ~/.config/kanshi
ln -sfv `pwd`/confs/bashrc.sh ~/.bashrc
ln -sfv `pwd`/confs/bash_aliases.sh ~/.bash_aliases.sh
ln -sfv `pwd`/confs/bash/grip.sh ~/.grip.sh
ln -sfv `pwd`/confs/bash/grip_plain.sh ~/.grip_plain.sh
ln -sfv `pwd`/confs/bash/dot_directory_preview.sh ~/.dot_directory_preview.sh
ln -sfv `pwd`/confs/inputrc.bash ~/.inputrc
ln -sfv `pwd`/confs/vimrc.vim ~/.vimrc
ln -sfv `pwd`/confs/tmux.conf ~/.tmux.conf
ln -sfv `pwd`/confs/w3mkeymap ~/.w3m/keymap
ln -sfv `pwd`/confs/molokai.vim ~/.vim/colors
ln -sfv `pwd`/confs/xremap.yml ~/.config/xremap/config.yml
ln -sfv `pwd`/confs/nvimrc.lua ~/.config/nvim/init.lua
ln -sfv `pwd`/confs/nvimrc.lua ~/.nvimrc.lua
ln -sfv `pwd`/confs/config.ghostty ~/.config/ghostty/
ln -sfv `pwd`/confs/tab-style.css ~/.config/ghostty/
ln -sfv `pwd`/confs/tab-style.css ~/.config/ghostty-roguelike/ghostty/
ln -sfv `pwd`/confs/rl-config.ghostty ~/.config/ghostty-roguelike/ghostty/config.ghostty
ln -sfv "$(pwd)/confs/desktop/rl-ghostty.desktop" ~/.local/share/applications/
ln -sfv "$(pwd)/confs/desktop/nvim.desktop" ~/.local/share/applications/
ln -sfv "$(pwd)/confs/desktop/dunst-history.desktop" ~/.local/share/applications/
ln -sfv "$(pwd)/confs/desktop/dunst-history-all.desktop" ~/.local/share/applications/
# Remove links from the previous nested power menu, if installed by this repo.
if [[ -L "$HOME/.local/share/applications/power-menu.desktop" &&
      "$(readlink "$HOME/.local/share/applications/power-menu.desktop")" == "$(pwd)/confs/power-menu.desktop" ]]; then
    rm "$HOME/.local/share/applications/power-menu.desktop"
fi
ln -sfv "$(pwd)/confs/bash/rofi-power.sh" ~/.local/bin/rofi-power
for action in lock sleep hibernate log-out reboot shut-down; do
    ln -sfv "$(pwd)/confs/desktop/rofi-$action.desktop" ~/.local/share/applications/
done
ln -sfv `pwd`/confs/bash/notifications-history.sh ~/.local/bin/notifications-history
ln -sfv `pwd`/confs/bash/notifications-history.sh ~/.local/bin/notification-history-all
ln -sfv `pwd`/confs/nvim/markdown.lua ~/.config/nvim/after/plugin/
ln -sfv `pwd`/confs/nvim/lsp.lua ~/.config/nvim/after/plugin/
ln -sfv `pwd`/confs/dunstrc ~/.config/dunst/
ln -sfv `pwd`/confs/dunstrc ~/.dunstrc
ln -sfv `pwd`/confs/swaylock ~/.config/swaylock/config
ln -sfv `pwd`/confs/sway ~/.config/sway/config
ln -sfv `pwd`/confs/sway ~/.sway
touch ~/.config/sway/sway-local
ln -sfv ~/.config/sway/sway-local ~/.sway-local
ln -sfv `pwd`/confs/waybar.jsonc ~/.config/waybar/config.jsonc
ln -sfv `pwd`/confs/waybar.jsonc ~/.waybar.jsonc
ln -sfv `pwd`/confs/waybar.css ~/.config/waybar/style.css
ln -sfv `pwd`/confs/waybar.css ~/.waybar.css
cp -fv  --update `pwd`/confs/fonts/* ~/.local/share/fonts/
ln -sfv `pwd`/confs/rofi.rasi ~/.config/rofi/config.rasi

# Use the evdev rules for the active desktop environment, when recognized.
case ":${XDG_CURRENT_DESKTOP,,}:" in
    *:kde:*)
        ln -sfv "$(pwd)/confs/evdev.kde.xml" ~/.config/xkb/rules/evdev.xml
        ln -sfv "$(pwd)/confs/us_fi.kde.layout" ~/.config/xkb/symbols/us
        ;;
    *:sway:*)
        ln -sfv "$(pwd)/confs/evdev.sway.xml" ~/.config/xkb/rules/evdev.xml
        ln -sfv "$(pwd)/confs/us_fi.sway.layout" ~/.config/xkb/symbols/us_fi
        ;;
esac

ln -sfv `pwd`/confs/bash/update.sh ~/update.sh
ln -sfv `pwd`/confs/audio-volume-change.oga ~/.config/waybar/
ln -sfv `pwd`/confs/kanshi.config ~/.config/kanshi/config
ln -sfv `pwd`/confs/bash/sway-toggle-terminal ~/.config/sway/

if [[ ! -f "$HOME/.ssh/config" ]]; then
    cp -fv `pwd`/confs/sshbase.conf ~/.ssh/config
fi

if [[ -f "$HOME/.gitskip" ]]; then
    if [[ -f "$HOME/.gitconfig" ]]; then
        echo "Skipping gitconfig link"
    else
        cp -v "$(pwd)/confs/gitconfig.ini" "$HOME/.gitconfig"
    fi
else
    ln -sfv "$(pwd)/confs/gitconfig.ini" "$HOME/.gitconfig"
fi

touch ~/.gitignore_global

# Add a local vimrc file
touch ~/.vimlocal.vim
touch ~/.nvimlocal.lua
touch ~/.tmuxlocal.conf
touch ~/.bash_local.sh

echo "System files updated!"
