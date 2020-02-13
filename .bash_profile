# Command to not track local untracked files (home dir)
# git config --local status.showUntrackedFiles no

# Uncomment this to allow ctrl+q to pass through the
# terminal to the shell. Probably a bad idea though.
#stty start undef

# Ensure all shells only allow 256 color
export TERM=screen-256color

# FZF
export FZF_DEFAULT_OPTS='--color light'

### Python
export PYTHON_CONFIGURE_OPTS="--enable-shared"

#### Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.poetry/bin:$PATH"

# Google SDK
export CLOUDSDK_PYTHON="$PYENV_ROOT/versions/2.7.17/bin/python2"
export PATH="$HOME/Code/google-cloud-sdk/bin:$PATH"

# Better Kubernetes
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/usr/local/Cellar/kubernetes-cli/1.15.1/bin:$PATH"
source <(kubectl completion zsh)
fi

### Postgres
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/Applications/Postgres.app/Contents/Versions/11/bin:$PATH"
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# GO
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

### GIT
export PATH=$PATH:~/Code/git

### Java
if [[ "$OSTYPE" == "darwin"* ]]; then
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
fi

### 15Five Functions
set-aws-env() {
    source /Users/paul/Code/15five/aws-cli-tooling/set-env.sh
}

######### Aliases
alias gpot='git push origin HEAD && git push origin --tags'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t Default || tmux new -s Default
  fi
fi
