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

######

LDFLAGS :=
LDFLAGS += -lev

######

all::
regress::
cleanall::

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) -I./../.. $(CFLAGS) -o $@ $< $(LDFLAGS)
#
regress:: \
test00; ./test00
#
cleanall:: ; $(RMF) test00
#
######
#
all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) -I./../.. $(CFLAGS) -o $@ $< $(LDFLAGS)
#
regress:: \
test01; echo | ./test01
#
cleanall:: ; $(RMF) test01
#
######
# #
# test00-reloc:: \
# test00-reloc.dats ; \
# $(PATSCC) -IIATS ./.TEST00/. \
# -DATS ATSRELOCROOT=\\\".TEST00\\\" $(CFLAGS) -o $@ $< $(LDFLAGS)
# #
# test00-reloc.mk: ; \
# $(PATSOPT) --atsreloc \
# -DATS PATSRELOCROOT=\".TEST00\" -d test00-reloc.dats | $(ATSRELOC2) --output-w $@
# #
# test00-reloc.wget:: test00-reloc.mk ; $(MAKE) -f ./$< wgetall
# #
# cleanall:: ; $(RMF) test00-reloc
# cleanall:: ; $(RMF) test00-reloc.mk
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
