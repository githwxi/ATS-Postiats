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
theHome_layout.dats; \
$(PATSCC2) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theHome_layout.html
theHome_layout.html: theHome_layout; ./$< > $@
#
######
#
all:: \
theDownloads_layout
theDownloads_layout: \
theDownloads_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theDownloads_layout.html
theDownloads_layout.html: theDownloads_layout; ./$< > $@
#
######
#
all:: \
theDocuments_layout
theDocuments_layout: \
theDocuments_layout.dats ; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theDocuments_layout.html
theDocuments_layout.html: theDocuments_layout; ./$< > $@
#
######
#
all:: \
theLibraries_layout
theLibraries_layout: \
theLibraries_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theLibraries_layout.html
theLibraries_layout.html: theLibraries_layout; ./$< > $@
#
######
#
all:: \
theCommunity_layout
theCommunity_layout: \
theCommunity_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theCommunity_layout.html
theCommunity_layout.html: theCommunity_layout; ./$< > $@
#
######
#
all:: \
thePapers_layout
thePapers_layout: \
thePapers_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
thePapers_layout.html
thePapers_layout.html: thePapers_layout; ./$< > $@
#
######
#
all:: \
theExamples_layout
theExamples_layout: \
theExamples_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theExamples_layout.html
theExamples_layout.html: theExamples_layout; ./$< > $@
#
######
#
all:: \
theResources_layout
theResources_layout: \
theResources_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theResources_layout.html
theResources_layout.html: theResources_layout; ./$< > $@
#
######
#
all:: \
theImplements_layout
theImplements_layout: \
theImplements_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
theImplements_layout.html
theImplements_layout.html: theImplements_layout; ./$< > $@
#
######
#
all:: \
thePatsoptaas_layout
thePatsoptaas_layout: \
thePatsoptaas_layout.dats; \
$(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
thePatsoptaas_layout.html
thePatsoptaas_layout.html: thePatsoptaas_layout; ./$< > $@
#
######

include $(PATSHOME)/share/atsmake-post.mk

######
#
cleanats:: ; $(RMF) *_?ats.c
#
cleanats:: ; $(RMF) theHome_layout
cleanats:: ; $(RMF) theDownloads_layout
cleanats:: ; $(RMF) theDocuments_layout
cleanats:: ; $(RMF) theLibraries_layout
cleanats:: ; $(RMF) theCommunity_layout
cleanats:: ; $(RMF) thePapers_layout
cleanats:: ; $(RMF) theExamples_layout
cleanats:: ; $(RMF) theResources_layout
cleanats:: ; $(RMF) theImplements_layout
cleanats:: ; $(RMF) thePatsoptaas_layout
#
######
#
cleanall:: cleanats
#
cleanall:: ; $(RMF) theHome_layout.html
cleanall:: ; $(RMF) theDownloads_layout.html
cleanall:: ; $(RMF) theDocuments_layout.html
cleanall:: ; $(RMF) theLibraries_layout.html
cleanall:: ; $(RMF) theCommunity_layout.html
cleanall:: ; $(RMF) thePapers_layout.html
cleanall:: ; $(RMF) theExamples_layout.html
cleanall:: ; $(RMF) theResources_layout.html
cleanall:: ; $(RMF) theImplements_layout.html
cleanall:: ; $(RMF) thePatsoptaas_layout.html
#
######

###### end of [Makefile] ######
