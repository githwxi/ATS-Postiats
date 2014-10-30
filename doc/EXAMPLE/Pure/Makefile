#
# A simple Makefile
#
# HX-2012-10-24:
# Assuming that Pure is properly installed
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

.PHONY:: fact_dats.pure
.PHONY:: gauss_jordan_dats.pure

######

#
export \
dragonegg_disable_version_check=1
#
export \
PURE_ATSCC= \
$(PATSCC) \
-atsccomp "${PURE_ATSCCOMP}" \
-fplugin=dragonegg -DATS_MEMALLOC_LIBC
#
export \
PURE_ATSCCOMP=\
gcc -std=c99 -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime
#
# export \
# PURE_ATSCCOMP=\
# clang -std=c99 -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -emit-llvm
#

######

all:: \
fact_dats.pure
fact_dats.pure: ; pure $@

######

all:: \
gauss_jordan_dats.pure
gauss_jordan_dats.pure: ; pure $@

###### end of [Makefile] ######
