######
#
# A Simple Makefile
#
######

RMF=rm -f
MAKE=make

######

build:: ; \
$(MAKE) \
-C BUILD \
-f ../Makefile_build

######

testall:: ; \
$(MAKE) -C TEST testall 

######
#
clean:: ; $(RMF) ./BUILD/*.o
clean:: ; $(RMF) ./BUILD/*.c
#
######
#
cleanall:: clean
#
cleanall:: ; $(RMF) ./BUILD/pats2xhtml
#
######

###### end of [Makefile] ######
