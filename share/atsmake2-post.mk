#
# For building Makefiles for projects in ATS 
#

######

$(TARGET)_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(TARGET)_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

######

all: $(TARGET)
cleanall:: ; $(RMF) $(TARGET)

######

$(TARGET): \
  $($(TARGET)_SATS_O) \
  $($(TARGET)_DATS_O) ; \
  $(PATSCC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

######
#
# HX-2013-12-28: for debugging
#
%_sats.c: %.sats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
%_dats.c: %.dats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
#
######

%_sats.o: %.sats ; $(PATSCC) $(INCLUDE_ATS) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC) $(INCLUDE_ATS) $(MEMALLOC_ATS) $(CFLAGS) -c $<

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

clean: cleanats

######

cleanall:: cleanats
cleanall:: ; $(RMF) .depend

######

###### end of [atsmake2-post.mk] ######
