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

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CCFLAGS=-fPIC -O2

######

OBJECTS := \
  pats_utils_sats.o \
  pats_utils_dats.o \
  pats_global_sats.o \
  pats_global_dats.o \
  pats_errmsg_sats.o \
  pats_errmsg_dats.o \
  pats_comarg_sats.o \
  pats_comarg_dats.o \
  pats_symbol_dats.o \
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
  pats_trans1_env_sats.o \
  pats_trans1_env_dats.o \
  pats_trans1_error_dats.o \
  pats_trans1_e0xp_dats.o \
  pats2xhtml_sats.o \
  pats2xhtml_dats.o \
  pats2xhtml_level1_dats.o \

######

pats2xhtml: \
  DATS/pats2xhtml_main.dats $(OBJECTS) ; \
  $(ATSCC) -O2 $(INCLUDE) $(INCLATS) \
    -o $@ $< $(OBJECTS) -L $(PATSHOME)/libatsynmark -latsynmark -lgmp
cleanall:: ; $(RMF) pats2xhtml

######

%_sats.o: $(PATSHOME)/src/%.sats
	$(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
%_dats.o: $(PATSHOME)/src/%.dats
	$(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<

######

pats2xhtml_sats.o: \
  SATS/pats2xhtml.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $<

pats2xhtml_dats.o: \
  DATS/pats2xhtml.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $<

pats2xhtml_level1_dats.o: \
  DATS/pats2xhtml_level1.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $<

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
