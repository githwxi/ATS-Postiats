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
all:: Arrayptr

######

JNIincl=/usr/lib/jvm/java-7-openjdk-amd64/include

######

Arrayptr:: Arrayptr.h
Arrayptr:: Arrayptr.class
Arrayptr:: libArrayptr_dats.so

######

Arrayptr.h: \
  Arrayptr.class ; javah Arrayptr
Arrayptr.class: Arrayptr.java ; javac $<
Arrayptr_dats.o: ./../DATS/Arrayptr.dats; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOMEQ)/contrib -I$(JNIincl) -DATS_MEMALLOC_LIBC -fPIC -c $<
libArrayptr_dats.so: Arrayptr_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl -L$(PATSLIB) -latslib

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) Arrayptr.h
cleanall:: ; $(RMF) Arrayptr.class
cleanall:: ; $(RMF) libArrayptr_dats.so

###### end of [Makefile] ######

