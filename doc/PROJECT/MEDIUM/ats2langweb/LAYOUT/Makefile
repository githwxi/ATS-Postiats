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
#
all:: \
theLibraries_layout
theLibraries_layout: \
theLibraries_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theLibraries_layout.html
theLibraries_layout.html: theLibraries_layout; ./$< > $@
#
cleanall:: ; $(RMF) theLibraries_layout
#
######
#
all:: \
theCommunity_layout
theCommunity_layout: \
theCommunity_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theCommunity_layout.html
theCommunity_layout.html: theCommunity_layout; ./$< > $@
#
cleanall:: ; $(RMF) theCommunity_layout
#
######
#
all:: \
thePapers_layout
thePapers_layout: \
thePapers_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
thePapers_layout.html
thePapers_layout.html: thePapers_layout; ./$< > $@
#
cleanall:: ; $(RMF) thePapers_layout
#
######
#
all:: \
theExamples_layout
theExamples_layout: \
theExamples_layout.dats mylayout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theExamples_layout.html
theExamples_layout.html: theExamples_layout; ./$< > $@
#
cleanall:: ; $(RMF) theExamples_layout
#
######
#
all:: \
thePatsoptaas_layout
thePatsoptaas_layout: \
thePatsoptaas_layout.dats mylayout2.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
thePatsoptaas_layout.html
thePatsoptaas_layout.html: thePatsoptaas_layout; ./$< > $@
#
cleanall:: ; $(RMF) thePatsoptaas_layout
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
cleanall:: ; $(RMF) theLibraries_layout.html
cleanall:: ; $(RMF) theCommunity_layout.html
cleanall:: ; $(RMF) thePapers_layout.html
cleanall:: ; $(RMF) theExamples_layout.html
cleanall:: ; $(RMF) thePatsoptaas_layout.html

######

###### end of [Makefile] ######
