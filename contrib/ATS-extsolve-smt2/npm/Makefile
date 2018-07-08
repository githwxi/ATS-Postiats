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
patsolve_smt2

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
CFLAGS+=-I${PATSHOME}/contrib
#
######

SOURCES_CATS= \
CATS/patsolve_parsing_sats.c \
CATS/patsolve_cnstrnt_sats.c \
CATS/patsolve_parsing_dats.c \
CATS/patsolve_cnstrnt_dats.c \
CATS/patsolve_smt2_main_dats.c \
CATS/patsolve_smt2_mylib_dats.c \
CATS/patsolve_smt2_commarg_dats.c \
CATS/patsolve_smt2_solving_dats.c \

######

patsolve_smt2:: ; \
$(PATSCC) -O2 -o $@ $(CFLAGS) $(SOURCES_CATS) -ljson-c

###### end of [Makefile] ######
