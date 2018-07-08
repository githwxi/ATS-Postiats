######
#
# A simple Makefile
#
######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######

all:: atscc2r34

######

NODE_MODULES="./node_modules"
NODE_MODULES_P="./../node_modules"
NODE_MODULES_PP="./../../node_modules"

######
#
CFLAGS=
#
CFLAGS+=-I$(NODE_MODULES)
CFLAGS+=-I$(NODE_MODULES_P)
CFLAGS+=-I$(NODE_MODULES_PP)
#
CFLAGS+=-DATS_MEMALLOC_LIBC
#
######
#
SOURCES_CATS= \
CATS/atscc2r34_main_dats.c \
CATS/atscc2r34_emit_dats.c \
CATS/atscc2r34_emit2_dats.c \
CATS/catsparse_sats.c CATS/catsparse_all_dats.c
#
######

atscc2r34:: ; $(PATSCC) -O2 -o $@ $(CFLAGS) $(SOURCES_CATS)

###### end of [Makefile] ######
