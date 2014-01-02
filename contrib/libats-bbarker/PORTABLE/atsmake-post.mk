#
# For building Makefiles for projects in ATS 
# in a portable fashion.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.

######

ifeq ("$(MYTARGET)","")
else
$(MYTARGET)_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(MYTARGET)_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))
endif

######

#
# executable should be generated via CC
#
ifeq ("$(MYTARGET)","")
else
ifeq ("$(MYTARGET)","MYTARGET")
else
all: $(MYTARGET)
$(MYTARGET): \
  $($(MYTARGET)_SATS_O) \
  $($(MYTARGET)_DATS_O) ; \
  $(CC) $(CFLAGS) $(INCLUDE) -o $@ $^ $(LDFLAGS)
cleanall: ; $(RMF) $(MYTARGET)
endif
endif

######
#
# HX-2013-12-28: for debugging
#
ifeq ("$(MYCCRULE)","")
%_sats.c: %.sats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
%_dats.c: %.dats ; $(PATSCC) $(INCLUDE_ATS) -ccats $<
endif
#
######


#
# object files should be generated via CC
#
ifeq ("$(MYCCRULE)","")
%_sats.o: %_sats.c ; \
  $(CC) $(INCLUDE) $(CFLAGS) -c $<
%_dats.o: %_dats.c ; \
  $(CC) $(INCLUDE) $(MALLOCFLAG) $(CFLAGS) -c $<
endif

######
#
# For generating portable C code
#
ifeq ("$(MYPORTDIR)", "")
else
#
$(MYPORTDIR)_SATS_C := \
  $(patsubst %.sats, $(MYPORTDIR)/%_sats.c, $(SOURCES_SATS))
$(MYPORTDIR)_DATS_C := \
  $(patsubst %.dats, $(MYPORTDIR)/%_dats.c, $(SOURCES_DATS))
#
$(MYPORTDIR): $($(MYPORTDIR)_SATS_C)
$(MYPORTDIR): $($(MYPORTDIR)_DATS_C)
#
#This form of rule can apparently cause trouble in some newer versions
# (3.82+) of GNU make.
$(MYPORTDIR)/%_sats.c: %.sats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
$(MYPORTDIR)/%_dats.c: %.dats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -d $<
#
endif
#
######
#
-include .depend
#
depend: ; $(RMF) -f .depend
#
ifeq ("$(SOURCES_SATS)","")
else
depend: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
#
ifeq ("$(SOURCES_DATS)","")
else
depend: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
#
######

RMF=rm -f

######

cleanats: ; $(RMF) *~
cleanats: ; $(RMF) *_?ats.c
cleanats: ; $(RMF) atsmake-pre.mk atsmake-post.mk

######

cleanport: ; $(RMF) *_?ats.o
cleanport: ; $(RMF) *.exe

######

clean: cleanport

######

cleanall: cleanats
cleanall: cleanport
cleanall: ; $(RMF) .depend

######

###### end of [atsmake-post.mk] ######
