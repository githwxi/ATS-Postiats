#
# A simple Makefile
#
######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######

all:: \
patsolve_z3

######

NODE_MODULES="./node_modules"
NODE_MODULES_P="./../../node_modules"

######
#
CFLAGS=
#
CFLAGS+=-DATS_MEMALLOC_LIBC
#
CFLAGS+=-I$(NODE_MODULES)
CFLAGS+=-I$(NODE_MODULES_P)
CFLAGS+=-I${PATSHOME}/atscntrb/atscntrb-libjson-c
#
######

SOURCES_CATS= \
CATS/patsolve_parsing_sats.c \
CATS/patsolve_cnstrnt_sats.c \
CATS/patsolve_parsing_dats.c \
CATS/patsolve_cnstrnt_dats.c \
CATS/patsolve_z3_main_dats.c \
CATS/patsolve_z3_mylib_dats.c \
CATS/patsolve_z3_commarg_dats.c \
CATS/patsolve_z3_solving_dats.c \

######
#
patsolve_z3:: ; \
$(PATSCC) -O2 -o $@ $(CFLAGS) $(SOURCES_CATS) -ljson-c -lz3
#
###### end of [Makefile] ######
