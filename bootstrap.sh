#! /bin/sh

# Create our dotfiles directory
mkdir -p $HOME/.dotfiles

# Set up all our file symlinks
ln -sf "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/fzf.zsh" "$HOME/.fzf.zsh"
ln -sf "$HOME/.dotfiles/taskrc" "$HOME/.taskrc"
ln -sf "$HOME/.dotfiles/viminfo" "$HOME/.viminfo"
ln -sf "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"

# Set up directory symlinks.
ln -sfn "$HOME/.dotfiles/oh-my-zsh/" "$HOME/.oh-my-zsh"
ln -sfn "$HOME/.dotfiles/vim/" "$HOME/.vim"
