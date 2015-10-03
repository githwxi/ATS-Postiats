#
# A simple Makefile for building libatsopt
#

######
#
# For building libatsopt with libgmp dependency
#
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src cleanall
libatsopt:: ; \
$(MAKE) -C $(PATSHOME)/src libatsopt
#
libatsopt:: ; $(RMF) libatsopt.a
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src CBOOT
#
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT cleanall
libatsopt:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT libatsopt
#
######
#
# For building libatsopt without libgmp dependency
#
libatsopt_min:: ; \
$(MAKE) -C $(PATSHOME)/src cleanall
libatsopt_min:: ; \
$(MAKE) -C $(PATSHOME)/src C3NSTRINTKND=intknd libatsopt
#
libatsopt_min:: ; $(RMF) libatsopt.a
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src CBOOTmin
#
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT cleanall
libatsopt_min:: ; $(MAKE) -C $(PATSHOME)/src/CBOOT libatsopt
#
######

RMF=rm -f
MAKE=make

######

cleanall:: ; $(RMF) libatsopt.a

###### end of [Makefile] ######
