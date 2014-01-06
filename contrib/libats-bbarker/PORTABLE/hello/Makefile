######

#
# A minimal makefile for generating portable C code
#

######


###### Environment Configuration ######

CC = gcc
CCDEPFLAG = -c -MM -MF
ATSDEPDIR = ATSDEPCOPIES

CFLAGS += -O2
#LDFLAGS += -lm 

#######################################

###### Project Configuration ######

SOURCES_DATS  += hello.dats
#SOURCES_SATS +=

######

MYTARGET=hello

###################################

.INTERMEDIATE: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-pre.mk
.INTERMEDIATE: $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-post.mk
.PRECIOUS: atsmake-port-post.mk atsmake-port-pre.mk *_?ats.c \
  $(ATSDEPDIR)

all:: atsmake-port-pre.mk atsmake-port-post.mk $(ATSDEPDIR)

$(ATSDEPDIR):
	mkdir $(ATSDEPDIR)	
atsmake-port-pre.mk: \
  $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-pre.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-pre.mk ./
atsmake-port-post.mk: \
  $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-post.mk
	cp $(PATSHOME)/contrib/libats-bbarker/PORTABLE/atsmake-port-post.mk ./

######

SOURCES_DATS += \
  hello.dats \

######

include atsmake-port-pre.mk   # Mostly environment setup
include atsmake-port-post.mk  # Mostly build rules

###### end of [Makefile] ######
