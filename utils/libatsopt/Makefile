#
# A simple Makefile
# for building libatsopt
#

######
#
ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######

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
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT cleanall
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT libatsopt
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

libatsopt_ext:: ; \
  $(ATSCC) -IATS ${PATSHOME} -IATS ${ATSHOME} -I ${PATSHOME}/src -c SATS/libatsopt_ext.sats && \
  $(AR) -r libatsopt.a libatsopt_ext_sats.o
libatsopt_ext:: ; \
  $(ATSCC) -IATS ${PATSHOME} -IATS ${ATSHOME} -I ${PATSHOME}/src -c DATS/libatsopt_ext.dats && \
  $(AR) -r libatsopt.a libatsopt_ext_dats.o

######

AR= ar
RMF=rm -f
MAKE=make

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) libatsopt.a

###### end of [Makefile] ######
