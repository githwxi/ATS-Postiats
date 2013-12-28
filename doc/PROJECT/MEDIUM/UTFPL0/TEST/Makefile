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
all:: test01_utfpl.json
all:: test02_utfpl.json
all:: test03_utfpl.json
all:: test04_utfpl.json
all:: test05_utfpl.json
all:: test06_utfpl.json
all:: queens_utfpl.json

######

%_utfpl.json: %.utfpl ; \
  $(PATSOPT) --jsonize-2 --jsonize-2 -o $@ -d $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean
cleanall:: ; $(RMF) -f test01_utfpl.json
cleanall:: ; $(RMF) -f test02_utfpl.json
cleanall:: ; $(RMF) -f test03_utfpl.json
cleanall:: ; $(RMF) -f test04_utfpl.json
cleanall:: ; $(RMF) -f test05_utfpl.json
cleanall:: ; $(RMF) -f test06_utfpl.json
cleanall:: ; $(RMF) -f queens_utfpl.json

###### end of [Makefile] ######
