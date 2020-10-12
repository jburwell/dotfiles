source $HOME/.zshenv

# SSH key setup ...
$KEYCHAIN_CMD=$(which keychain)
if [ -z "$KEYCHAIN_CMD" ]; then
  for KEY_FILE in $HOME/.ssh/*.ssh
  do
    $KEYCHAIN_CMD $KEY_FILE
  done

  source $HOME/.keychain/$HOST-sh
fi

ulimit -n 10000

HIGHLIGHT_CMD=$(which highlight)
if [ -z "$HIGHLIGHT_CMD" ]; then
  export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-dark"
fi

export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'
alias gw='./gradlew'
alias grepl='gw javarepl --console plain --no-daemon'
