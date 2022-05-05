# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc
. $HOME/dotfiles/zsh/profiler.start


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# Load all of the config files in ~/oh-my-zsh that end in .zsh
#for config_file ($ZSH/lib/*.zsh) source $config_file


# Extend Autocomplete Search Path
fpath=($HOME/.zsh/lib/completions $fpath)


export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH

export EDITOR="code"
export BUNDLER_EDITOR=$EDITOR
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export SOURCE_ANNOTATION_DIRECTORIES="spec"
export DISABLE_AUTO_TITLE=true
export _Z_OWNER=$USER
export ZSH_DISABLE_COMPFIX=true
export RUBY_CONFIGURE_OPTS="--with-opt-dir=/usr/local/opt/openssl:/usr/local/opt/readline:/usr/local/opt/libyaml:/usr/local/opt/gdbm"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOTFILES="$HOME/dotfiles"
HOST_NAME=$(scutil --get HostName)
export HOST_NAME

export ZSH_THEME="powerlevel10k/powerlevel10k"

. $DOTFILES/zsh/oh-my-zsh
. $DOTFILES/zsh/opts
. $DOTFILES/zsh/aliases
. $DOTFILES/zsh/prompt
. $DOTFILES/zsh/tmux
. $DOTFILES/zsh/functions
. $DOTFILES/zsh/z.sh
. $DOTFILES/zsh/history.zsh
. $DOTFILES/zsh/ranger.sh

cdpath=($HOME/code $DOTFILES $HOME/Developer $HOME/Sites $HOME/Dropbox $HOME)

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"


# Load and run compinit
autoload -U compinit
compinit -i


# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Use vi mode
bindkey -v

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Easier, more vim-like editor opening
bindkey -M vicmd v edit-command-line

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Travis CI
[ -f ~/.travis/travis.sh ] && . ~/.travis/travis.sh

# Include local settings
[[ -f ~/.zshrc.local ]] && . ~/.zshrc.local
. $HOME/dotfiles/zsh/profiler.stop
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

source /Users/moellinger/.config/broot/launcher/bash/br

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
