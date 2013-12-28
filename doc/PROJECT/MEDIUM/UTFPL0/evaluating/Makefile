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

######

PATSCC2=$(PATSCC) -atsccomp "$(CCOMP)"

######

all:: evaluating.o

######

cleanall:: ; $(RMF) evaluating.o

######

SOURCES_SATS += \
  eval.sats

SOURCES_DATS += \
  print.dats \
  cloenv.dats \
  eval_d2cst.dats \
  eval_d2var.dats \
  eval_d2sym.dats \
  eval_d2exp.dats \
  eval_d2ecl.dats \

######

include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS :=
OBJECTS += $(TARGETS_SATS_O)
OBJECTS += $(TARGETS_DATS_O)

######

evaluating.o: \
  $(OBJECTS) dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC2) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC2) $(CFLAGS) -c $<

######

clean:: cleanats

######

###### end of [Makefile] ######
