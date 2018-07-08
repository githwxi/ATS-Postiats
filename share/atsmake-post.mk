#
# For building Makefiles for projects in ATS 
#

######
#
# Author: Hongwei Xi
# Author: Ian Denhardt
#
######
#
# HX: for convenience
#
PATSCC2=$(PATSCC) $(INCLUDE) $(INCLUDE_ATS)
#
######

ifdef MYTARGET
$(MYTARGET)_C_O := \
  $(patsubst %.c, %_c.o, $(SOURCES_C))
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
  $($(MYTARGET)_C_O) \
  $($(MYTARGET)_SATS_O) \
  $($(MYTARGET)_DATS_O) ; \
  $(PATSCC) $(INCLUDE) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(EXTRAFLAGS)
cleanall:: ; $(RMF) $(MYTARGET)
endif # end of [ifeq]
endif # end of [ifdef]

######
#
# HX-2013-12-28:
# generating *_?ats.c files is mainly for debugging
#
ifdef MYCCRULE
else
%_sats.c: %.sats ; $(PATSCC) $(INCLUDE_ATS) -o $@ -ccats $<
%_dats.c: %.dats ; $(PATSCC) $(INCLUDE_ATS) -o $@ -ccats $<
endif
#
######
#
# For compiling ATS source directly
#
ifdef MYCCRULE
else
%_sats.o: %.sats ; \
  $(PATSCC) -cleanaft $(INCLUDE) $(INCLUDE_ATS) $(CFLAGS) -o $@ -c $<
%_dats.o: %.dats ; \
  $(PATSCC) -cleanaft $(INCLUDE) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -o $@ -c $<
endif
#
######
#
# For compiling C code generated from ATS source
#
ifeq ($(strip $(MYCCRULE)),PORTABLE)
#
%_sats.o: %_sats.c ; $(CC) $(INCLUDE) $(CFLAGS) -o $@ -c $<
%_dats.o: %_dats.c ; $(CC) $(INCLUDE) $(MALLOCFLAG) $(CFLAGS) -o $@ -c $<
#
endif
#
######
#
# For generating portable C code
#
ifdef MYPORTDIR
#
$(MYPORTDIR)/Makefile: Makefile ; cp -f $< $@
#
$(MYPORTDIR)_SATS_C := \
  $(patsubst %.sats, $(MYPORTDIR)/%_sats.c, $(SOURCES_SATS))
$(MYPORTDIR)_DATS_C := \
  $(patsubst %.dats, $(MYPORTDIR)/%_dats.c, $(SOURCES_DATS))
#
$(MYPORTDIR):: $(MYPORTDIR)/Makefile
$(MYPORTDIR):: $($(MYPORTDIR)_SATS_C)
$(MYPORTDIR):: $($(MYPORTDIR)_DATS_C)
#
ifdef MYPORTCPP
else
$(MYPORTDIR)/%_sats.c: %.sats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
$(MYPORTDIR)/%_dats.c: %.dats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -d $<
endif
#
ifdef MYPORTCPP
$(MYPORTDIR)/%_sats.c: %.sats ; \
  $(PATSCC) -cleanaft -E $(INCLUDE) $(INCLUDE_ATS) $(CFLAGS) -o $@ $<
$(MYPORTDIR)/%_dats.c: %.dats ; \
  $(PATSCC) -cleanaft -E $(INCLUDE) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -o $@ $<
endif
#
endif
#
######
#
-include .depend
#
depend:: ; $(RMF) .depend
#
ifeq ("$(strip $(SOURCES_SATS))","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
ifeq ("$(strip $(SOURCES_DATS))","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
#
######

CPF=cp -f
RMF=rm -f
RMRF=rm -rf

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
