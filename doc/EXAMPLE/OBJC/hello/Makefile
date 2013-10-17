#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

hello: hello.m print_hello.dats; $(PATSCC) -o $@ $^ -lobjc

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean
cleanall:: ; rm -f hello

###### end of [Makefile] ######