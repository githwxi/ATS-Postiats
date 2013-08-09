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

Hello:: Hello.h
Hello:: Hello.class
Hello:: libHello_dats.so

######

Hello.h: Hello.class ; javah Hello
Hello.class: Hello.java ; javac $<
Hello_dats.o: Hello.dats; \
  $(PATSCC) -IIATS $(PATSHOME)/contrib -I $(JNIincl) -fPIC -c Hello.dats
libHello_dats.so: Hello_dats.o ; gcc -shared -o $@ -Wl,-soname,$@ $< -ldl

######

RMF=rm -f

######

clean::; $(RMF) *~
clean::; $(RMF) Hello.h
clean::; $(RMF) Hello_dats.o
clean::; $(RMF) Hello_dats.c

cleanall:: clean
cleanall::; $(RMF) Hello.class
cleanall:: ; $(RMF) libHello_dats.so

######

###### end of [Makefile] ######
