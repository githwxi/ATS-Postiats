#
# For building Makefiles for projects in ATS 
#

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

CFLAGS += -D_GNU_SOURCE

######

LDFLAGS += -L$(PATSLIB) -latslib

######

MEMALLOC_ATS := -DATS_MEMALLOC_LIBC

######

INCLUDE_ATS += -IIATS $(PATSHOMERELOCQ)/contrib

######

all:
cleanats::
cleanall::

######

SOURCES_SATS=
SOURCES_DATS=

######

###### end of [atsmake2-pre.mk] ######
