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

all::

######
#
copy:: ; \
$(CPF) ${PATSHOME}/src/pats_*.?ats ./libatsopt/src
copy:: ; \
$(CPF) ${PATSHOME}/utils/libatsopt/DATS/* libatsopt/DATS/.
#
######

build:: ; \
$(MAKE) -C libatsopt all && \
  $(MVF) libatsopt/libatsopt.a ccomp/atslib/lib/.

######
#
cleanall:: ; $(RMF) ./libatsopt/DATS/*
#
cleanall:: ; $(RMF) ./libatsopt/src/libatsopt.a
#
cleanall:: ; $(RMF) ./libatsopt/patsopt*_dats.c
cleanall:: ; $(RMF) ./libatsopt/patsopt*_dats.o
#
cleanall:: ; $(RMF) ./libatsopt/src/pats_*.?ats
cleanall:: ; $(RMF) ./libatsopt/src/pats_*_?ats.c
cleanall:: ; $(RMF) ./libatsopt/src/pats_*_?ats.o
#
cleanall:: ; $(RMF) ./ccomp/atslib/lib/libatsopt.a
#
###### end of [Makefile] ######
