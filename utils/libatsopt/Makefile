#
# A simple Makefile
# for building libatsopt
#

######

CC=gcc
CCOMP=$(CC)

######
#
ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt
#
######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######

all:: libatsopt
all:: libatsopt_ext

######
#
# For building libatsopt with libgmp dependency
#
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src cleanall
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src libatsopt
#
libatsopt:: ; $(RMF) libatsopt.a
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src CBOOT
#
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src/CBOOT cleanall
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src/CBOOT libatsopt && $(MVF) $(PATSHOME)/src/CBOOT/libatsopt.a .
#
######
#
# For building libatsopt without libgmp dependency
#
libatsopt_min:: ; \
$(MAKE) -C $(PATSHOME)/src cleanall
libatsopt_min:: ; \
$(MAKE) -C $(PATSHOME)/src C3NSTRINTKND=intknd libatsopt
#
libatsopt_min:: ; $(RMF) libatsopt.a
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src CBOOTmin
#
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT cleanall
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT libatsopt
#
######
#
libatsopt_ext_sats.c: \
SATS/libatsopt_ext.sats; \
  $(ATSCC) -IATS ${PATSHOME} -IATS ${ATSHOME} -cc $<
libatsopt_ext_dats.c: \
DATS/libatsopt_ext.dats; \
  $(ATSCC) -IATS ${PATSHOME} -IATS ${ATSHOME} -cc $<
#
libatsopt_ext_sats.o: libatsopt_ext_sats.c ; \
$(CCOMP) -O2 $(CFLAGS) \
  -I $(ATSHOME) -I $(ATSRUNTIME) -I $(PATSHOME)/src -c -o $@ $<
libatsopt_ext_dats.o: libatsopt_ext_dats.c ; \
$(CCOMP) -O2 $(CFLAGS) \
  -I $(ATSHOME) -I $(ATSRUNTIME) -I $(PATSHOME)/src -c -o $@ $<
#
libatsopt_ext:: libatsopt_ext_sats.o ; $(AR) -r libatsopt.a $<
libatsopt_ext:: libatsopt_ext_dats.o ; $(AR) -r libatsopt.a $<
#
######

AR= ar
RMF=rm -f
MVF=mv -f
MAKE=make

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) libatsopt.a

###### end of [Makefile] ######
