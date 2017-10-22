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
$(CPF) mylib.atxt BUILD/.
copy:: ; \
$(CPF) mylib_atexting.dats BUILD/.

######

build:: ; \
$(MAKE) \
-C BUILD -f ../Makefile_build regress

######
#
clean:: ; $(RMF) ./BUILD/*.o
clean:: ; $(RMF) ./BUILD/*.c
clean:: ; $(RMF) ./BUILD/*.dats
clean:: ; $(RMF) ./BUILD/*.atxt
clean:: ; $(RMF) ./BUILD/mylib_atexting
#
######
#
cleanall:: clean
#
######

###### end of [Makefile] ######
