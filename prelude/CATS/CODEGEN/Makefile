#
#
# A simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

all:: basics.cats
basics.cats: basics_atxt.exe ; ./$< > $@
basics_atxt.exe: basics_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ basics_atxt.dats -latsdoc
basics_atxt.dats: basics.atxt
	$(ATSDOC) --outcode $@ -i basics.atxt > basics_atxt.txt
clean:: ; $(RMF) basics_atxt.exe
cleanall:: ; $(RMF) basics.cats

all:: bool.cats
bool.cats: bool_atxt.exe ; ./$< > $@
bool_atxt.exe: bool_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ bool_atxt.dats -latsdoc
bool_atxt.dats: bool.atxt
	$(ATSDOC) --outcode $@ -i bool.atxt > bool_atxt.txt
clean:: ; $(RMF) bool_atxt.exe
cleanall:: ; $(RMF) bool.cats

all:: char.cats
char.cats: char_atxt.exe ; ./$< > $@
char_atxt.exe: char_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ char_atxt.dats -latsdoc
char_atxt.dats: char.atxt
	$(ATSDOC) --outcode $@ -i char.atxt > char_atxt.txt
clean:: ; $(RMF) char_atxt.exe
cleanall:: ; $(RMF) char.cats

all:: integer.cats
integer.cats: integer_atxt.exe ; ./$< > $@
integer_atxt.exe: integer_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ integer_atxt.dats -latsdoc
integer_atxt.dats: integer.atxt
	$(ATSDOC) --outcode $@ -i integer.atxt > integer_atxt.txt
clean:: ; $(RMF) integer_atxt.exe
cleanall:: ; $(RMF) integer.cats

all:: float.cats
float.cats: float_atxt.exe ; ./$< > $@
float_atxt.exe: float_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ float_atxt.dats -latsdoc
float_atxt.dats: float.atxt
	$(ATSDOC) --outcode $@ -i float.atxt > float_atxt.txt
clean:: ; $(RMF) float_atxt.exe
cleanall:: ; $(RMF) float.cats

all:: pointer.cats
pointer.cats: pointer_atxt.exe ; ./$< > $@
pointer_atxt.exe: pointer_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ pointer_atxt.dats -latsdoc
pointer_atxt.dats: pointer.atxt
	$(ATSDOC) --outcode $@ -i pointer.atxt > pointer_atxt.txt
clean:: ; $(RMF) pointer_atxt.exe
cleanall:: ; $(RMF) pointer.cats

all:: string.cats
string.cats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) --outcode $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.cats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
