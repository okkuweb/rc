# Sway on Ubuntu 26.04

## Install

```bash
sudo add-apt-repository universe
sudo apt update
sudo apt install \
    sway swayidle swaylock waybar \
    ghostty rofi thunar dunst jq \
    brightnessctl playerctl pavucontrol pulseaudio-utils \
    lxqt-policykit xdg-desktop-portal-wlr \
    autotiling fcitx5-mozc flatpak
```

`swaybg` and `xdg-desktop-portal` are installed as dependencies. Ubuntu already
provides the remaining general desktop-portal components.

## Install Flatpaks

```bash
flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.mozilla.firefox org.flameshot.Flameshot
```

## Fix Ubuntu-specific Sway commands

- Remove the `/usr/libexec/sway-systemd/*` commands.
- Replace `/usr/libexec/lxqt-policykit-agent` with `lxqt-policykit-agent`.
- Replace `/usr/libexec/sway/volume-helper` with direct `pactl` commands.
- Import the Sway environment and start Ubuntu's generic XDG autostart target:

```text
exec dbus-update-activation-environment --systemd \
    WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
exec systemctl --user start xdg-desktop-autostart.target
exec lxqt-policykit-agent
exec dunst
```

## Configure portals

Create `~/.config/xdg-desktop-portal/sway-portals.conf`:

```ini
[preferred]
default=gnome
org.freedesktop.impl.portal.Screenshot=wlr
org.freedesktop.impl.portal.ScreenCast=wlr
```

## Install configs and assets

- Run `link.sh` to link the Sway, Waybar, Swaylock, Dunst, Rofi, and font configs.
- Point Sway at `confs/wallpaper.jpg`.
- Point Swaylock at `confs/lock.jpg`.
- Remove or repair the two Keymapper startup commands; the referenced build and
  `confs/keymapper.conf` are currently missing.

## Validate

```bash
sway -C -c ~/.config/sway/config
```

Log out, select **Sway** in GDM, and log back in.
