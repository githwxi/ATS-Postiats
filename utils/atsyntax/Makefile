#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

PATSHM=$(PATSHOME)
PATSHMSRC=$(PATSHOME)/src

######

pats2html: pats2html.dats; \
  $(ATSCC) \
    -I $(PATSHMSRC) \
    -IATS $(PATSHM) -IATS $(PATSHMSRC) \
    -o $@ $< -L $(PATSHM)/libatsyntax -latsyntax
cleanall:: ; $(RMF) pats2html

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
