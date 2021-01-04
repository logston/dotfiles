# Command to not track local untracked files (home dir)
# git config --local status.showUntrackedFiles no

# Uncomment this to allow ctrl+q to pass through the
# terminal to the shell. Probably a bad idea though.
#stty start undef

# Ensure all shells only allow 256 color
export TERM=screen-256color

# Append last command to history before returning prompt. This will save bash
# history even if multiple bash sessions are in use.
export PROMPT_COMMAND='history -a'

# FZF
export FZF_DEFAULT_OPTS='--color light'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

### Python
export PYTHON_CONFIGURE_OPTS="--enable-shared"

### color less
# Requires: brew install source-highlight
export LESS='-R'
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"

### Turn on direnv
eval "$(direnv hook zsh)"

### Brew
# Brew's PATH must be before pyenv in the PATH var otherwise pyenv's
# shim logic will cause commands present in any unactive python version
# to trigger a "this command is no available in this python version" error
# rather than falling through to another library. OR the offending library
# can be removed from the unactive python version.
export PATH="$(brew --prefix)/bin:$PATH"

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
# GOROOT set for vim-go / gopls
export GOROOT=/usr/local/Cellar/go/1.15.6/libexec
export GOPATH=/Users/paul/Code/go
export PATH=${PATH}:${GOPATH}/bin/
alias godoc='GO111MODULE=off godoc'

# GPG
export GPG_TTY=$(tty)

### GIT
export PATH="$HOME/.git-commands:$PATH"

alias gpoht='git push origin HEAD && git push origin --tags'
alias gt='git tag'
alias gdmh='git diff master HEAD'
alias gupm='git fetch upstream && git pull upstream master && git push origin master'
alias git-flush='git add . && git reset HEAD --hard'

git-help() {
  echo "gt — git tag"
  echo "gdct — git describe --tags 'git rev-list --tags --max-count=1'"
  echo "gpoat — git push origin --all && git push origin --tags"
  echo "gpoht — git push origin HEAD && git push origin tag"
  echo "gdtag - git tag --delete <tag> && git push origin :refs/tags/<tag>"
  echo "gdmh - git diff master HEAD"
  echo "gupm - git fetch upstream && git pull upstream master && git push origin master"
}

gdtag() {
    git tag --delete "$1" && git push origin ":refs/tags/$1"
}

### Java
if [[ "$OSTYPE" == "darwin"* ]]; then
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
export JRE_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home/jre
fi
export PATH="/usr/local/opt/openjdk/bin:$PATH"

### JavaScript
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

### Spark
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.4.4/libexec
export PATH="/usr/local/Cellar/apache-spark/2.4.4/bin:$PATH"

### Build Certs
export PATH="/Users/paul/Code/certstrap:$PATH"

### Tmux
if [ ! -f '/usr/local/bin/tmux' ]; then
ln -s /Users/paul/Code/tmux/tmux /usr/local/bin/tmux
fi
if [ ! -f '/usr/local/bin/tmux-popup' ]; then
ln -s /Users/paul/Code/tmux/tmux-popup /usr/local/bin/tmux-popup
fi
tmux-help() {
  echo "Rename pane: select-pane -t 1 -T 'Test'"
  echo "Show pane names: set pane-border-status"
}

complete -o nospace -C /usr/local/bin/terraform terraform

### Load machine specific ~/.bash_profile files
mkdir -p ~/.bash.d
touch ~/.bash.d/init
source ~/.bash.d/*

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t Default || tmux new -s Default
  fi
fi
