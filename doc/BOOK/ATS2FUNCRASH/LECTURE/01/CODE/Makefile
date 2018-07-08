######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc

######

all::

######

all:: \
compiling
compiling: ; \
$(MYATSCC) compiling.dats

all:: \
libaccessing
libaccessing: ; \
$(MYATSCC) libaccessing.dats

######

regress:: compiling; ./compiling_dats
regress:: libaccessing; ./libaccessing_dats

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
