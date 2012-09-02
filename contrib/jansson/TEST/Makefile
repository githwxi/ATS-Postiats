#
# A simple Makefile
#

######

ATSCC=$(ATSHOME)/bin/atscc

######

CCFLAGS=-O2

######

ATSCTRB=$(PATSHOME)/contrib

######

all::
all:: test01
all:: test02

######

clean::
cleanall::

######

test01: test01_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o $@ $< -ljansson
cleanall:: ; $(RMF) test01

test02: test02_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o $@ $< -ljansson
cleanall:: ; $(RMF) test02

######

github_commits: github_commits_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o $@ $< -ljansson -lcurl
cleanall:: ; $(RMF) github_commits

######

%_dats.c: %.dats ; $(ATSCC) -cc -IATS$(ATSCTRB) $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
