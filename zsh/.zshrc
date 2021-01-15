# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

#==================================================================================


# https://thevaluable.dev/zsh-install-configure/
source "$ZDOTDIR/.zshaliaces"

#https://dev.to/lukeojones/1up-your-zsh-abilities-by-autoloading-your-own-functions-2ngp
#autoload all files in directory
fpath=( "$ZDOTDIR/.zshfn" "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# prompt - https://github.com/Phantas0s/purification/blob/master/prompt_purification_setup
# requires Font Awesome - sudo apt-get install -y fonts-font-awesome
prompt.zsh

# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/plugins/completion.zsh
_comp_options+=(globdots) # With hidden files
completion.zsh


# Directory stack
# https://thevaluable.dev/zsh-install-configure/
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# Vi Mode
# https://thevaluable.dev/zsh-install-configure/
bindkey -v
export KEYTIMEOUT=1
# https://thevaluable.dev/zsh-install-configure/
cursor_mode.zsh
# vim mapping
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# edit command lines in vim
export VISUAL=vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

