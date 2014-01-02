######

#
# A minimal makefile for generating portable C code
#

######

#
# These are the only lines that should need to be changed
# for different environments.
#

CC = gcc
CCDEPFLAG = -c -MM -MF
ATSDEPDIR = ATSDEPCOPIES

######

all:: atsmake-port-pre.mk atsmake-port-post.mk $(ATSDEPDIR)
$(ATSDEPDIR):
	mkdir $(ATSDEPDIR)	
atsmake-port-pre.mk: $(PATSHOME)/share/atsmake-port-pre.mk
	cp $(PATSHOME)/share/atsmake-port-pre.mk ./
atsmake-port-post.mk: $(PATSHOME)/share/atsmake-port-post.mk
	cp $(PATSHOME)/share/atsmake-port-post.mk ./

######

include atsmake-port-pre.mk

######

CFLAGS += -O2
LDFLAGS += -lm 

######

SOURCES_DATS += \
  hello.dats \

######

MYTARGET=hello

######

include atsmake-port-post.mk

######

###### end of [Makefile] ######
