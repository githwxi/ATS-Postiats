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

Calculator:: Calculator.h
Calculator:: Calculator.class
Calculator:: libCalculator_dats.so

######

Calculator.h: Calculator.class ; javah Calculator
Calculator.class: Calculator.java ; javac $<
Calculator_dats.o: Calculator.dats; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOME)/contrib -I$(JNIincl) -DATS_MEMALLOC_LIBC -fPIC -c Calculator.dats
libCalculator_dats.so: Calculator_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl -L$(PATSLIB) -latslib

######

RMF=rm -f

######

clean::; $(RMF) *~
clean::; $(RMF) Calculator.h
clean::; $(RMF) Calculator_dats.o
clean::; $(RMF) Calculator_dats.c

cleanall:: clean
cleanall::; $(RMF) Calculator.class
cleanall:: ; $(RMF) libCalculator_dats.so

######

###### end of [Makefile] ######
