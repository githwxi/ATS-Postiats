#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=gcc

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: test01
test01: test01.exe
test01.exe: test01_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOMERELOCQ)/contrib   -DATS_MEMALLOC_LIBC  -o $@ $< -ljansson
test01_dats.c: test01.dats ;   $(PATSOPT) -IATS$(PATSHOMERELOCQ)/contrib --output test01_dats.c --dynamic test01.dats
clean:: ; $(RMF) test01_dats.o
clean:: ; $(RMF) test01_dats.c
cleanall:: ; $(RMF) test01.exe

all:: test02
test02: test02.exe
test02.exe: test02_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOMERELOCQ)/contrib   -DATS_MEMALLOC_LIBC -DATS_MEMALLOC_LIBC -o $@ $< -ljansson
test02_dats.c: test02.dats ;   $(PATSOPT) -IATS$(PATSHOMERELOCQ)/contrib --output test02_dats.c --dynamic test02.dats
clean:: ; $(RMF) test02_dats.o
clean:: ; $(RMF) test02_dats.c
cleanall:: ; $(RMF) test02.exe

all:: github_commit_query
github_commit_query: github_commit_query.exe
github_commit_query.exe: github_commit_query_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOMERELOCQ)/contrib   -DATS_MEMALLOC_LIBC -DATS_MEMALLOC_LIBC -o $@ $< -lcurl -ljansson
github_commit_query_dats.c: github_commit_query.dats ;   $(PATSOPT) -IATS$(PATSHOMERELOCQ)/contrib --output github_commit_query_dats.c --dynamic github_commit_query.dats
clean:: ; $(RMF) github_commit_query_dats.o
clean:: ; $(RMF) github_commit_query_dats.c
cleanall:: ; $(RMF) github_commit_query.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
