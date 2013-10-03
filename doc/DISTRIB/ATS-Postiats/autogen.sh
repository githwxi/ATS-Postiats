#!/bin/bash

######
#
# Preparing for making a distribution package 
#
######

autoheader configure.ac
aclocal
automake --add-missing --foreign || true
autoconf

###### end of [autogen.sh] ######
