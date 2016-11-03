#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2

######

MYTEXTING=./../MYTEXT/bin/mytexting

######
#
all:: \
main.html
main.html: main.atxt ; $(MYTEXTING) -o $@ -i $<
#
######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/funcomb-style/

######

permute: \
permute.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

queen-puzzle-bfs: \
queen-puzzle-bfs.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

queen-puzzle-dfs: \
queen-puzzle-dfs.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
queen-puzzle-dfs-2: \
queen-puzzle-dfs-2.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

regress:: queen-puzzle-bfs; ./$<
regress:: queen-puzzle-dfs; ./$<
regress:: queen-puzzle-dfs-2; ./$<

######

testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) main.html
#
cleanall:: ; $(RMF) permute
cleanall:: ; $(RMF) queen-puzzle-bfs
cleanall:: ; $(RMF) queen-puzzle-dfs
cleanall:: ; $(RMF) queen-puzzle-dfs-2
#
######

###### end of [Makefile] ######
