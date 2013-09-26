#
# The main Makefile for CBOOT/libc
#

######

CCOMP=gcc

######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

all:: allsrc

######

SOURCES := \
  SATS_errno_sats.c \
  SATS_fcntl_sats.c \
  DATS_fcntl_dats.c \
  SATS_stdarg_sats.c \
  SATS_stdio_sats.c \
  SATS_stdlib_sats.c \
  SATS_string_sats.c \
  SATS_time_sats.c \
  SATS_unistd_sats.c \
  DATS_unistd_dats.c \
  sys_SATS_stat_sats.c \
  sys_SATS_types_sats.c \
  SATS_gmp_sats.c \
  DATS_gmp_dats.c \

######

allsrc:: $(SOURCES)

######

SATS_errno_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/errno.sats
SATS_fcntl_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/fcntl.sats
DATS_fcntl_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libc/DATS/fcntl.dats
SATS_stdarg_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/stdarg.sats
SATS_stdio_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/stdio.sats
SATS_stdlib_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/stdlib.sats
SATS_string_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/string.sats
SATS_time_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/time.sats
SATS_unistd_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/unistd.sats
DATS_unistd_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libc/DATS/unistd.dats
sys_SATS_stat_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/sys/SATS/stat.sats
sys_SATS_types_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/sys/SATS/types.sats
SATS_gmp_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/libc/SATS/gmp.sats
DATS_gmp_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/libc/DATS/gmp.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######


