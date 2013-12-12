#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######
#
# You may need to change this:
#
JNIincl=/usr/lib/jvm/java-7-openjdk-amd64/include
#
######
#
# How to test: java -Djava.library.path=. MyMatrix_test
#
######

MyMatrix:: MyMatrix.h
MyMatrix:: MyMatrix.class
MyMatrix:: MyMatrix_test.class
MyMatrix:: libMyMatrix_dats.so

######

MyMatrix.h: MyMatrix.class ; javah MyMatrix

######

MyMatrix.class: MyMatrix.java ; javac $<
MyMatrix_test.class: MyMatrix_test.java ; javac $<
MyMatrix_dats.o: MyMatrix.sats MyMatrix.dats ; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOME)/contrib -I$(JNIincl) -DATS_MEMALLOC_LIBC -fPIC -c MyMatrix.dats
libMyMatrix_dats.so: MyMatrix_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl -L$(PATSLIB) -latslib

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) MyMatrix_dats.o
clean:: ; $(RMF) MyMatrix_dats.c

cleanall:: clean
cleanall:: ; $(RMF) MyMatrix.h
cleanall:: ; $(RMF) MyMatrix.class
cleanall:: ; $(RMF) MyMatrix_test.class
cleanall:: ; $(RMF) libMyMatrix_dats.so

######

###### end of [Makefile] ######
