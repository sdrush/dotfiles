#!/bin/sh
################################################
# Default file name $DOTFILES/linux/bootstrap.sh
################################################

# Install pacapt - a wrapper for the various distro-specific package managers
sudo wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
sudo chmod 755 /usr/local/bin/pacapt
sudo ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true

# Install our packaged dependencies
export DEBIAN_FRONTEND=noninteractive
sudo pacman -Syu
sudo pacman --noconfirm -S lua5.3 \
    taskwarrior \
    zplug \
    direnv \
    sqlite3 \
    fzf \
    fonts-powerline

# Clean up some permissions issues with zplug on debian
if [[ -d "/usr/share/zplug" ]]; then
    sudo chmod 775 /usr/share/zplug
    sudo chown root:$USER /usr/share/zplug
fi

# Install krew
# leaving this in the linux bootstrap for now because I dont have
# time to test on macos.
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# Install or update starship
sudo wget -O /tmp/starship-install.sh https://starship.rs/install.sh
sudo chmod 755 /tmp/starship-install.sh
/tmp/starship-install.sh -f
sudo rm -f /tmp/starship-install.sh
