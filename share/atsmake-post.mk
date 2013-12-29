#
# For building Makefiles for projects in ATS 
#

######

TARGETS_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
TARGETS_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

######
#
-include .depend
#
depend:: ; $(RMF) -f .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
#
######

RMF=rm -f

######

cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) *_?ats.o
cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) .depend

######

###### end of [atsmake-post.mk] ######
