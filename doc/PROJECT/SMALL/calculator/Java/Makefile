#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
# You may need to change this:
#
JNIincl=/usr/lib/jvm/java-7-openjdk-amd64/include
#
######

Calulator:: Calculator.h
Calculator:: Calculator.class
Calculator:: libCalculator_dats.so

######

Calculator.h: Calculator.class ; javah Calculator
Calculator.class: Calculator.java ; javac $<
Calculator_dats.o: Calculator.dats; \
  $(PATSCC) -IIATS $(PATSHOME)/contrib -I $(JNIincl) -fPIC -c Calculator.dats
libCalculator_dats.so: Calculator_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl

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
