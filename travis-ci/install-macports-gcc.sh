#!/usr/bin/env sh

######

cd ${HOME}

######

WGETQ="wget -q"
TARZXF="tar zxf"

######

MacPorts_tgz=\
https://distfiles.macports.org/MacPorts/MacPorts-2.3.3.tar.gz

######

${WGETQ} ${MacPorts_tgz}
${TARZXF} MacPorts-2.3.3.tar.gz
cd MacPorts-2.3.3
./configure && make && sudo make install
export PATH=${PATH}:/opt/local/bin:/opt/local/sbin
sudo port -v selfupdate
sudo port install gcc47
sudo port select --list gcc
sudo port select --set gcc mp-gcc47

######

exit 0

###### end of [install-macports-gcc.sh] ######
