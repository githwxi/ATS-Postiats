######
#
# A simple Makefile
#
######

CPF=cp -f
MVF=mv -f
RMF=rm -f
MAKE=make

######

all:: build

######

build:: ; $(MAKE) -C BUILD all

######

upload:: ; \
$(MVF) BUILD/libatsopt.a ccomp/atslib/lib/.

######
#
copysrc:: ; \
$(CPF) ${PATSHOME}/src/pats_*.?ats ./BUILD/src
copysrc:: ; \
$(CPF) ${PATSHOME}/utils/libatsopt/DATS/* BUILD/DATS/.
#
######
#
clean:: ; $(RMF) ./BUILD/libatsopt.a
clean:: ; $(RMF) ./BUILD/src/libatsopt.a
#
clean:: ; $(RMF) ./BUILD/patsopt*_dats.c
clean:: ; $(RMF) ./BUILD/patsopt*_dats.o
#
clean:: ; $(RMF) ./BUILD/src/pats_*_?ats.c
clean:: ; $(RMF) ./BUILD/src/pats_*_?ats.o
#
cleanall:: ; $(RMF) ./BUILD/DATS/*
cleanall:: ; $(RMF) ./BUILD/src/pats_*.?ats
cleanall:: ; $(RMF) ./ccomp/atslib/lib/libatsopt.a
#
cleanall:: ; $(MAKE) -C BUILD -f Makefile cleanall
cleanall:: ; $(MAKE) -C BUILD/src -f Makefile cleanall
#
###### end of [Makefile] ######
