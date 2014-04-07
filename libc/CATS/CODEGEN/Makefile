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

all:: alloca.cats
alloca.cats: alloca_atxt.exe ; ./$< > $@
alloca_atxt.exe: alloca_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ alloca_atxt.dats -latsdoc
alloca_atxt.dats: alloca.atxt
	$(ATSDOC) --outcode $@ -i alloca.atxt > alloca_atxt.txt
clean:: ; $(RMF) alloca_atxt.exe
cleanall:: ; $(RMF) alloca.cats

all:: dirent.cats
dirent.cats: dirent_atxt.exe ; ./$< > $@
dirent_atxt.exe: dirent_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ dirent_atxt.dats -latsdoc
dirent_atxt.dats: dirent.atxt
	$(ATSDOC) --outcode $@ -i dirent.atxt > dirent_atxt.txt
clean:: ; $(RMF) dirent_atxt.exe
cleanall:: ; $(RMF) dirent.cats

all:: dlfcn.cats
dlfcn.cats: dlfcn_atxt.exe ; ./$< > $@
dlfcn_atxt.exe: dlfcn_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ dlfcn_atxt.dats -latsdoc
dlfcn_atxt.dats: dlfcn.atxt
	$(ATSDOC) --outcode $@ -i dlfcn.atxt > dlfcn_atxt.txt
clean:: ; $(RMF) dlfcn_atxt.exe
cleanall:: ; $(RMF) dlfcn.cats

all:: errno.cats
errno.cats: errno_atxt.exe ; ./$< > $@
errno_atxt.exe: errno_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ errno_atxt.dats -latsdoc
errno_atxt.dats: errno.atxt
	$(ATSDOC) --outcode $@ -i errno.atxt > errno_atxt.txt
clean:: ; $(RMF) errno_atxt.exe
cleanall:: ; $(RMF) errno.cats

all:: fcntl.cats
fcntl.cats: fcntl_atxt.exe ; ./$< > $@
fcntl_atxt.exe: fcntl_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ fcntl_atxt.dats -latsdoc
fcntl_atxt.dats: fcntl.atxt
	$(ATSDOC) --outcode $@ -i fcntl.atxt > fcntl_atxt.txt
clean:: ; $(RMF) fcntl_atxt.exe
cleanall:: ; $(RMF) fcntl.cats

all:: fnmatch.cats
fnmatch.cats: fnmatch_atxt.exe ; ./$< > $@
fnmatch_atxt.exe: fnmatch_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ fnmatch_atxt.dats -latsdoc
fnmatch_atxt.dats: fnmatch.atxt
	$(ATSDOC) --outcode $@ -i fnmatch.atxt > fnmatch_atxt.txt
clean:: ; $(RMF) fnmatch_atxt.exe
cleanall:: ; $(RMF) fnmatch.cats

all:: malloc.cats
malloc.cats: malloc_atxt.exe ; ./$< > $@
malloc_atxt.exe: malloc_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ malloc_atxt.dats -latsdoc
malloc_atxt.dats: malloc.atxt
	$(ATSDOC) --outcode $@ -i malloc.atxt > malloc_atxt.txt
clean:: ; $(RMF) malloc_atxt.exe
cleanall:: ; $(RMF) malloc.cats

all:: math.cats
math.cats: math_atxt.exe ; ./$< > $@
math_atxt.exe: math_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ math_atxt.dats -latsdoc
math_atxt.dats: math.atxt
	$(ATSDOC) --outcode $@ -i math.atxt > math_atxt.txt
clean:: ; $(RMF) math_atxt.exe
cleanall:: ; $(RMF) math.cats

all:: signal.cats
signal.cats: signal_atxt.exe ; ./$< > $@
signal_atxt.exe: signal_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ signal_atxt.dats -latsdoc
signal_atxt.dats: signal.atxt
	$(ATSDOC) --outcode $@ -i signal.atxt > signal_atxt.txt
clean:: ; $(RMF) signal_atxt.exe
cleanall:: ; $(RMF) signal.cats

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
