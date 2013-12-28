#
# For building Makefiles for projects in ATS 
#

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

cleanall:: clean
cleanall:: ; $(RMF) .depend

######

###### end of [atsmake-post.mk] ######
