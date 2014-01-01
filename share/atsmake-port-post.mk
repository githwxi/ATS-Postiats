#
# For building Makefiles for portable projects in ATS 
#

######

ifeq ("$(MYTARGET)","")
else
SATS_C := $(patsubst %.sats, %_sats.c, $(SOURCES_SATS))
DATS_C := $(patsubst %.dats, %_dats.c, $(SOURCES_DATS))

%_sats.c: %.sats 
	$(PATSCC) $(INCLUDE_ATS) -ccats $<
%_dats.c: %.dats 
	$(PATSCC) $(MALLOCFLAG) $(INCLUDE_ATS) -ccats $<

endif

######
# If I leave this out, the build fails:

# ifeq ("$(MYCCRULE)","")
# %_sats.o: %.sats ; $(PATSCC) $(INCLUDE_ATS) $(CFLAGS) -c $<
# %_dats.o: %.dats ; $(PATSCC) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -c $<
# endif

ifeq ("$(MYTARGET)","")
else
SATS_O := $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
DATS_O := $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

%_sats.o: %_sats.c 
	$(CC) $(INCLUDE_ATS_PC) $(CFLAGS) $< -o $@
%_dats.o: %_dats.c
	$(CC) $(INCLUDE_ATS_PC) $(MALLOCFLAG) $(CFLAGS) $< -o $@
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

portdepINIT: $(SATS_C) $(DATS_C)
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
	$(foreach todir, $(CPATSDEPSTODIRS), $(shell mkdir -p $(ATSDEPDIR)/$(todir)))
portdepCP: portdepMKDIR
	$(foreach tofil, $(CPATSDEPSTOFILES), \
	$(shell cp $(PATSHOME)/$(tofil) $(ATSDEPDIR)/$(tofil)))


######

all:: portdepCP $(SATS_O) $(DATS_O)
	$(CC) $(MALLOCFLAG) $(CFLAGS) $(INCLUDE_ATS_PC) *ats.o -o $(MYTARGET)

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
cleanall:: ; $(RMF) *.exe
cleanall:: ; $(RMF) $(MYTARGET)

######

###### end of [atsmake-post.mk] ######
