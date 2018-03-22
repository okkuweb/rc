# To-Do
- Why do I have to add sleep to some exec configuration commands for them to work
- The two-finger scrolling speed should a bit faster
- Take the horrible animation from the login accept button hover
- Change icon theme
- Install touchegg and make it click on tap? (this is for pico-8)
- Try to configure polybar so that the changing numbers don't move the other applets/icons
- Put a maximum value to the volume change thing
- Shutdown -h now or poweroff
- Put a minimum value on brightness as well so that the screen can't be fully dark
- Stop screen from shutting down if fullscreen video is on
- Install ntp so that suspend doesn't break clock

# Notes

# Installed software
i3lock-color (with i3lock-fancy theme)
xfce4-power-manager
redshift
pulseaudio
nitrogen (wallpaper)
lightdm-webkit2-greeter (with Aether theme)
feh (image viewer)
polybar
tlp (works by default after install I guess)

# Tweaks
Add MOZ_USE_XINPUT2=1 to /etc/environment
Added polybar config to ~/.config/polybar/config
Added i3lock.service to /etc/systemd/system for lock on suspend (enabled with systemctl enable i3lock)
Added brogue.desktop to /usr/share/applications Move elsewhere

