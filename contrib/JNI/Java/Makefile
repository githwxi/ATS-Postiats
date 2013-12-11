#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::
all:: ATSarrayptr

######

JNIincl=/usr/lib/jvm/java-7-openjdk-amd64/include

######

ATSarrayptr:: ATSarrayptr.h
ATSarrayptr:: ATSarrayptr.class
ATSarrayptr:: libATSarrayptr_dats.so

######

ATSarrayptr.h: \
  ATSarrayptr.class ; javah ATSarrayptr
ATSarrayptr.class: ATSarrayptr.java ; javac $<
ATSarrayptr_dats.o: ./../DATS/ATSarrayptr.dats; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOMEQ)/contrib -I$(JNIincl) -DATS_MEMALLOC_LIBC -fPIC -c $<
libATSarrayptr_dats.so: ATSarrayptr_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl -L$(PATSLIB) -latslib

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) ATSarrayptr.h
cleanall:: ; $(RMF) ATSarrayptr.class
cleanall:: ; $(RMF) libATSarrayptr_dats.so

###### end of [Makefile] ######

