#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

LDFLAGS :=

######

PATSCCOMP = $(CC) -D_XOPEN_SOURCE

######

SOURCES_SATS += \
  atexting.sats \

SOURCES_DATS += \
  atexting_main.dats \
  atexting_fname.dats \
  atexting_posloc.dats \
  atexting_global.dats \
  atexting_token.dats \

######

MYTARGET=atexing

######
#
MYPORTDIR=MYPORTDIR
#
#MYPORTCPP=MYPORTCPP
#
######
#
atexting_token_fprint.hats: \
atexting.sats atexting_token.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d atexting_token.dats
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

testall:: all
testall:: cleanall

######

cleanall:: ; $(RMF) MYPORTDIR/*

######

###### end of [Makefile] ######
