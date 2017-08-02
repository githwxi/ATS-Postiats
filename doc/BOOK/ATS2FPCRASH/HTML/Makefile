#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

.PHONY: htmltoc

######

htmltoc:: htmltoc.exe; ./$< c*.html
htmltoc:: htmltoc.exe; ./$< f*.html
htmltoc:: htmltoc.exe; ./$< p*.html
htmltoc:: htmltoc.exe; ./$< x*.html
htmltoc:: htmltoc.exe; ./$< book1.html

######

htmltoc.exe: htmltoc.dats; $(PATSCC) -o $@ $<

######

synhilit:: synhilit.exe; ./$< c*.html
synhilit:: synhilit.exe; ./$< f*.html
synhilit:: synhilit.exe; ./$< p*.html
synhilit:: synhilit.exe; ./$< x*.html
synhilit:: synhilit.exe; ./$< book1.html

######

synhilit.exe: synhilit.dats; $(PATSCC) -o $@ $<

######
#
upload:: \
upload_html
upload_html:: ; \
rsync -av --delete HTMLTOC ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2FPCRASH/HTML/
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) ./*.html.bak

######

cleanall:: clean
cleanall:: ; $(RMF) htmltoc.exe
cleanall:: ; $(RMF) synhilit.exe
cleanall:: ; $(RMF) HTMLTOC/p*.html
cleanall:: ; $(RMF) HTMLTOC/f*.html
cleanall:: ; $(RMF) HTMLTOC/c*.html
cleanall:: ; $(RMF) HTMLTOC/x*.html
cleanall:: ; $(RMF) HTMLTOC/book1.html

###### end of [Makefile] ######
