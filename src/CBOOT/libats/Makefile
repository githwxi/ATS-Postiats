#
# The main Makefile for CBOOT/libats
#

######

CCOMP=gcc

######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

all:: allsrc

######

SOURCES := \
  SATS_funmap_avltree_sats.c \
  DATS_funmap_avltree_dats.c \
  SATS_funset_avltree_sats.c \
  DATS_funset_avltree_dats.c \
  SATS_funset_listord_sats.c \
  DATS_funset_listord_dats.c \
  SATS_funmset_listord_sats.c \
  DATS_funmset_listord_dats.c \
  SATS_hashtable_chain_sats.c \
  DATS_hashtable_chain_dats.c \
  SATS_hashtable_linprb_sats.c \
  DATS_hashtable_linprb_dats.c \
  SATS_linqueue_arr_sats.c \
  DATS_linqueue_arr_dats.c \
  SATS_linqueue_lst_sats.c \
  DATS_linqueue_lst_dats.c \
  ngc_SATS_deque_arr_sats.c \
  ngc_DATS_deque_arr_dats.c \

######

allsrc:: $(SOURCES)

######

SATS_funmap_avltree_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/funmap_avltree.sats
DATS_funmap_avltree_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/funmap_avltree.dats
SATS_funset_avltree_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/funset_avltree.sats
DATS_funset_avltree_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/funset_avltree.dats
SATS_funset_listord_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/funset_listord.sats
DATS_funset_listord_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/funset_listord.dats
SATS_funmset_listord_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/funmset_listord.sats
DATS_funmset_listord_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/funmset_listord.dats
SATS_hashtable_chain_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/hashtable_chain.sats
DATS_hashtable_chain_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/hashtable_chain.dats
SATS_hashtable_linprb_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/hashtable_linprb.sats
DATS_hashtable_linprb_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/hashtable_linprb.dats
SATS_linqueue_arr_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/linqueue_arr.sats
DATS_linqueue_arr_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/linqueue_arr.dats
SATS_linqueue_lst_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/SATS/linqueue_lst.sats
DATS_linqueue_lst_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/DATS/linqueue_lst.dats
ngc_SATS_deque_arr_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libats/ngc/SATS/deque_arr.sats
ngc_DATS_deque_arr_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libats/ngc/DATS/deque_arr.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######


