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
#export CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl@1.1)"
#
#### Pyenv
#export CC=clang
#export CFLAGS="-g"
#export CFLAGS="${CFLAGS} -I$(brew --prefix openssl)/include"
##export CFLAGS="${CFLAGS} -I$(brew --prefix readline)/include"
##export CFLAGS="${CFLAGS} -I$(xcrun --show-sdk-path)/usr/include"
#
#export CPPFLAGS="-I/opt/X11/include"
#export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix openssl)/include"
#export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix zlib)/include"
#
#export LDFLAGS="-L$(brew --prefix readline)/lib"
#export LDFLAGS="${LDFLAGS} -L$(brew --prefix openssl)/lib"

export PATH="/usr/local/sbin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"

if [[ "$OSTYPE" == "darwin"* ]]; then
eval "$(pyenv virtualenv-init -)"
fi

eval "$(pipenv --completion)"

export PATH="$HOME/.poetry/bin:$PATH"

# Google SDK
export CLOUDSDK_PYTHON="$HOME/.pyenv/versions/2.7.17/bin/python2"
export PATH="$HOME/Code/google-cloud-sdk/bin:$PATH"

# Better Kubernetes
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/usr/local/Cellar/kubernetes-cli/1.15.1/bin:$PATH"
if [ /usr/local/Cellar/kubernetes-cli/1.15.1/bin/kubectl ]; then source <(kubectl completion zsh); fi
fi

# OpenSSL
#export PATH="$(brew --prefix openssl)/bin:$PATH"

### Postgres
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/Applications/Postgres.app/Contents/Versions/11/bin:$PATH"
fi

# Rust
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="$HOME/.cargo/bin:$PATH"
fi

# GO
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

### GIT
export PATH=$PATH:~/Code/git

### Java
if [[ "$OSTYPE" == "darwin"* ]]; then
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
fi

######### Aliases
alias gpot='git push origin HEAD && git push origin --tags'
# Bluetooth fix
if [[ "$OSTYPE" == "linux-gnu" ]]; then
#alias soundon = 'pacmd set-card-profile device_name alsa_card.pci-0000_00_1f.3'
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t Default || tmux new -s Default
  fi
fi
