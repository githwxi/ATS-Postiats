#
# For building Makefiles for projects in ATS 
# in a portable fashion.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.


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
INCLUDE += -I$(strip $(MYPORTDIR))
INCLUDE_ATS += -IATS$(strip $(MYPORTDIR))
INCLUDE += -I$(strip $(MYPORTDIR))/contrib
INCLUDE_ATS += -IATS$(strip $(MYPORTDIR))/contrib
INCLUDE += -I$(strip $(MYPORTDIR))/ccomp/runtime
INCLUDE_ATS += -IATS$(strip $(MYPORTDIR))/ccomp/runtime

endif

######

all:
cleanats:
cleanall:

######

SOURCES_SATS=
SOURCES_DATS=

######

###### end of [atsmake-pre.mk] ######



#Notes: 
# Not sure why strip is necessary sometimes for MYPORTDIR. e.g.
# INCLUDE += -I$(strip $(MYPORTDIR))/contrib

# Some rules may not work with new versions of make (search for 
# "3.82" in the makefiles.
