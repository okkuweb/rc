# Setting up LS for nvim
go install -v golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
npm install -g perlnavigator-server
:CocInstall coc-perl
:CocInstall coc-go

# Linux Tips and Tricks
## NetHack compilation
1. Change `PREFIX` in `linux.370` or equivalent hints file to match the installation dir of choice (e.g. `PREFIX=$(wildcard ~)/.local`)
2. Run `sh sys/unix/setup.sh sys/unix/hints/linux.370`
3. In config.h file uncomment `define CURSES_GRAPHICS`
### For NetHack
4. In Makefile file uncomment `WANT_WIN_TTY`, `WANT_WIN_CURSES=1` and `WANT_DEFAULT=curses` lines
5. Compile with `make WANT_WIN_TTY=1 WANT_WIN_CURSES=1 all`
6. Install with `make install`
### For GnollHack
4. In files.c file remove the unnecessary WARNING line for LIVELOG
5. Compile with `make all`
6. Install with `make install`
