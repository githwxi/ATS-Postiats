######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######
#
CXXFLAGS = $(MYCFLAGS)
#
######
#
MYCFLAGS := -fpermissive -w
#
MYCFLAGS += -DATS_MEMALLOC_LIBC
#
MYCFLAGS += -D_ATS_CCOMP_PRELUDE_NONE_
#
MYCFLAGS += -D_ATS_CCOMP_EXCEPTION_NONE_
MYCFLAGS += -D_ATS_CCOMP_RUNTIME_TRYWITH_NONE_
#
MYCFLAGS += -D_ATS_CCOMP_PRELUDE_USER_='"pats_ats2cpp_prelude.h"'
#
# MYCFLAGS += -D_ATSTYPE_VAR_SIZE_=1024
#
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp/H
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp/ccomp
#
######

CC=gcc
CPP=g++

######

all::

######
#
all:: \
test01
test01: \
test01_dats.c; $(CPP) $(CXXFLAGS) -o $@ $<
test01_dats.c: test01.dats; $(PATSOPT) -o $@ -d $<
#
regress:: test01; ./$<
cleanall:: ; rm -f test01
#
######
#
all:: \
test02
test02: \
test02_dats.c; $(CPP) $(CXXFLAGS) -o $@ $<
test02_dats.c: test02.dats; $(PATSOPT) -o $@ -d $<
#
regress:: test02; ./$<
cleanall:: ; rm -f test02
#
######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *_?ats.o

######

cleanall:: clean

###### end of [Makefile] ######
