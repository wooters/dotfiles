# dotfiles
Repo to hold my config files. (Also, a script for setting up my environment on a new Mac.)

## Install

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone --depth 1 https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt
git clone git@github.com:wooters/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow bash
stow tmux
stow emacs
```

This assumes:

- The ssh key for the computer you are installing to has been added to the Github repo.
- [GNU Stow](https://www.gnu.org/software/stow/) is installed.

## Setting up a new Mac

```
curl https://raw.githubusercontent.com/wooters/dotfiles/master/mac_setup.sh | sh
```

This will generate an ssh key, install the ```dotfiles```, install OSX developer tools,
and a bunch of other goodies.

