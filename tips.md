# Linux Tips and Tricks
## Building Nethack
1. Change `PREFIX` in `linux.370` or equivalent to match the installation dir of choice (e.g. `PREFIX=$(wildcard ~)/.local`)
2. Run `sh sys/unix/setup.sh sys/unix/hints/linux.370`
3. In config.h file uncomment `define CURSES_GRAPHICS`
4. In Makefile file uncomment `WANT_WIN_TTY`, `WANT_WIN_CURSES=1` and `WANT_DEFAULT=curses` lines
5. Compile with `make WANT_WIN_TTY=1 WANT_WIN_CURSES=1 all`
6. Install with `make install`
