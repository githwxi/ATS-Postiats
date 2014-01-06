#
# A Simple Makefile for portable compilation.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.

######       Environment Configuration      ######

CC = gcc

ifndef PATSHOME
MYPORTDIR := ./MYPORTDIR #Use if you have ATS2-Postiats-include-X.Y.Z.tgz 
else
MYPORTDIR=$(PATSHOME)    #Use if you have ATS2 installed
endif

CFLAGS += -O2

#LDFLAGS += 

######   End of Environment Configuration   ######

######        Project Configuration         ######

SOURCES_DATS  += hello.dats
#SOURCES_SATS +=

######

MYTARGET=hello

######    End of Project Configuration      ######

#We need to guarantee these are copied first.
all:: atsmake-pre.mk 
all:: atsmake-post.mk

.INTERMEDIATE: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk
.INTERMEDIATE: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk
.PRECIOUS: atsmake-post.mk atsmake-pre.mk *_?ats.c

ifdef PATSHOME
atsmake-pre.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk ./
atsmake-post.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk ./
endif

######

include atsmake-pre.mk  # Mostly environment setup
include atsmake-post.mk # Mostly build rules

###### end of [Makefile] ######
