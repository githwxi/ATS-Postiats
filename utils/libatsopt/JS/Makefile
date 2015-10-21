#
# A simple Makefile
# for building libatsopt
#

######

CC=emcc
CCOMP=$(CC)

######
#
ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######

CFLAGS += -Wno-implicit-function-declaration

######

all:: libatsopt_ext

######
#
# For building libatsopt without libgmp dependency
#
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src cleanall
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src C3NSTRINTKND=intknd libatsopt
#
libatsopt:: ; $(RMF) libatsopt.o
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src CBOOTmin
#
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT/JS cleanall
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT/JS libatsopt
#
######
#
libatsopt_ext_sats.c: \
./../SATS/libatsopt_ext.sats ; \
$(ATSOPT) -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ --static $<
libatsopt_ext_sats.o: libatsopt_ext_sats.c ; \
$(CCOMP) -O2 $(CFLAGS) \
  -I $(ATSHOME) -I $(ATSRUNTIME) -I $(PATSHOME)/src -c -o $@ $<
#
libatsopt_ext_dats.c: \
./../DATS/libatsopt_ext.dats ; \
$(ATSOPT) -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ --dynamic $<
libatsopt_ext_dats.o: libatsopt_ext_dats.c ; \
$(CCOMP) -O2 $(CFLAGS) \
  -I $(ATSHOME) -I $(ATSRUNTIME) -I $(PATSHOME)/src -c -o $@ $<
#
######
#
libatsopt_ext.o: \
libatsopt.o libatsopt_ext_sats.o libatsopt_ext_dats.o ; $(CCOMP) -o $@ $^
#
######

RMF=rm -f
MAKE=make

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) libatsopt.o
cleanall:: ; $(RMF) libatsopt_ext.o
cleanall:: ; $(RMF) libatsopt_ext.js

###### end of [Makefile] ######
