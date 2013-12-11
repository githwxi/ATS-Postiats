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
# How to test: java -Djava.library.path=. GameOf24
#
######

GameOf24:: GameOf24.h
GameOf24:: GameOf24.class
GameOf24:: libGameOf24_dats.so

######

GameOf24.h: GameOf24.class ; javah GameOf24

######

GameOf24.class: GameOf24.java ; javac $<
GameOf24_dats.o: GameOf24.dats; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOME)/contrib -I$(JNIincl) -DATS_MEMALLOC_LIBC -fPIC -c $<
libGameOf24_dats.so: GameOf24_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl -L$(PATSLIB) -latslib

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) GameOf24_dats.o
clean:: ; $(RMF) GameOf24_dats.c

cleanall:: clean
cleanall:: ; $(RMF) GameOf24.h
cleanall:: ; $(RMF) GameOf24.class
cleanall:: ; $(RMF) libGameOf24_dats.so

######

###### end of [Makefile] ######
