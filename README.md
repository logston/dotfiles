# Logston's Dotfiles

    curl -s https://raw.githubusercontent.com/logston/dotfiles/master/setup.sh | bash

## Bootstrapping a new machine?

### All OSs

@Logston's dev env consists of a few basic tools. 

When setting up a new machine, first get few basics installed:

- Oh-my-zsh (and potentially zsh): https://ohmyz.sh/#install
- Tmux Plugin Manager: https://github.com/tmux-plugins/tpm
- brew: https://brew.sh/

Then running the setup script above should install the rest. 

#### Git GPG Keys

In order to sign Git commits, you'll need to create a GPG key and add these env
vars to your machine specific `~/.zsh.d/` file. 

```
gpg --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1
...
```

```
export GIT_CONFIG_COUNT=2
export GIT_CONFIG_KEY_0=user.email 
export GIT_CONFIG_VALUE_0=paul@...
export GIT_CONFIG_KEY_1=user.signingkey
export GIT_CONFIG_VALUE_1=ABC1233456
```

Make sure you have git >= 2.37: `git --version`

### Tmux
#### MacOS

Set the command for terminal to run upon opening to: `/usr/local/bin/tmux attach-session`

#### Linux

Run `tmux attach-session -t Default` after shelling in.

