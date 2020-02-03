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

# Google SDK
export CLOUDSDK_PYTHON="/Users/paul/.pyenv/versions/2.7.15/bin/python2"
export PATH="/Users/paul/Code/google-cloud-sdk/bin:$PATH"

# Better Kubernetes
export PATH="/usr/local/Cellar/kubernetes-cli/1.15.1/bin:$PATH"

# OpenSSL
#export PATH="$(brew --prefix openssl)/bin:$PATH"

### Postgres
export PATH="/Applications/Postgres.app/Contents/Versions/11/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# GO
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

### GIT
export PATH=$PATH:~/Code/git

### Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home

######### Aliases
alias pa='pyenv activate'
alias gpot='git push origin HEAD && git push origin --tags'

if [[ "$OSTYPE" == "darwin"* ]]; then
if [ /usr/local/Cellar/kubernetes-cli/1.15.1/bin/kubectl ]; then source <(kubectl completion zsh); fi
fi
