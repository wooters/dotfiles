#!/bin/bash
# Set up a new mac

# Set up ssh key if needed
if [ ! -f ~/.ssh/id_rsa.pub ]; then

    ssh-keygen -t rsa
    ssh-add

    # Be sure to add the newly-generated public key to your Github account
    # See: https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
    pbcopy < ~/.ssh/id_rsa.pub
    echo "Go to Github and add your public key (which has been copied to the paste buffer)"
    echo "Press [ENTER] when ready to continue..."
    read -e
    
fi


# 256 color in bash (requires iterm)
# Put something like this in your .bashrc:
#   BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
#   [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# OS X developer tools
xcode-select --install
echo "Press [ENTER] when xcode is finished"
read -e

# get homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew cask installs
brew tap caskroom/cask
brew cask install java
brew cask install iterm2
brew cask install google-chrome
brew cask install firefox
brew cask install witch
brew cask install torbrowser

brew tap caskroom/fonts
brew cask install font-hack

# brew installs
brew install dirmngr libusb-compat readline
brew install gnupg2 gnutls glib coreutils
brew install sqlite gdbm gettext pcre xz d-bus
brew install wget tree p7zip stow tmux sox
brew install emacs --with-cocoa
brew install the_silver_searcher  # ag
brew install exa # better ls
brew install highlight
brew install fzf 
$(brew --prefix)/opt/fzf/install
brew install bash_completion

# Git
brew install git
brew install bash-git-prompt
curl -o .git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# mongodb (including the bsondump utility)
brew install mongodb

# python
brew install python python3

# Scala
brew install scala sbt  # requires java (see 'brew cask install java' above)

# R
brew install Caskroom/cask/xquartz
brew install R
brew install Caskroom/cask/rstudio
brew cask install basictex
brew install libsvg curl libxml2 gdal geos boost

# Install virtualenv and virtualenvwrapper for python
# We can install these using the default python and when
# creating a virtual environment, we can specify which
# python we want using, for example:
#  mkvirtualenv --python=python3
PIP_REQUIRE_VIRTUALENV=false pip install virtualenv
PIP_REQUIRE_VIRTUALENV=false pip install virtualenvwrapper

# Install some python packages needed by emacs
# We need to install these for each version of
# python we have installed...
/usr/local/bin/pip2 install flake8 jedi autopep8
/usr/local/bin/pip3 install flake8 jedi autopep8

# set up dotfiles
local_dot_repo=${HOME}/.dotfiles
if [ ! -d ${local_dot_repo} ]; then
    git clone git@github.com:wooters/dotfiles.git ${local_dot_repo}
    # these two files are in the dotfiles/bash subdir, so rm them here
    rm -f .bashrc
    rm -f .fzf.bash
    cd ${local_dot_repo}
    stow bash
    stow tmux
    stow emacs
fi



