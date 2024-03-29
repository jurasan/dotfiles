# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# setopt appendhistory autocd beep extendedglob nomatch notify

# # End of lines configured by zsh-newuser-install


# # VI mode
# bindkey -v
# export KEYTIMEOUT=1
# # The following lines were added by compinstall
# zstyle :compinstall filename "$ZDOTDIR/.zshrc"

# autoload -Uz compinit
# compinit
# # End of lines added by compinstall
# _comp_options+=(globdots)

# #==================================================================================


# https://thevaluable.dev/zsh-install-configure/
source "$ZDOTDIR/.zshaliaces"

# #https://dev.to/lukeojones/1up-your-zsh-abilities-by-autoloading-your-own-functions-2ngp
# #autoload all files in directory
# fpath=( "$ZDOTDIR/.zshfn" "${fpath[@]}" )
# autoload -Uz $fpath[1]/*(.:t)

# # https://github.com/Phantas0s/.dotfiles/blob/master/zsh/plugins/completion.zsh
# _comp_options+=(globdots) # With hidden files
# completion.zsh


# # Directory stack
# # https://thevaluable.dev/zsh-install-configure/
# setopt AUTO_PUSHD
# setopt PUSHD_IGNORE_DUPS
# setopt PUSHD_SILENT
# alias d='dirs -v'
# for index ({1..9}) alias "$index"="cd +${index}"; unset index


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# Include hidden files.

# https://github.com/wting/autojump#automatic
. /usr/share/autojump/autojump.sh

# Vi Mode
# https://thevaluable.dev/zsh-install-configure/
bindkey -v
export KEYTIMEOUT=1
# cursor_mode.zsh
# vim mapping
# zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line




# # edit command lines in vim
# export VISUAL=vim
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# # bd https://github.com/Tarrasch/zsh-bd
# bd.zsh


# GCLOUD
## The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/share/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/share/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/usr/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/share/google-cloud-sdk/completion.zsh.inc'; fi


# OnDir
if [ $commands[ondir] ]; then
  eval_ondir() {
    eval "`ondir \"$OLDPWD\" \"$PWD\"`"
  }
  chpwd_functions=( eval_ondir $chpwd_functions )
fi

if [ $commands[ondir] ]; then
  eval "$(direnv hook zsh)"
fi

# # prompt - https://github.com/Phantas0s/purification/blob/master/prompt_purification_setup
# # requires Font Awesome - sudo apt-get install -y fonts-font-awesome
# prompt.zsh

# DirEnv
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# KUBECTL
source "$ZDOTDIR/.zshplugins/kubectl.plugin.zsh"
## https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
source <(kubectl completion zsh | sed s/kubectl/k/g)



# # TERRAFORM
# complete -o nospace -C /usr/local/bin/terraform terraform

# # To customize prompt, run `p10k configure` or edit ~/.config/dotfiles/zsh/.p10k.zsh.
# [[ ! -f ~/.config/dotfiles/zsh/.p10k.zsh ]] || source ~/.config/dotfiles/zsh/.p10k.zsh

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.config/dotfiles/zsh/.p10k.zsh ]] || source ~/.config/dotfiles/zsh/.p10k.zsh


# MY CONFIG
## gcloud project
prompt_gcloud_project(){
    project=$(gcloud config get-value core/project 2> /dev/null)
    if [[ $project =~ .*production.*$ ]]; then
      color=red
      icon=🌩️
    else
      color=yellow
      icon=☁️
    fi

    if [[ ! -z "$project" ]]; then
      p10k segment -t " $project" -f $color -i $icon
    fi


}

prompt_kubernetes_cluster(){
    color=white
    icon=⚕️
    cluster=""
    context=$(kubectl config current-context 2> /dev/null)
    if [[ ! -z "$context" ]]; then
      if [[ $context =~ ^gke_sixfold[^_]*_[^_]*_(.*)$ ]]; then
        cluster="$match[1]"
      else
    	  cluster="$context"
      fi
    fi
    if [[ ! -z "$cluster" ]]; then
      p10k segment -t " $cluster" -f $color -i $icon
    else
      p10k segment -t ""
    fi
}

# yarn
export PATH="$(yarn global bin):~/.config/yarn/global/node_modules:$PATH"

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source $XDG_CONFIG_HOME/zshplugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
source $XDG_CONFIG_HOME/zshplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


