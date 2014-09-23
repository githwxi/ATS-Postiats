#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

LDFLAGS :=
LDFLAGS += -lgc

######
#
all:: \
theHome_layout
theHome_layout: \
theHome_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theHome_layout.html
theHome_layout.html: theHome_layout; ./$< > $@
#
cleanall:: ; $(RMF) theHome_layout
#
######
#
all:: \
theDownloads_layout
theDownloads_layout: \
theDownloads_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theDownloads_layout.html
theDownloads_layout.html: theDownloads_layout; ./$< > $@
#
cleanall:: ; $(RMF) theDownloads_layout
#
######
#
all:: \
theDocuments_layout
theDocuments_layout: \
theDocuments_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theDocuments_layout.html
theDocuments_layout.html: theDocuments_layout; ./$< > $@
#
cleanall:: ; $(RMF) theDocuments_layout
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: cleanats
cleanall:: ; $(RMF) theHome_layout.html
cleanall:: ; $(RMF) theDownloads_layout.html
cleanall:: ; $(RMF) theDocuments_layout.html

######

###### end of [Makefile] ######
