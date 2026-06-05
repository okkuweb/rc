# Setting up LS for nvim
go install golang.org/x/tools/gopls@latest
npm install -g perlnavigator-server
npm install -g typescript typescript-language-server
go telemetry off

# Optional tools for linux
- `dnf group install "Development Tools"`
- `apt install build-essential`

# Fcitx5 envs
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# SSH agent on atomic distros
Put this in your .bash_local.sh
export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

