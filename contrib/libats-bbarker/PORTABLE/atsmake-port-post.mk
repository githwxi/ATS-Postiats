#
# For building Makefiles for portable projects in ATS 
#

######

ifdef PATSHOME
ifndef MYTARGET 
else
SATS_C := $(patsubst %.sats, %_sats.c, $(SOURCES_SATS))
DATS_C := $(patsubst %.dats, %_dats.c, $(SOURCES_DATS))

%_sats.c: %.sats 
	$(PATSCC) $(INCLUDE_ATS) -ccats $<
%_dats.c: %.dats 
	$(PATSCC) $(MALLOCFLAG) $(INCLUDE_ATS) -ccats $<

endif
endif

ifndef MYTARGET
else
SATS_O := $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
DATS_O := $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

%_sats.o: %_sats.c
	$(CC) $(INCLUDE_ATS_PC) $(CFLAGS) $< -o $@
%_dats.o: %_dats.c
	$(warning "TESTING .o") 
	$(CC) $(INCLUDE_ATS_PC) $(MALLOCFLAG) $(CFLAGS) $< -o $@
endif

######
#
-include .depend
ifdef PATSHOME
#
depend:: ; $(RMF) -f .depend
#
ifndef SOURCES_SATS
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
#
ifndef SOURCES_DATS
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
endif
#
######

ifdef PATSHOME
portdepINIT: $(SATS_C) $(DATS_C)
#	$(eval INCLUDE_ATS_C := -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime) 
#	$(eval INCLUDE_ATS_PC := -I$(ATSDEPDIR) -I$(ATSDEPDIR)/ccomp/runtime)
	$(RMF) .atscdep .atscdep_tmp
portdepMKDEP: portdepINIT
#	$(CC) $(INCLUDE_ATS_C) $(MALLOCFLAG) $(CFLAGS) *_dats.c \ 
#          $(CCDEPFLAG) .atscdep_tmp; \
#	$(PATSCC) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -c $< \
#          $(CCDEPFLAG) .atscdep_tmp
	$(PATSCC) $(INCLUDE_ATS) $(MALLOCFLAG) $(CFLAGS) -c *_dats.c \
          $(CCDEPFLAG) .atscdep_tmp; \
	tail -n +2 .atscdep_tmp >> .atscdep
portdepDEPSLIST: portdepMKDEP
	$(eval CPATSDEPS := $(shell cat .atscdep | tr -d '\\\n'))
portdepDEPSSORT: portdepDEPSLIST
	$(eval CPATSDEPS := $(sort $(CPATSDEPS)))
portdepFROMDIRS: portdepDEPSSORT
	$(eval FROMDIRS := $(foreach cdep, $(CPATSDEPS), $(shell dirname $(cdep))))

# Create necessary directory structure in local directory.
# Add created directories to CFLAGS.
portdepTO: portdepFROMDIRS
	$(eval CPATSDEPSTODIRS := $(subst $(PATSHOME)/, , $(FROMDIRS)))
	$(eval CPATSDEPSTOFILES := $(subst $(PATSHOME)/, , $(CPATSDEPS)))
portdepMKDIR: portdepTO
	$(foreach todir, $(CPATSDEPSTODIRS), $(shell mkdir -p $(ATSDEPDIR)/$(todir)))
portdepCP: portdepMKDIR
	$(foreach tofil, $(CPATSDEPSTOFILES), \
	$(shell cp $(PATSHOME)/$(tofil) $(ATSDEPDIR)/$(tofil)))
else
.PHONY: portdepCP
endif

######

#
#object intermediates: not working.
#
# all:: portdepCP $(SATS_O) $(DATS_O)
# 	$(CC) $(LDFLAGS) $(MALLOCFLAG) $(CFLAGS) $(INCLUDE_ATS_PC) *ats.o \
#           -o $(MYTARGET)

#
#skiping object intermediates
#

all:: portdepCP $(SATS_C) $(DATS_C)
	$(CC) $(MALLOCFLAG) $(CFLAGS) $(INCLUDE_ATS_PC) *ats.c \
          -o $(MYTARGET)

######

RMF=rm -f
RMFR=rm -fr

######

cleanport:: ; $(RMF) *~
cleanport:: ; $(RMF) *_?ats.o
cleanport:: ; $(RMF) .atscdep_tmp
cleanport:: ; $(RMF) *.exe $(MYTARGET)

######

cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) .atscdep .atscdep_tmp
cleanats:: ; $(RMF) atsmake-port-pre.mk atsmake-port-post.mk
cleanats:: ; $(RMFR) $(ATSDEPDIR) 

######

clean: cleanport

######

cleanall:: cleanats cleanport
cleanall:: ; $(RMF) .depend

###### end of [atsmake-post.mk] ######
