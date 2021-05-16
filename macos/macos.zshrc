################################################
# MacOS Specific zshrc file
################################################

# ZPlug Local Modules
zplug "${HOME}", from:local, use:"${DOTFILES}/macos/iterm2_shell_integration.zsh"

# MacOS Specific Oh-my-zsh Plugins
zplug "plugins/iterm", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh