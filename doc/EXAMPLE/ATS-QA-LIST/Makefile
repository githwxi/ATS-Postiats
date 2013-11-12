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

all:: qa-list-57
qa-list-57: qa-list-57.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-57

######

all:: qa-list-60
qa-list-60: qa-list-60.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-60

######

all:: qa-list-62
qa-list-62: qa-list-62.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-62

######

all:: qa-list-64
qa-list-64: qa-list-64.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) qa-list-64

######

all:: qa-list-66
qa-list-66: qa-list-66.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-66

######

all:: qa-list-67
qa-list-67: qa-list-67.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-67

######

all:: qa-list-91
qa-list-91: qa-list-91.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-91

######

all:: qa-list-97
qa-list-97: qa-list-97.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) qa-list-97

######

all:: list_last
list_last: list_last.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) list_last

######

all:: list_copy
list_copy: list_copy.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) list_copy

######

all:: for-0install
for-0install: for-0install.dats ; \
  $(PATSCC) -D_BSD_SOURCE -IIATS ${PATSHOME}/contrib -DATS_MEMALLOC_LIBC -o $@ $< -ljson-c
cleanall:: ; $(RMF) for-0install

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
