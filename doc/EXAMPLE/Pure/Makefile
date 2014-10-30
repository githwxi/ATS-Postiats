#
# A simple Makefile
#
# HX-2012-10-24:
# Assuming that Pure is properly installed
#

######

.PHONY:: fact_dats.pure
.PHONY:: gauss_jordan_dats.pure

######

#
export \
PURE_ATSCC=patscc -DATS_MEMALLOC_LIBC
export \
PATSCCOMP=clang -emit-llvm -std=c99 -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime
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
