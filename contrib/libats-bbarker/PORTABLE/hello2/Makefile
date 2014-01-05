#
# A Simple Makefile for portable compilation.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.

###### Environment Configuration ######

CC = gcc

#MYPORTDIR := ./MYPORTDIR #Use if you have ATS2-Postiats-include-X.Y.Z.tgz 
MYPORTDIR := $(PATSHOME) #Use if you have ATS2 installed

CFLAGS += -O2

#LDFLAGS += 

#######################################

###### Project Configuration ######

SOURCES_DATS += hello.dats
#SOURCES_SATS +=

######

MYTARGET=hello

###################################

#We need to guarantee these are copied first.
all:: atsmake-pre.mk atsmake-post.mk

.SECONDARY: atsmake-pre.mk atsmake-post.mk
.PRECIOUS: atsmake-post.mk atsmake-pre.mk *_?ats.c

ifdef PATSHOME
else
atsmake-pre.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk ./
atsmake-post.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk ./
endif

######

include atsmake-pre.mk
include atsmake-post.mk

######

###### end of [Makefile] ######
