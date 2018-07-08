######
#
# A Simple Makefile
#
######

CPF=cp -f
RMF=rm -f
MAKE=make

######

copy::

######

build:: ; \
$(MAKE) -C BUILD -f ../Makefile_build

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
cleanall:: ; $(RMF) ./BUILD/libatsynmark.a
#
######

###### end of [Makefile] ######
