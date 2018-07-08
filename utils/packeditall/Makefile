######
#
# A Simple Makefile
#
######

make=make
CPRF=cp -rf
RMRF=rm -rf

######

copy:: ; $(CPRF) DATS/* BUILD/.

######

build:: ; \
$(MAKE) -C BUILD -f ../Makefile_build

######

testall:: ; $(MAKE) -C TEST testall 

######

cleanall:: ; $(RMRF) ./BUILD/*.o
cleanall:: ; $(RMRF) ./BUILD/*.c
cleanall:: ; $(RMRF) ./BUILD/*.hats
cleanall:: ; $(RMRF) ./BUILD/*.dats
cleanall:: ; $(RMRF) ./BUILD/main_pack
cleanall:: ; $(RMRF) ./BUILD/main_unpack

######

###### end of [Makefile] ######
