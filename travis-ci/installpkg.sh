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
# brew install gcc49
  sudo port install gcc49
#
  brew install gmp
  brew install bdw-gc
# brew install gtk+3
  brew install libev
  brew install jansson
#
fi

###### for LINUX ######

is_linux=`expr "${TRAVIS_OS_NAME}" : "linux"`;

# echo "is_linux = ${is_linux}"

if
  expr ${is_linux} > 0
then
#
  sudo apt-get -qq -y update
  sudo apt-get -qq -y install libgc-dev
  sudo apt-get -qq -y install libgmp3-dev
# For contrib/GTK/
  sudo apt-get -qq -y install libgtk-3-dev
# For contrib/libev/
  sudo apt-get -qq -y install libev-dev
# For contrib/jansson/
  sudo apt-get -qq -y install libjansson-dev
#
fi

######

exit 0

###### end of [installpkg.sh] ######
