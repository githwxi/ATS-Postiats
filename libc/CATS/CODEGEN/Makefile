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

all:: malloc.cats
malloc.cats: malloc_atxt.exe ; ./$< > $@
malloc_atxt.exe: malloc_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ malloc_atxt.dats -latsdoc
malloc_atxt.dats: malloc.atxt
	$(ATSDOC) --outcode $@ -i malloc.atxt > malloc_atxt.txt
clean:: ; $(RMF) malloc_atxt.exe
cleanall:: ; $(RMF) malloc.cats

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

all:: strings.cats
strings.cats: strings_atxt.exe ; ./$< > $@
strings_atxt.exe: strings_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ strings_atxt.dats -latsdoc
strings_atxt.dats: strings.atxt
	$(ATSDOC) --outcode $@ -i strings.atxt > strings_atxt.txt
clean:: ; $(RMF) strings_atxt.exe
cleanall:: ; $(RMF) strings.cats

all:: time.cats
time.cats: time_atxt.exe ; ./$< > $@
time_atxt.exe: time_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ time_atxt.dats -latsdoc
time_atxt.dats: time.atxt
	$(ATSDOC) --outcode $@ -i time.atxt > time_atxt.txt
clean:: ; $(RMF) time_atxt.exe
cleanall:: ; $(RMF) time.cats

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
