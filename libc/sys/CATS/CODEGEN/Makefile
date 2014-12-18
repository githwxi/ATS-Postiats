#
#
# A simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######
#
GCFLAG=
#
# GCFLAG=-D_ATS_GCATS
#
######

all::

######

all:: mman.cats
mman.cats: mman_atxt.exe ; ./$< > $@
mman_atxt.exe: mman_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ mman_atxt.dats -latsdoc
mman_atxt.dats: mman.atxt
	$(ATSDOC) --outcode $@ -i mman.atxt > mman_atxt.txt
clean:: ; $(RMF) mman_atxt.exe
cleanall:: ; $(RMF) mman.cats

all:: stat.cats
stat.cats: stat_atxt.exe ; ./$< > $@
stat_atxt.exe: stat_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ stat_atxt.dats -latsdoc
stat_atxt.dats: stat.atxt
	$(ATSDOC) --outcode $@ -i stat.atxt > stat_atxt.txt
clean:: ; $(RMF) stat_atxt.exe
cleanall:: ; $(RMF) stat.cats

all:: time.cats
time.cats: time_atxt.exe ; ./$< > $@
time_atxt.exe: time_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ time_atxt.dats -latsdoc
time_atxt.dats: time.atxt
	$(ATSDOC) --outcode $@ -i time.atxt > time_atxt.txt
clean:: ; $(RMF) time_atxt.exe
cleanall:: ; $(RMF) time.cats

all:: types.cats
types.cats: types_atxt.exe ; ./$< > $@
types_atxt.exe: types_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ types_atxt.dats -latsdoc
types_atxt.dats: types.atxt
	$(ATSDOC) --outcode $@ -i types.atxt > types_atxt.txt
clean:: ; $(RMF) types_atxt.exe
cleanall:: ; $(RMF) types.cats

all:: wait.cats
wait.cats: wait_atxt.exe ; ./$< > $@
wait_atxt.exe: wait_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ wait_atxt.dats -latsdoc
wait_atxt.dats: wait.atxt
	$(ATSDOC) --outcode $@ -i wait.atxt > wait_atxt.txt
clean:: ; $(RMF) wait_atxt.exe
cleanall:: ; $(RMF) wait.cats

all:: socket.cats
socket.cats: socket_atxt.exe ; ./$< > $@
socket_atxt.exe: socket_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ socket_atxt.dats -latsdoc
socket_atxt.dats: socket.atxt
	$(ATSDOC) --outcode $@ -i socket.atxt > socket_atxt.txt
clean:: ; $(RMF) socket_atxt.exe
cleanall:: ; $(RMF) socket.cats

all:: socket_in.cats
socket_in.cats: socket_in_atxt.exe ; ./$< > $@
socket_in_atxt.exe: socket_in_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ socket_in_atxt.dats -latsdoc
socket_in_atxt.dats: socket_in.atxt
	$(ATSDOC) --outcode $@ -i socket_in.atxt > socket_in_atxt.txt
clean:: ; $(RMF) socket_in_atxt.exe
cleanall:: ; $(RMF) socket_in.cats


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
