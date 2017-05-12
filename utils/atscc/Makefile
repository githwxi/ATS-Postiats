######
#
# A Simple Makefile
#
######

CPF=cp -f
RMF=rm -f
MAKE=make

######

copy:: ; \
$(CPF) DATS/*.?ats BUILD/.

######

build:: ; \
$(MAKE) \
-C BUILD -f ../Makefile_build

######

testall:: ; \
$(MAKE) -C TEST testall 

######
#
clean:: ; $(RMF) ./BUILD/*.o
clean:: ; $(RMF) ./BUILD/*.c
clean:: ; $(RMF) ./BUILD/*.?ats
#
######
#
cleanall:: clean
#
cleanall:: ; $(RMF) ./BUILD/atscc
#
######

###### end of [Makefile] ######
