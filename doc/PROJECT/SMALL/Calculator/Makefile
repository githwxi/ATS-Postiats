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

SOURCES_SATS += \
  calculator.sats \

SOURCES_DATS += \
  calculator.dats \
  calculator_aexp.dats \
  calculator_token.dats \
  calculator_cstream.dats \
  calculator_tstream.dats \
  calculator_parsing.dats \
  calculator_print.dats \
  calculator_mylib.dats \

######

MYTARGET=calc

######
#
MYPORTDIR=MYPORTDIR
#
#MYPORTCPP=MYPORTCPP
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanall:: ; $(RMF) MYPORTDIR/*

######

###### end of [Makefile] ######
