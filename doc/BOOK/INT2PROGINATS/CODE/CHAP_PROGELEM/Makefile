#
# A simple Makefile
#

######

PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: misc

######

%: %.dats ; \
  $(PATSOPT) --typecheck --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
cleanall:: clean

######

###### end of [Makefile] ######
