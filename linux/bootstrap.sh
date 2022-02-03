#!/bin/sh
################################################
# Default file name $DOTFILES/linux/bootstrap.sh
################################################

# Install pacapt - a wrapper for the various distro-specific package managers
sudo wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
sudo chmod 755 /usr/local/bin/pacapt
sudo ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true

# Install our packaged dependencies
sudo pacman update
sudo pacman upgrade
sudo pacman install -y \
    lua5.3 \
    taskwarrior \
    zplug

# Install or update starship
#sh -c "$(curl -fsSL https://starship.rs/install.sh) -f"
sudo wget -O /tmp/starship-install.sh https://starship.rs/install.sh
sudo chmod 755 /tmp/starship-install.sh
/tmp/starship-install.sh -f
sudo rm -f /tmp/starship-install.sh
