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

all::

######

all:: stdio.cats
stdio.cats: stdio_atxt.exe ; ./$< > $@
stdio_atxt.exe: stdio_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ stdio_atxt.dats -latsdoc
stdio_atxt.dats: stdio.atxt
	$(ATSDOC) --outcode $@ -i stdio.atxt > stdio_atxt.txt
clean:: ; $(RMF) stdio_atxt.exe
cleanall:: ; $(RMF) stdio.cats

all:: stdlib.cats
stdlib.cats: stdlib_atxt.exe ; ./$< > $@
stdlib_atxt.exe: stdlib_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ stdlib_atxt.dats -latsdoc
stdlib_atxt.dats: stdlib.atxt
	$(ATSDOC) --outcode $@ -i stdlib.atxt > stdlib_atxt.txt
clean:: ; $(RMF) stdlib_atxt.exe
cleanall:: ; $(RMF) stdlib.cats

all:: string.cats
string.cats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) --outcode $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.cats

all:: unistd.cats
unistd.cats: unistd_atxt.exe ; ./$< > $@
unistd_atxt.exe: unistd_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ unistd_atxt.dats -latsdoc
unistd_atxt.dats: unistd.atxt
	$(ATSDOC) --outcode $@ -i unistd.atxt > unistd_atxt.txt
clean:: ; $(RMF) unistd_atxt.exe
cleanall:: ; $(RMF) unistd.cats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
