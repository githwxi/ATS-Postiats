#!/bin/bash

######
#
# For making a distribution package 
#
######

autoheader configure.ac
aclocal
automake --add-missing --foreign || true
autoconf

######
#
echo "autogen.sh: please *ignore* any error messages by automake."
#
######

###### end of [autogen.sh] ######
