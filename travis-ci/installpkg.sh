#!/usr/bin/env sh

######

cd ${HOME}

###### for OSX ######

is_osx=`expr "${TRAVIS_OS_NAME}" : "osx"`;

# echo "is_osx = ${is_osx}"

if
  expr ${is_osx} > 0
then
#
  echo "is_osx = ${is_osx}"
#
# export CC=gcc-4.8
# export GCC=gcc-4.8
#
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
#
  export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH
#
fi

###### for LINUX ######

is_linux=`expr "${TRAVIS_OS_NAME}" : "linux"`;

# echo "is_linux = ${is_linux}"

if
  expr ${is_linux} > 0
then
#
  echo "is_linux = ${is_linux}"
#
# sudo apt-get -qq -y update
# sudo apt-get -qq -y install libgc-dev
# sudo apt-get -qq -y install libgmp-dev
# For contrib/GTK/
# sudo apt-get -qq -y install libgtk-3-dev
# For contrib/libev/
# sudo apt-get -qq -y install libev-dev
# For contrib/json-c/
# sudo apt-get -qq -y install libjson0-dev
# For contrib/jansson/
# sudo apt-get -qq -y install libjansson-dev
#
fi

######

exit 0

###### end of [installpkg.sh] ######
