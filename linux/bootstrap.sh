#!/bin/sh
################################################
# Default file name $DOTFILES/linux/bootstrap.sh
################################################

# Install pacapt - a wrapper for the various distro-specific package managers
sudo wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
sudo chmod 755 /usr/local/bin/pacapt
sudo ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true

# Install our packaged dependencies
sudo pacman -Syu
sudo pacman -S lua5.3
sudo pacman -S taskwarrior
sudo pacman -S zplug
sudo pacman -S direnv
sudo pacman -S sqlite3
sudo pacman -S fzf
sudo pacman -S fonts-powerline

# Clean up some permissions issues with zplug on debian
if [[ -f "/usr/share/zplug" ]]; then
    sudo chmod 775 /usr/share/zplug
    sudo chown root:$USER /usr/share/zplug
fi

# Install or update starship
sudo wget -O /tmp/starship-install.sh https://starship.rs/install.sh
sudo chmod 755 /tmp/starship-install.sh
/tmp/starship-install.sh -f
sudo rm -f /tmp/starship-install.sh
