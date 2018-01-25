#
# A simple Makefile
#

######

ATSHOMEQ = "$(ATSHOME)"

######

ATSDOC = $(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ = "$(PATSHOME)"

######

PATSCC = $(PATSHOMEQ)/bin/patscc
PATSOPT = $(PATSHOMEQ)/bin/patsopt

######

XRLIBS=$(shell pkg-config cairo --libs)
XRCFLAGS=$(shell pkg-config cairo --cflags)

######

all::
regress::
cleanall::

######

all:: tutprog_hello
tutprog_hello: tutprog_hello.dats ; \
  $(PATSCC) -I./../../.. $(XRCFLAGS) -o $@ $< $(XRLIBS)
regress:: tutprog_hello; ./$<
cleanall:: ; $(RMF) tutprog_hello

######

all:: tutprog_sqrcirc
tutprog_sqrcirc: tutprog_sqrcirc.dats ; \
  $(PATSCC) -I./../../.. $(XRCFLAGS) -o $@ $< $(XRLIBS)
regress:: tutprog_sqrcirc; ./$<
cleanall:: ; $(RMF) tutprog_sqrcirc

######

all:: tutprog_showtext
tutprog_showtext: tutprog_showtext.dats ; \
  $(PATSCC) -I./../../.. $(XRCFLAGS) -o $@ $< $(XRLIBS)
regress:: tutprog_showtext; ./$<
cleanall:: ; $(RMF) tutprog_showtext

######

all:: tutprog_linecap
tutprog_linecap: tutprog_linecap.dats ; \
  $(PATSCC) -I./../../.. $(XRCFLAGS) -o $@ $< $(XRLIBS)
regress:: tutprog_linecap; ./$<
cleanall:: ; $(RMF) tutprog_linecap

all:: tutprog_linejoin
tutprog_linejoin: tutprog_linejoin.dats ; \
  $(PATSCC) -I./../../.. $(XRCFLAGS) -o $@ $< $(XRLIBS)
cleanall:: ; $(RMF) tutprog_linejoin

######

all:: illuwavy
illuwavy: illuwavy.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I./../../.. $(XRCFLAGS) -o $@ $< -lm $(XRLIBS)
regress:: illuwavy; ./$<
cleanall:: ; $(RMF) illuwavy

all:: illucircmot
illucircmot: illucircmot.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I./../../.. $(XRCFLAGS) -o $@ $< -lm $(XRLIBS)
regress:: illucircmot; ./$<
cleanall:: ; $(RMF) illucircmot

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) *.png

###### end of [Makefile] ######
