#
# For building Makefiles for projects in ATS 
#

######
#
# Author: Hongwei Xi
# Author: Ian Denhardt
#
######

ifdef MYTARGET
$(MYTARGET)_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(MYTARGET)_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))
endif

######

ifdef MYTARGET
ifeq ($(strip $(MYTARGET)),MYTARGET)
else
all:: $(MYTARGET)
$(MYTARGET): \
  $($(MYTARGET)_SATS_O) \
  $($(MYTARGET)_DATS_O) ; \
  $(PATSCC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) $(MYTARGET)
endif # end of [ifeq]
endif # end of [ifdef]

######
#
# HX-2013-12-28:
# generating *_?ats.c files is mainly for debugging
#
ifeq ("$(MYCCRULE)","")
%_sats.c: %.sats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
%_dats.c: %.dats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
endif
#
######
#
# For compiling ATS source directly
#
ifndef MYCCRULE
%_sats.o: %.sats ; \
  $(PATSCC) -cleanaft $(INCLUDE_ATS) $(CFLAGS) -c $<
%_dats.o: %.dats ; \
  $(PATSCC) -cleanaft $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -c $<
endif
#
######
#
# For compiling C code generated from ATS source
#
ifeq ($(strip $(MYCCRULE)),PORTABLE)
#
%_sats.o: %_sats.c ; $(PATSCC) $(INCLUDE) $(CFLAGS) -c $<
%_dats.o: %_dats.c ; $(PATSCC) $(INCLUDE) $(MALLOCFLAG) $(CFLAGS) -c $<
#
endif
#
######
#
# For generating portable C code
#
ifdef MYPORTDIR
#
$(MYPORTDIR)_SATS_C := \
  $(patsubst %.sats, $(MYPORTDIR)/%_sats.c, $(SOURCES_SATS))
$(MYPORTDIR)_DATS_C := \
  $(patsubst %.dats, $(MYPORTDIR)/%_dats.c, $(SOURCES_DATS))
#
$(MYPORTDIR):: $($(MYPORTDIR)_SATS_C)
$(MYPORTDIR):: $($(MYPORTDIR)_DATS_C)
#
$(MYPORTDIR)/%_sats.c: %.sats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
$(MYPORTDIR)/%_dats.c: %.dats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -d $<
#
endif
#
######
#
-include .depend
#
depend:: ; $(RMF) .depend
#
ifeq ($(strip $(SOURCES_SATS)),"")
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
ifeq ($(strip $(SOURCES_DATS)),"")
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
#
######

RMF=rm -f

######

cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) *_?ats.o

######

clean: cleanats

######

cleanall:: cleanats
cleanall:: ; $(RMF) .depend

######

###### end of [atsmake-post.mk] ######
