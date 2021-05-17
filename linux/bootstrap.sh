################################################
# Default file name $DOTFILES/linux/bootstrap.sh
################################################

# First let's sort out what distro we are running on
distro=`cat /etc/*-release | awk -F= '/^ID=/ {gsub(/"/, ""); print $2}'`

# Source our OS-specific files here
if [[ "$distro" == "debian" ]]; then
  source $DOTFILES/linux/debian.bootstrap.sh
elif [[ "$distro" == "centos" ]]; then
  source $DOTFILES/linux/centos.bootstrap.sh
[[ "$distro" == "fedora" ]]; then
  source $DOTFILES/linux/fedora.bootstrap.sh 
fi