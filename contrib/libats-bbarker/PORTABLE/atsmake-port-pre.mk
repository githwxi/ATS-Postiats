#
# For building Makefiles for portable projects in ATS 
#

######

ifndef PATSHOME
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

#PATSHOMERELOC - should be set to PATSHOME for git repo?
ifndef PATSHOMERELOC
  PATSHOMERELOCQ="$(PATSHOME)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib
#PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib64

######

CFLAGS += -D_GNU_SOURCE -std=c99 -D_XOPEN_SOURCE

######

LDFLAGS += -Xlinker --allow-multiple-definition 
LDFLAGS += -L$(PATSLIB) -latslib

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

ifndef PATSHOMERELOCQ
else
INCLUDE_ATS += -IIATS $(PATSHOMERELOCQ)/contrib
endif

######

all::
cleanats::
cleanall::

######

SOURCES_SATS=
SOURCES_DATS=

######

###### end of [atsmake-pre.mk] ######
