#
# For building Makefiles for portable projects in ATS 
#

######

ifeq ("$(MYTARGET)","")
else
$(MYTARGET)_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(MYTARGET)_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))
endif

######

ifeq ("$(MYTARGET)","")
else
ifeq ("$(MYTARGET)","MYTARGET")
else
all:: $(MYTARGET)
$(MYTARGET): \
  $($(MYTARGET)_SATS_O) \
  $($(MYTARGET)_DATS_O) ; \
  $(PATSCC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) $(MYTARGET)
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

######

ifeq ("$(MYCCRULE)","")
%_sats.o: %.sats ; $(PATSCC) $(INCLUDE_ATS) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -c $<
endif

######
#
-include .depend
#
depend:: ; $(RMF) -f .depend
#
ifeq ("$(SOURCES_SATS)","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
#
ifeq ("$(SOURCES_DATS)","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
#
######

# portdep: INCLUDE_ATS_C = -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime 
# portdep: ; $(RMF) .atscdep .atscdep_tmp
# ifeq ("$(SOURCES_SATS)","")
# else
# portdep: ; $(CC) $(INCLUDE_ATS_C) $(CFLAGS) *_sats.c $(CCDEPFLAG) .atscdep_tmp \
#           ; tail -n +2 .atscdep_tmp >> .atscdep
# endif
# ifeq ("$(SOURCES_DATS)","")
# else
# portdep: ; $(CC) $(INCLUDE_ATS_C) $(MALLOCFLAG) $(CFLAGS) *_dats.c $(CCDEPFLAG) .atscdep_tmp \
#           ; tail -n +2 .atscdep_tmp >> .atscdep
# endif
# portdep: ; $(RMF) .atscdep_tmp 
portdep: portdepCP

portdepINIT:
	$(eval INCLUDE_ATS_C := -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime) 
	$(eval INCLUDE_ATS_PC := -I$(ATSDEPDIR) -I$(ATSDEPDIR)/ccomp/runtime)
	$(RMF) .atscdep .atscdep_tmp
portdepMKDEP: portdepINIT
	$(CC) $(INCLUDE_ATS_C) $(MALLOCFLAG) $(CFLAGS) *_dats.c $(CCDEPFLAG) .atscdep_tmp; \
	tail -n +2 .atscdep_tmp >> .atscdep
portdepDEPSLIST: portdepMKDEP
	$(eval CPATSDEPS := $(shell cat .atscdep | tr -d '\\\n'))
portdepDEPSSORT: portdepDEPSLIST
	$(eval CPATSDEPS := $(sort $(CPATSDEPS)))
portdepFROMDIRS: portdepDEPSSORT
	$(eval FROMDIRS := $(foreach cdep, $(CPATSDEPS), $(shell dirname $(cdep))))
portdepTO: portdepFROMDIRS
	$(eval CPATSDEPSTODIRS := $(subst $(PATSHOME)/, , $(FROMDIRS)))
	$(eval CPATSDEPSTOFILES := $(subst $(PATSHOME)/, , $(CPATSDEPS)))
portdepMKDIR: portdepTO
	$(foreach todir, $(CPATSDEPSTODIRS), mkdir -p $(ATSDEPDIR)/$(todir))
portdepCP: portdepMKDIR
	$(foreach tofil, $(CPATSDEPSTOFILES), \
	$(shell cp $(PATSHOME)/$(tofil) $(ATSDEPDIR)/$(tofil)))


######
# need a step here for input to portdep
portable:: portdep # why doesn't portdep work here?
portable:: $(MYTARGET)
	$(CC) $(MALLOCFLAG) $(CFLAGS) $(INCLUDE_ATS_PC) *ats.c -o $(MYTARGET)

######

RMF=rm -f

######

cleanport:: ; $(RMF) *~
cleanport:: ; $(RMF) *_?ats.o
cleanport:: ; $(RMF) .atscdep_tmp

######

cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) *_?ats.o
cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) .atscdep .atscdep_tmp
cleanats:: ; $(RMF) -r $(ATSDEPDIR) 
cleanats:: ; $(RMF) atsmake-port-pre.mk atsmake-port-post.mk

######

clean: cleanats

######

cleanall:: cleanats
cleanall:: ; $(RMF) .depend

######

###### end of [atsmake-post.mk] ######
