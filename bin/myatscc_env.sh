#!/bin/sh
######
#
# beg of [myatscc_env.sh.in]
#
######
#
# Author:
# Likai Liu (likaiATcsDOTbuDOTedu)
# Author2:
# Hongwei Xi (gmhwxiATgmailDOTcom) // September, 2013
#
######
#
PACKAGE_VERSION=0.3.9
PACKAGE_TARNAME=ats2-postiats
#
prefix=/usr/local

if [ ! "$PATSHOME" ] ; then
  export PATSHOME="$prefix/lib/${PACKAGE_TARNAME}-${PACKAGE_VERSION}"
fi

if [ ! -d "$PATSHOME" ] ; then
  echo "ATS-Postiats should have been available at '${PATSHOME}'"; exit 1
fi

prog=`basename $0`

case $prog in
  myatscc)
    exec "$PATSHOME/bin/$prog" "$@"
    ;;
  *)
    echo "This is a script for myatscc."
    echo "The script should be symbolically named as [myatscc]."
    exit 1
    ;;
esac

######
#
# end of [myatscc_env.sh.in]
#
######
