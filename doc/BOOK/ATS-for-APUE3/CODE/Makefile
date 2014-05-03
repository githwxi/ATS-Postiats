#
# APUE3-in-ATS2
#

######

CCOMP=gcc

######

APUE3=./..

######

INCLUDE=-I$(APUE3)/apue.3e/include

######

include $(PATSHOME)/share/atsmake-pre.mk

######

apue3_error.o: \
$(APUE3)/apue.3e/lib/error.c ; \
$(CCOMP) -I$(APUE3)/apue.3e/include -c -o $@ $<

######
#
all:: \
APUE3-1-3
APUE3-1-3: \
  APUE3-1-3.dats apue3_error.o ; \
  $(PATSCC2) $(INCLUDE) -o $@ $< apue3_error.o -L${PATSLIB} -latslib
cleanall:: ; $(RMF) APUE3-1-3
#
######
#
all:: \
APUE3-1-4
APUE3-1-4: \
  APUE3-1-4.dats apue3_error.o ; \
  $(PATSCC2) $(INCLUDE) -o $@ $< apue3_error.o -L${PATSLIB} -latslib
cleanall:: ; $(RMF) APUE3-1-4
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: ; $(RMF) apue3_error.o

######

###### end of [Makefile] ######
