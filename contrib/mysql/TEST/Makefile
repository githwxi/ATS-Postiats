#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

GCC=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

CCFLAGS=-O2
MYSQLLIBS=`mysql_config --libs`
MYSQLCFLAGS=`mysql_config --cflags`

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: test01
test01: test01.exe
test01.exe: test01_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test01_dats.c: test01.dats ; \
  $(PATSOPT) --output test01_dats.c --dynamic test01.dats
clean:: ; $(RMF) test01_dats.o
clean:: ; $(RMF) test01_dats.c
cleanall:: ; $(RMF) test01.exe

all:: test02
test02: test02.exe
test02.exe: test02_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test02_dats.c: test02.dats ; \
  $(PATSOPT) --output test02_dats.c --dynamic test02.dats
clean:: ; $(RMF) test02_dats.o
clean:: ; $(RMF) test02_dats.c
cleanall:: ; $(RMF) test02.exe

all:: test03
test03: test03.exe
test03.exe: test03_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test03_dats.c: test03.dats ; \
  $(PATSOPT) --output test03_dats.c --dynamic test03.dats
clean:: ; $(RMF) test03_dats.o
clean:: ; $(RMF) test03_dats.c
cleanall:: ; $(RMF) test03.exe

all:: test04
test04: test04.exe
test04.exe: test04_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test04_dats.c: test04.dats ; \
  $(PATSOPT) --output test04_dats.c --dynamic test04.dats
clean:: ; $(RMF) test04_dats.o
clean:: ; $(RMF) test04_dats.c
cleanall:: ; $(RMF) test04.exe

all:: test05
test05: test05.exe
test05.exe: test05_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test05_dats.c: test05.dats ; \
  $(PATSOPT) --output test05_dats.c --dynamic test05.dats
clean:: ; $(RMF) test05_dats.o
clean:: ; $(RMF) test05_dats.c
cleanall:: ; $(RMF) test05.exe

all:: test06
test06: test06.exe
test06.exe: test06_dats.c ; \
  $(GCC) $(CCFLAGS) \
    -I$(PATSHOMEQ) \
    -I$(PATSHOMEQ)/ccomp/runtime \
    -I$(PATSHOMEQ)/contrib \
    $(MYSQLCFLAGS) \
    -o $@ $< \
    $(MYSQLLIBS) 
test06_dats.c: test06.dats ; \
  $(PATSOPT) --output test06_dats.c --dynamic test06.dats
clean:: ; $(RMF) test06_dats.o
clean:: ; $(RMF) test06_dats.c
cleanall:: ; $(RMF) test06.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean
cleanall:: ; $(RMF) *.png

###### end of [Makefile] ######
