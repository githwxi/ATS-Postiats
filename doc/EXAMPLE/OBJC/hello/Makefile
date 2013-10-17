#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

hello: hello.m print_hello.dats; \
  $(PATSCC) -x objective-c \
    -I/usr/include/GNUstep \
    -D_NATIVE_OBJC_EXCEPTIONS \
    -o $@ $^ -lgnustep-base -fconstant-string-class=NSConstantString

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean
cleanall:: ; rm -f hello

###### end of [Makefile] ######