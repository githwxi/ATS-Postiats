#
# A simple Makefile
#
######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHM=$(PATSHOME)
PATSHMSRC=$(PATSHOME)/src

######

pats2html: pats2html.dats; \
  $(ATSCC) -O2 \
    -I $(PATSHMSRC) \
    -IATS $(PATSHM) -IATS $(PATSHMSRC) \
    -o $@ $< -L $(PATSHM)/libatsyntax -latsyntax
cleanall:: ; $(RMF) pats2html

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
