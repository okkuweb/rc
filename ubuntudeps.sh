# Update repositories
sudo apt-get update

# Install required bash cli tools
sudo apt-get install curl git xclip vim tmux unp

# Install pathogen package manager for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
