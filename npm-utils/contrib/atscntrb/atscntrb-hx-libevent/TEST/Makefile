#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

MAKE=make
ATSRELOC2=$(PATSHOME)/bin/atsreloc_wget

######

CFLAGS :=
CFLAGS += -I./../..
CFLAGS += $(shell pkg-config --cflags libevent)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs libevent)

######

all::

######

all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) $(CFLAGS) -o $@ $< $(LDFLAGS)
#
regress:: test00; ./$<
cleanall:: ; $(RMF) test00
#
######

test00-atsreloc: \
test00-atsreloc.dats ; \
$(PATSCC) -DATS PATSRELOCROOT=\\\"./.TEST00\\\" $(CFLAGS) -o $@ $< $(LDFLAGS)
#
test00-atsreloc.mk: ; \
$(PATSOPT) --atsreloc -DATS PATSRELOCROOT=\"./.TEST00\" -d test00-atsreloc.dats | $(ATSRELOC2) --output-w $@
#
test00-atsreloc.wget:: test00-atsreloc.mk ; $(MAKE) -f ./$< wgetall
#
cleanall:: ; $(RMF) test00-atsreloc
cleanall:: ; $(RMF) test00-atsreloc.mk
#
######
#
all:: \
test_download
test_download: \
test_download.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
#
regress:: \
test_download; \
./$< http://www.ats-lang.org/.
cleanall:: ; $(RMF) test_download
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f
RMRF=rm -rf

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMRF) .TEST00

###### end of [Makefile] ######
