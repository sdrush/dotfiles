#! /bin/sh

# Create our dotfiles directory
mkdir -p $HOME/.dotfiles

# Run our os-specific dependency installations
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $DOTFILES/macos/macos.bootstrap.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $DOTFILES/linux/linux.bootstrap.sh
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # I'm not even sure I'm going to do the work for Cygwin.  This is 
  # mostly for historical purposes
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
fi

# Set up all our file symlinks
# ln -sf makes this operation idempotent for files
ln -sf "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/fzf.zsh" "$HOME/.fzf.zsh"
ln -sf "$HOME/.dotfiles/taskrc" "$HOME/.taskrc"
ln -sf "$HOME/.dotfiles/viminfo" "$HOME/.viminfo"
ln -sf "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"

# Set up directory symlinks.
# Have to use ln -sfn for idempotency with directories 
ln -sfn "$HOME/.dotfiles/oh-my-zsh/" "$HOME/.oh-my-zsh"
ln -sfn "$HOME/.dotfiles/vim/" "$HOME/.vim"
