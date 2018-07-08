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
$(MAKE) -C ./src cleanall
libatsopt:: ; \
$(MAKE) -C ./src libatsopt
#
######
#
# For building libatsopt without libgmp dependency
#
libatsopt_min:: ; \
$(MAKE) -C ./src cleanall
libatsopt_min:: ; \
$(MAKE) -C ./src C3NSTRINTKND=intknd libatsopt
#
######
#
patsopt_ext_dats.c: \
DATS/patsopt_ext.dats; \
$(ATSCC) -IATS . -IATS ${ATSHOME} -cc $<
#
patsopt_ext_dats.o: \
patsopt_ext_dats.c ; \
$(CCOMP) -O2 $(CFLAGS) \
-I $(ATSHOME) -I $(ATSRUNTIME) -I ./src -c -o $@ $<
#
libatsopt_ext:: patsopt_ext_dats.o ; $(AR) -r libatsopt.a $<
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
