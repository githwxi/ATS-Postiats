######
#
# A simple Makefile
#
######
#
RMF=rm -f
MVF=mv -f
MAKE=make
#
######

all:: build
all:: install

######
#
build:: ; \
$(MAKE) \
-C BUILD -f ../Makefile_build
#
######

install:: ; \
$(MVF) BUILD/patscc ./../../bin

######

cleanall:: ; $(RMF) BUILD/patscc

######

###### end of [Makefile] ######
