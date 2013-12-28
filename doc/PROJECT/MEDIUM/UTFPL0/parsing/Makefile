#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CCOMP=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

CFLAGS :=
CFLAGS += -I $(PATSHOMEQ)
CFLAGS += -I $(PATSHOMEQ)/ccomp/runtime
CFLAGS += -I $(PATSHOMERELOCQ)/contrib
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOMP)"

######

all:: parsing.o

######

SOURCES_SATS += \
  parsing.sats

SOURCES_DATS += \
  parsing.dats \
  parsing_d2cst.dats \
  parsing_d2var.dats \
  parsing_d2sym.dats \
  parsing_p2at.dats \
  parsing_d2exp.dats \
  parsing_d2ecl.dats \

######

OBJECTS :=
OBJECTS += $(SOURCES_SATS)
OBJECTS += $(SOURCES_DATS)
OBJECTS := $(patsubst %.sats, %_sats.o, $(OBJECTS))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

parsing.o: \
  $(OBJECTS) dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC2) $(CFLAGS) -c $<

######

include $(PATSHOME)/share/atsmake-post.mk

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: ; $(RMF) parsing.o

######

###### end of [Makefile] ######
