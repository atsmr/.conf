source ~/.bashrc
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# if [ $SHLVL = 1 ]; then
#   tmux
# fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\w\$(parse_git_branch) $ "

export PATH="$HOME/.cargo/bin:$PATH"
