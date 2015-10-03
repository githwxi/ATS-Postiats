#
# A simple Makefile for building libatsopt
#

######
#
# For building libatsopt with libgmp dependency
#
libatsopt:: ; \
make -C $(PATSHOME)/src cleanall
libatsopt:: ; \
make -C $(PATSHOME)/src libatsopt
#
libatsopt:: ; make -C $(PATSHOME)/src CBOOT
#
libatsopt:: ; make -C $(PATSHOME)/src/CBOOT cleanall
libatsopt:: ; make -C $(PATSHOME)/src/CBOOT libatsopt
#
######
#
# For building libatsopt without libgmp dependency
#
libatsopt_min:: ; \
make -C $(PATSHOME)/src cleanall
libatsopt_min:: ; \
make -C $(PATSHOME)/src C3NSTRINTKND=intknd libatsopt
#
libatsopt_min:: ; make -C $(PATSHOME)/src CBOOTmin
#
libatsopt_min:: ; make -C $(PATSHOME)/src/CBOOT cleanall
libatsopt_min:: ; make -C $(PATSHOME)/src/CBOOT libatsopt
#
######

RMF=rm -f

######

cleanall:: ; $(RMF) libatsopt.a

###### end of [Makefile] ######
