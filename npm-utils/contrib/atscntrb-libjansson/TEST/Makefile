#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CC=gcc
CCOPT=$(CC) -std=c99 -D_GNU_SOURCE

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CFLAGS += -I./../..
CFLAGS += -I$(PATSHOMEQ)
CFLAGS += -I$(PATSHOMEQ)/ccomp/runtime

######

all::
regress::
cleanall::

######

LNS=ln -s
RMF=rm -f

######
#
all:: \
test01
test01: \
test01_dats.c ; \
$(CCOPT) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -ljansson
#
regress:: test01 ; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02_dats.c ; \
$(CCOPT) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -ljansson
#
regress:: test02 ; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
github_commit_query
github_commit_query: \
github_commit_query_dats.c ; \
$(CCOPT) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -lcurl -ljansson
#
regress:: github_commit_query ; ./$<
cleanall:: ; $(RMF) github_commit_query
#
######

%_dats.c: %.dats ; $(PATSOPT) -o $@ -d $<

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
