set fish_greeting

# PATH
set -x PATH '/usr/local/sbin' $PATH
set -x PATH '/usr/local/bin' $PATH
set -x PATH "$HOME/.cargo/bin" $PATH
set -x PATH "$HOME/bin" $PATH

# Environment variables - https://fishshell.com/docs/current/commands.html#set
set -xg EDITOR 'nvim'
set -xg BUNDLER_EDITOR $EDITOR
set -xg MANPAGER 'less -X' # Don’t clear the screen after quitting a manual page
set -xg HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -xg SOURCE_ANNOTATION_DIRECTORIES 'spec'
set -xg RUBY_CONFIGURE_OPTS '--with-opt-dir=/usr/local/opt/openssl:/usr/local/opt/readline:/usr/local/opt/libyaml:/usr/local/opt/gdbm'
set -xg XDG_CONFIG_HOME "$HOME/.config"
set -xg XDG_DATA_HOME "$HOME/.local/share"
set -xg XDG_CACHE_HOME "$HOME/.cache"
set -xg DOTFILES "$HOME/dotfiles"
set -xg FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -xg HOST_NAME (scutil --get HostName)

if status is-interactive
  source $XDG_CONFIG_HOME/fish/abbreviations.fish

  # https://github.com/starship/starship#fish
  starship init fish | source

  # https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell
  source ~/.asdf/asdf.fish
end

fish_vi_key_bindings

if test -e $DOTFILES/local/config.fish.local
  source $DOTFILES/local/config.fish.local
end