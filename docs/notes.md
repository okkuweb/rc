# To-Do
- Why do I have to add sleep to some exec configuration commands for them to work
- Put a maximum value to the volume change thing
- Stop screen from shutting down if fullscreen video is on
- Maybe do something about the spinner when doing anything in i3?
- Clean all the weird errors in tty1 and elsewhere on boot etc.
- Make an ssh key for git and bitbucket
- Change dmenu colors (that blue is awful?)
- Maybe install some sorta checkinstall kinda deal so I can install binaries like pico-8 (this might not do... only works for compiled software?) (Maybe makepkg does the job?)
- xf86-video-intel drivers are active!!!!!! Might cause input lag and other issues. Should use better drivers...

# Notes

# Installed software
i3lock-color (with i3lock-fancy theme)
xfce4-power-manager
redshift
pulseaudio
nitrogen (wallpaper)
lightdm-webkit2-greeter (with Aether theme)
sxiv (image viewer)
polybar
tlp (works by default after install I guess)
lxappearance
pavucontrol for some audio stuff I guess :|
pulseaudio-alsa?
synaptics thing I don't remember
networkmanager
trizen
network-manager-applet
qt5-styleplugins
udisks2
udiskie
dunst
onboard
compton
xsel (for clipboard management)

# Tweaks
Add MOZ_USE_XINPUT2=1 to /etc/environment
Added polybar config to ~/.config/polybar/config
Added i3lock.service to /etc/systemd/system for lock on suspend (enabled with systemctl enable i3lock)
Added /usr/local/bin cdda startup script
/etc/X11/xorg.conf.d/40-libinput.conf added for touchpad

