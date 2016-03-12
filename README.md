# dotfiles
Repo to hold config files.

## Clone the repo

```bash
git clone git@github.com:wooters/dotfiles.git ~/.dotfiles
```

## Setting up a new mac

```bash
cd ~/.dotfiles
./mac_setup.sh
```

## Install dotfiles

(Don't need to do this if running ```mac_setup.sh``` above.)

```bash
cd ~/.dotfiles
stow bash
stow tmux
stow emacs
```


