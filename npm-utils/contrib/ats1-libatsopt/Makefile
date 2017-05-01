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

build:: ; \
$(MAKE) -C libatsopt all && \
  $(CPF) libatsopt/libatsopt.a ccomp/atslib/lib/.

######
#
copysrc:: ; \
$(CPF) ${PATSHOME}/src/pats_*.?ats ./libatsopt/src
copysrc:: ; \
$(CPF) ${PATSHOME}/utils/libatsopt/DATS/* libatsopt/DATS/.
#
######
#
clean:: ; $(RMF) ./libatsopt/libatsopt.a
clean:: ; $(RMF) ./libatsopt/src/libatsopt.a
#
clean:: ; $(RMF) ./libatsopt/patsopt*_dats.c
clean:: ; $(RMF) ./libatsopt/patsopt*_dats.o
#
clean:: ; $(RMF) ./libatsopt/src/pats_*_?ats.c
clean:: ; $(RMF) ./libatsopt/src/pats_*_?ats.o
#
cleanall:: ; $(RMF) ./libatsopt/DATS/*
cleanall:: ; $(RMF) ./libatsopt/src/pats_*.?ats
cleanall:: ; $(RMF) ./ccomp/atslib/lib/libatsopt.a
#
###### end of [Makefile] ######
