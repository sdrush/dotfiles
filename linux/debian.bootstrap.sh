################################################
# Default file name $DOTFILES/linux/debian.bootstrap.sh
################################################


# First lets install any local packages we need
sudo apt-get upgrade -y
sudo apt-get install lua5.3 -y
sudo apt-get install task -y

# Install or update starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"