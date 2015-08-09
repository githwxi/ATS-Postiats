#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

LDFLAGS += -lcrypto

######

SOURCES_SATS += packing.sats
SOURCES_SATS += unpacking.sats

######

SOURCES_DATS += packing.dats
SOURCES_DATS += unpacking.dats

######

SOURCES_DATS += main_pack.dats
SOURCES_DATS += main_unpack.dats

######

all:: \
main_pack
main_pack: \
  packing_sats.o \
  packing_dats.o \
  main_pack_dats.o ; $(PATSCC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) main_pack

######

all:: \
main_unpack
main_unpack: \
  unpacking_sats.o \
  unpacking_dats.o \
  main_unpack_dats.o ; $(PATSCC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) main_unpack

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanall:: ; $(RMF) tmp*_*

######

###### end of [Makefile] ######
