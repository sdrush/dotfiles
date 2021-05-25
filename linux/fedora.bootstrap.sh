#!/bin/sh
################################################
# Default file name $DOTFILES/linux/fedora.bootstrap.sh
################################################


# First lets install any local packages we need
sudo dnf upgrade -y
sudo dnf install lua5.3 -y
sudo dnf install taskwarrior -y

# Install or update starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
