#! /bin/zsh

# Create our dotfiles directory
mkdir -p $HOME/.dotfiles

# Run our os-specific dependency installations
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $DOTFILES/macos/bootstrap.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $DOTFILES/linux/bootstrap.sh
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
ln -sfn "$HOME/.dotfiles/zplug" "$HOME/.zplug"

# Run a zplug install here so we dont have to wait for it on first login
zplug install
