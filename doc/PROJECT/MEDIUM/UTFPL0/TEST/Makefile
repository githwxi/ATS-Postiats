#
# A simple Makefile
#

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::
all:: test01_dats.json
all:: test02_dats.json
all:: test03_dats.json
all:: test04_dats.json
all:: test05_dats.json
all:: test06_dats.json
all:: queens_dats.json

######

%_dats.json: %.dats ; \
  $(PATSOPT) --jsonize-2 --jsonize-2 -o $@ -d $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean
cleanall:: ; $(RMF) -f test01_dats.json
cleanall:: ; $(RMF) -f test02_dats.json
cleanall:: ; $(RMF) -f test03_dats.json
cleanall:: ; $(RMF) -f test04_dats.json
cleanall:: ; $(RMF) -f test05_dats.json
cleanall:: ; $(RMF) -f test06_dats.json
cleanall:: ; $(RMF) -f queens_dats.json

###### end of [Makefile] ######
