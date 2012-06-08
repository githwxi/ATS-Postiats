#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

pats2html: pats2html.dats; \
  $(ATSCC) \
    -I $(PATSHOME)/src \
    -IATS $(PATSHOME) \
    -IATS $(PATSHOME)/src \
    -o $@ $< -L $(PATSHOME)/libatsyntax -latsyntax
cleanall:: ; $(RMF) pats2html

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
