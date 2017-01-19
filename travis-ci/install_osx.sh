#!/usr/bin/env sh

brew update
brew install gmp
brew install bdw-gc
brew install pcre
brew install glib
brew install cairo
brew install gtk+3
brew install libev
brew install json-c
brew install jansson
brew install docbook
brew install caskroom/cask/brew-cask
brew cask install xquartz
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH

###### end of [install_osx.sh] ######
