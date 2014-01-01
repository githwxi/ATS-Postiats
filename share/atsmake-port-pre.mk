#
# For building Makefiles for portable projects in ATS 
#

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

#PATSHOMERELOC - should be set to PATSHOME for git repo?
ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(PATSHOME)"
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

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

ifeq ("$(PATSHOMERELOCQ)","")
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
