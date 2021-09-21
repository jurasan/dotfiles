# Create link in home dir
# ln -s .config/dotfiles/zsh/.zshenv ~/.zshenv
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/dotfiles/zsh"
export EDITOR="vim"
export VISUAL="vim"
export ZSH_CACHE_DIR="$XDG_CONFIG_HOME/dotfiles/zsh/cache"
# export ZSH_COMPDUMP="$XDG_CONFIG_HOME/zsh/.zcompdump"
# . "$HOME/.cargo/env"
