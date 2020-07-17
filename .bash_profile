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

#### Poetry

export PATH="$HOME/.poetry/bin:$PATH"

#### pipx
export PATH="$HOME/.local/bin:$PATH"
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

### Brew
export PATH="$(brew --prefix)/bin:$PATH"

# Google SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/paul/.google-cloud-sdk/path.zsh.inc' ]; then . '/Users/paul/.google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/paul/.google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/paul/.google-cloud-sdk/completion.zsh.inc'; fi

# Better Kubernetes
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/usr/local/Cellar/kubernetes-cli/1.15.1/bin:$PATH"
source <(kubectl completion zsh)
fi
export PATH="${PATH}:${HOME}/.krew/bin"

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
alias gpoht='git push origin HEAD && git push origin --tags'
alias gt='git tag'
alias gdmh='git diff master HEAD'

git-help() {
  echo "gt — git tag"
  echo "gdct — git describe --tags 'git rev-list --tags --max-count=1'"
  echo "gpoat — git push origin --all && git push origin --tags"
  echo "gpoht — git push origin HEAD && git push origin tag"
  echo "gdtag - git tag --delete <tag> && git push origin :refs/tags/<tag>"
  echo "gdmh - git diff master HEAD"
}

gdtag() {
    git tag --delete "$1" && git push origin ":refs/tags/$1"
}

### Java
if [[ "$OSTYPE" == "darwin"* ]]; then
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
export JRE_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home/jre
fi

### Spark
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.4.4/libexec
export PATH="/usr/local/Cellar/apache-spark/2.4.4/bin:$PATH"


### 15Five Functions
set-sts-env() {
    source /Users/paul/Code/15five/aws-cli-tooling/set-sts-env.sh
}

set-deploy-env() {
    source /Users/paul/Code/15five/aws-cli-tooling/set-deploy-env.sh
}

set-pg-env() {
    source /Users/paul/Code/15five/aws-cli-tooling/set-pg-env.sh
}
# AWS_ROLE_NAME is used by our TG code
export AWS_ROLE_NAME=FFAdministrator

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t Default || tmux new -s Default
  fi
fi
