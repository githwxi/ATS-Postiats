#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)

######

all:: main

######

main:: constraint
main:: main_dats.o parsing.o ; \
  $(PATSCC) $(CFLAGS) -O2 -o $@ ../constraint.o $^ $(LDFLAGS)

######

SOURCES_SATS += \
  parsing.sats \

SOURCES_DATS += \
  parsing.dats \
  parsing_s2rt.dats \
  parsing_s2cst.dats \
  parsing_s2var.dats \
  parsing_s2vvar.dats \
  parsing_s2exp.dats \
  parsing_s3itm.dats \
  parsing_h3ypo.dats \
  parsing_c3nstr.dats \
  parsing_mylib.dats \
  parsing_dynload.dats \

######

MYTARGET=MYTARGET

######

include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS :=
OBJECTS += $(MYTARGET_SATS_O)
OBJECTS += $(MYTARGET_DATS_O)

######

parsing.o: $(OBJECTS) ; ld -r -o $@ $^

######

constraint: ; make -C .. constraint.o

######

testdata: \
TEST/test01_dats.cnstr
TEST/test01_dats.cnstr: \
  TEST/test01.dats ; $(PATSOPT) --constraint-export --typecheck -o $@ -d $<

######

cleanall:: ; $(RMF) main
cleanall:: ; $(RMF) parsing.o
cleanall:: ; $(RMF) TEST/test*_dats.cnstr

######

###### end of [Makefile] ######
