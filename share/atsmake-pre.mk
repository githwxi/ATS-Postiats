#
# For building Makefiles for projects in ATS 
#

######
#
# Author: Hongwei Xi
# Author: Ian Denhardt
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
PATSLIB64=$(PATSHOMEQ)/ccomp/atslib/lib64

######
#
#export PATSCCOMP = gcc -D_XOPEN_SOURCE
#
######

INCLUDE += -I$(PATSHOMEQ)
INCLUDE += -I$(PATSHOMEQ)/ccomp/runtime

######

CFLAGS += -D_GNU_SOURCE

######

LDFLAGS += -L$(PATSLIB)
LDFLAGS += -L$(PATSLIB64)
LDFLAGS += -latslib

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

ifeq ("$(PATSHOMERELOCQ)","")
else
INCLUDE += -I$(PATSHOMERELOCQ)/contrib
INCLUDE_ATS += -IATS $(PATSHOMERELOCQ)/contrib
endif

######

SOURCES_SATS=
SOURCES_DATS=

######

all::
cleanats::
cleanall::

######

###### end of [atsmake-pre.mk] ######
