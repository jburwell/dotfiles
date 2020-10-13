export HOMEBREW_HOME=$HOME/.homebrew
export HOMEBREW_NO_ANALYTICS=1

export PATH=$HOMEBREW_HOME/bin:$HOMEBREW_HOME/sbin:$PATH:$HOME/bin
export C_INCLUDE_PATH=$HOMEBREW_HOME/include
export CPLUS_INCLUDE_PATH=$HOMEBREW_HOME/include

autoload run-help
HELPDIR=$HOMEBREW_HOME/share/zsh/helpfiles

alias ls='ls -G'
alias ll='ls -alFG'

ZSH_TMUX_ITERM2=true

# TODO Move to a custom oh-my-zsh plugin
# Intellij configuration
export IDEA_JDK=$(/usr/libexec/java_home -v 1.8)

plugins+=(brew osx)
