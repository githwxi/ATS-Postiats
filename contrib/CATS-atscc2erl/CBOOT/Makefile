#
# A simple Makefile
#

######

CPF=cp -f
RMF=rm -f
MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######

# CATSPARSEMIT=./../CATS-parsemit

######

# SOURCES_DATS :=
# SOURCES_DATS += DATS/atscc2erl_main.dats
# SOURCES_DATS += DATS/atscc2erl_emit.dats
# SOURCES_DATS += DATS/atscc2erl_emit2.dats

# SOURCES_CATS :=
# SOURCES_CATS += catsparse_sats.c
# SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_mylib_dats.c
# SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_include_all_dats.c

######

# SOURCES_DATS_C := $(patsubst %.dats, %_dats.c, $(SOURCES_DATS))

######
#
# all:: \
# atscc2erl
# atscc2erl: ; \
# $(PATSCC) -O2 -o $@ \
#   $(SOURCES_DATS_C) $(SOURCES_CATS) -DATS_MEMALLOC_GCBDW -lgc
#
######
#
all:: ; \
make -C ./.. libatscc2erl.a
#
all:: ; $(MAKE) -C ./.. CBOOT
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./atscc2erl

###### end of [Makefile] ######
