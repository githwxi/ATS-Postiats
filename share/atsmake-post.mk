#
# For building Makefiles for projects in ATS 
#

######

$(TARGET)_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(TARGET)_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

LDFLAGS += -L$(PATSLIB) -latslib

all: $(TARGET)
$(TARGET): $($(TARGET)_SATS_O) $($(TARGET)_DATS_O)
	$(PATSCC) $(ATSCCFLAGS) $(LDFLAGS) -o $@ $^

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

cleanall:: cleanats
cleanall:: ; $(RMF) .depend

clean: cleanats

%_sats.o: %.sats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $<
%_dats.o: %.dats ; $(PATSCC) -D_BSD_SOURCE -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -c $<

######

###### end of [atsmake-post.mk] ######
