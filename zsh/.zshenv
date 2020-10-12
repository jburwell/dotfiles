# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# TODO Move to a custom oh-my-zsh plugin
# Intellij configuration
export IDEA_JDK="$(/usr/libexec/java_home -v 1.8)"

# Alias definitions ...
alias grep='grep --color=auto'
alias diff='colordiff'

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=false

config_files=(~/.zsh.d/**/*.zsh(N))
for file in ${config_files}
do
  source $file
done

plugins=(brew asdf git mvn gradle osx vagrant lein pip python pyenv rake rbenv rebar ruby sudo zsh-syntax-highlighting aws)

. $ZSH/oh-my-zsh.sh

