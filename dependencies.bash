# To be able to use add-apt-repository you may need to install software-properties-common
sudo apt-get install software-properties-common

# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# Prerequisites for the Python modules
sudo apt-get install python-dev python-pip python3-dev python3-pip

# If that isn't enough do this
pip3 install neovim
# Run this whenever something breaks or big updates come up
pip3 install --upgrade neovim
# If deoplete or something doesn't work yet do this in neovim
:UpdateRemotePlugins

# To install Vim Plug use this
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
