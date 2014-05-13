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
PATSLIB64=$(PATSHOMEQ)/ccomp/atslib/lib64

######

CFLAGS += -D_GNU_SOURCE -std=c99 -D_XOPEN_SOURCE

######

LDFLAGS += -Xlinker --allow-multiple-definition 
LDFLAGS += -L$(PATSLIB) -L$(PATSLIB64) -latslib

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

ifndef PATSHOME
MYPORTDIR=$(ATSDEPDIR)
else
MYPORTDIR=$(PATSHOME)
endif

INCLUDE_ATS += -IATS $(MYPORTDIR)/contrib
INCLUDE_ATS_C := -I$(MYPORTDIR) -I$(MYPORTDIR)/ccomp/runtime 
INCLUDE_ATS_PC := -I$(MYPORTDIR) -I$(MYPORTDIR)/ccomp/runtime

######

all::
cleanats::
cleanall::

###### end of [atsmake-pre.mk] ######
