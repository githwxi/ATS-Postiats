#
# For building Makefiles for projects in ATS 
# in a portable fashion.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.

######

$(MYTARGET)_SATS_O := \
   $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
$(MYTARGET)_DATS_O := \
   $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

$(MYTARGET)_SATS_C := \
   $(patsubst %.sats, %_sats.c, $(SOURCES_SATS))
$(MYTARGET)_DATS_C := \
   $(patsubst %.dats, %_dats.c, $(SOURCES_DATS))

######

#
# executable should be generated via CC
#
all:: $(MYTARGET)
$(MYTARGET): $($(MYTARGET)_SATS_C) $($(MYTARGET)_DATS_C)
	$(CC) $(CFLAGS) $(INCLUDE) $^ -o $(MYTARGET) 
cleanall:: ; $(RMF) $(MYTARGET)


#
# object files should be generated via CC
#

ifndef MYCCRULE
%_sats.o:: %_sats.c 
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ -c $< 
%_dats.o:: %_dats.c
	$(CC) $(CFLAGS) $(INCLUDE) $(MALLOCFLAG) -o $@ -c $<  
endif


ifndef MYCCRULE
%_sats.c:: %.sats
	$(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
%_dats.c:: %.dats
	$(PATSOPT) $(INCLUDE_ATS) $(MALLOCFLAG) -o $@ -d $< 
endif

######
#
# For generating portable C code
#

# ifndef MYPORTDIR
# else
# #
# $(MYPORTDIR)_SATS_C := \
#   $(patsubst %.sats, $(MYPORTDIR)/%_sats.c, $(SOURCES_SATS))
# $(MYPORTDIR)_DATS_C := \
#   $(patsubst %.dats, $(MYPORTDIR)/%_dats.c, $(SOURCES_DATS))
# #
# $(MYPORTDIR):: $($(MYPORTDIR)_SATS_C)
# $(MYPORTDIR):: $($(MYPORTDIR)_DATS_C)
# #
# #This form of rule can apparently cause trouble in some newer versions
# # (3.82+) of GNU make.
# $(MYPORTDIR)/%_sats.c:: %.sats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
# $(MYPORTDIR)/%_dats.c:: %.dats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -d $<
# #
# endif
#
######
#
-include .depend
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
#
######

RMF=rm -f

######


cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) atsmake-pre.mk atsmake-post.mk

######

cleanport:: ; $(RMF) *_?ats.o
cleanport:: ; $(RMF) *.exe $(MYTARGET)
cleanport:: ; $(RMF) *~

######

clean: cleanport

######

cleanall:: cleanats cleanport
cleanall:: ; $(RMF) .depend

###### end of [atsmake-post.mk] ######
