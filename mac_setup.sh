#!/bin/bash
# Set up a new mac

# Assumes:
#  - XCode command-line tools are installed (`xcode-select --install`)
#  - HomeBrew is installed (see https://brew.sh/)
#  - GNU stow is installed (via homebrew)

# set up dotfiles
local_dot_repo=${HOME}/.dotfiles
if [ ! -d ${local_dot_repo} ]; then
    git clone git@github.com:wooters/dotfiles.git ${local_dot_repo}
    # this file is in the dotfiles/bash subdir, so remove it
    rm -f .bashrc
    cd ${local_dot_repo}
    stow bash
    stow tmux
    stow emacs
fi

# 256 color in bash (requires iterm)
# Put something like this in your .bashrc:
#   BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
#   [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# brew cask installs
brew tap homebrew/cask
brew install java
brew install iterm2
brew install witch  # window switching
brew install rectangle  # window management

brew tap homebrew/cask-fonts
brew install font-hack

# brew installs

# python
brew install pyenv
# run 'pyenv install --list' to see a list of available versions
# and then run 'pyenv install <version>' for each version you want
pyenv install 3.9.6
pyenv global 3.9.6
pip install --upgrade pip
pip install flake8 jedi autopep8 # for emacs, install these into the global python

brew install dirmngr libusb-compat readline
brew install gnupg2 gnutls glib coreutils
brew install sqlite gdbm gettext pcre xz d-bus
brew install wget tree p7zip stow tmux sox
brew install emacs
brew install cloc  # count lines of code
# brew install the_silver_searcher  # ag: code search similar to ack
brew install ripgrep  # rg: fast grep/ack
# brew install tldr  # simplified man pages
# brew install bat  # clone of cat(1) with syntax highlighting
brew install exa # better ls
# brew install 2mol/tools/pboy  # paperboy: pdf manager
brew install highlight

brew install bash-completion
brew install fpp  # facebook path-picker https://facebook.github.io/PathPicker/
brew instll grip  # markdown previewer

# Git
brew install git
curl -o .git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# mongodb (including the bsondump utility)
# brew install mongodb

# Scala
# brew install scala sbt  # requires java (see 'brew cask install java' above)

# R
# brew install Caskroom/cask/xquartz
# brew install R
# brew install Caskroom/cask/rstudio
# brew cask install basictex
# brew install libsvg curl libxml2 gdal geos boost
