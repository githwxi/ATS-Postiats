#
# For building Makefiles for projects in ATS 
#

######
#
# Author: Hongwei Xi (githwxi)
# Author: Ian Denhardt (zenhack.net)
#
######
#
CC=gcc
#
######

ifdef PATSHOME
  PATSHOMEQ="$(PATSHOME)"
else
ifdef ATSHOME
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="/usr/local/lib/ats2-postiats"
endif
endif

######

ifdef PATSHOMERELOC
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
else
ifdef ATSHOMERELOC
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="/usr/local/lib/ats2-postiats"
endif
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib
PATSLIB64=$(PATSHOMEQ)/ccomp/atslib/lib64

######
#
export \
PATSCCOMP = $(CC) -std=c99 -D_XOPEN_SOURCE
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

EXTRAFLAGS =

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

ifdef PATSHOMERELOCQ
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
