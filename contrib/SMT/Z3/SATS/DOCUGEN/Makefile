#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CAT=cat

######

all:: all_html

######

DECLATEXT= \
  declatext_sats.o \
  declatext_dats.o \

declatext_sats.o: \
  declatext.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
declatext_dats.o: \
  declatext.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

######

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: \
  htmlgendecl.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
htmlgendecl_dats.o: \
  htmlgendecl.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

htmlgendecl_atxt.dats: htmlgendecl.atxt ;   $(ATSDOC) --outcode $@ -i $< > htmlgendecl_atxt.txt

######

all_html::

all_html:: HTML/z3.html
HTML/z3.html:   z3_atxt.exe ; ./$< > $@
z3_atxt.txt: z3.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
z3_atxt.exe: htmlgendecl_atxt.dats   z3_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_z3:: ;   scp HTML/z3.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3
clean:: ; $(RMF) z3_atxt.exe
cleanall:: ; $(RMF) HTML/z3.html

all_html:: HTML/z3_symbol.html
HTML/z3_symbol.html:   z3_symbol_atxt.exe ; ./$< > $@
z3_symbol_atxt.txt: z3_symbol.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
z3_symbol_atxt.exe: htmlgendecl_atxt.dats   z3_symbol_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_z3_symbol:: ;   scp HTML/z3_symbol.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3
clean:: ; $(RMF) z3_symbol_atxt.exe
cleanall:: ; $(RMF) HTML/z3_symbol.html

all_html:: HTML/z3_propeq.html
HTML/z3_propeq.html:   z3_propeq_atxt.exe ; ./$< > $@
z3_propeq_atxt.txt: z3_propeq.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
z3_propeq_atxt.exe: htmlgendecl_atxt.dats   z3_propeq_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_z3_propeq:: ;   scp HTML/z3_propeq.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3
clean:: ; $(RMF) z3_propeq_atxt.exe
cleanall:: ; $(RMF) HTML/z3_propeq.html

all_html:: HTML/z3_stringconv.html
HTML/z3_stringconv.html:   z3_stringconv_atxt.exe ; ./$< > $@
z3_stringconv_atxt.txt: z3_stringconv.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
z3_stringconv_atxt.exe: htmlgendecl_atxt.dats   z3_stringconv_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_z3_stringconv:: ;   scp HTML/z3_stringconv.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3
clean:: ; $(RMF) z3_stringconv_atxt.exe
cleanall:: ; $(RMF) HTML/z3_stringconv.html

all_html:: HTML/z3_solver.html
HTML/z3_solver.html:   z3_solver_atxt.exe ; ./$< > $@
z3_solver_atxt.txt: z3_solver.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
z3_solver_atxt.exe: htmlgendecl_atxt.dats   z3_solver_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_z3_solver:: ;   scp HTML/z3_solver.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3
clean:: ; $(RMF) z3_solver_atxt.exe
cleanall:: ; $(RMF) HTML/z3_solver.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SMT/Z3

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
