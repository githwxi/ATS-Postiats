#
# A simple Makefile
#
######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"

######

IATS=-IATS $(PATSHOMEQ) -IATS $(PATSHOMEQ)/src

######

CCFLAGS=-fPIC -O2
INCLUDES=-I$(PATSHOMEQ)/src

######

OBJECTS := \
  pats_errmsg_sats.o \
  pats_errmsg_dats.o \
  pats_comarg_sats.o \
  pats_comarg_dats.o \
  pats_filename_dats.o \
  pats_intinf_sats.o \
  pats_effect_sats.o \
  pats_effect_dats.o \
  pats_symmap_sats.o \
  pats_symmap_dats.o \
  pats_symenv_sats.o \
  pats_symenv_dats.o \
  pats_staexp1_sats.o \
  pats_staexp1_dats.o \
  pats_dynexp1_sats.o \
  pats_trans1_sats.o \
  pats_trans1_error_dats.o \
  pats_trans1_e0xp_dats.o \
  pats_trans1_env_sats.o \
  pats_trans1_env_dats.o \
  pats2html_sats.o \
  pats2html_dats.o \
  pats2html_level1_dats.o \

######

pats2html: \
  pats2html_main.dats $(OBJECTS) ; \
  $(ATSCC) -O2 $(INCLUDES) $(IATS) \
    -o $@ $< $(OBJECTS) -L $(PATSHOME)/libatsyntax -latsyntax -lgmp
cleanall:: ; $(RMF) pats2html

######

%_sats.o: $(PATSHOME)/src/%.sats
	$(ATSCC) $(INCLUDES) $(IATS) $(CCFLAGS) -c $<
%_dats.o: $(PATSHOME)/src/%.dats
	$(ATSCC) $(INCLUDES) $(IATS) $(CCFLAGS) -c $<

######

pats2html_sats.o: \
  pats2html.sats ; $(ATSCC) $(IATS) -c $<

pats2html_dats.o: \
  pats2html.dats ; $(ATSCC) $(INCLUDES) $(IATS) -c $<

pats2html_level1_dats.o: \
  pats2html_level1.dats ; $(ATSCC) $(INCLUDES) $(IATS) -c $<

######

Makefile_test: Makefile_test.exe ; ./$< > $@

Makefile_test.exe: Makefile_test_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
Makefile_test_atxt.dats: Makefile_test.atxt
	$(ATSDOC) -do $@ -i $< > Makefile_test_atxt.txt

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile_test.exe

cleanall:: clean

###### end of [Makefile] ######
