#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: qa-list-32
qa-list-32: qa-list-32.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-32

######

all:: qa-list-35
qa-list-35: qa-list-35.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-35

######

all:: qa-list-43
qa-list-43: qa-list-43.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-43

######

all:: qa-list-45
qa-list-45: qa-list-45.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-45

######

all:: for-0install
for-0install: for-0install.dats ; \
  $(PATSCC) -IIATS ${PATSHOME}/contrib -cleanaft -DATS_MEMALLOC_LIBC -o $@ $< -ljson-c
cleanall:: ; $(RMF) for-0install

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
