#
# A Simple Makefile for portable compilation.
#
# By portable, we mean non-dependent on an ATS installation;
# certain settings in the makefiles may need to be adjusted,
# but these should primarily be limited to this file.

###### Primary Configuration ######

CC = gcc

#MYPORTDIR := ./MYPORTDIR #Use if you have ATS2-Postiats-include-X.Y.Z.tgz 
MYPORTDIR := $(PATSHOME) #Use if you have ATS2 installed

######

#We need to guarantee these are copied first.
all: atsmake-pre.mk atsmake-post.mk

.SECONDARY: atsmake-pre.mk atsmake-post.mk
.PRECIOUS: atsmake-post.mk atsmake-pre.mk *_?ats.c

ifeq ("$(PATSHOME)","")
else
atsmake-pre.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-pre.mk ./
atsmake-post.mk: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-post.mk ./
endif

include atsmake-pre.mk

######

CFLAGS += -O2

######

SOURCES_DATS += hello.dats

######

MYTARGET=hello

######

include atsmake-post.mk

######

###### end of [Makefile] ######
