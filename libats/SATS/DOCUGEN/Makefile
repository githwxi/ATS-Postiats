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

ATSGCFLAG=-D_ATS_GCATS

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

all_html:: HTML/gnode.html
HTML/gnode.html:   gnode_atxt.exe ; $(CAT) ../gnode.sats | ./$< > $@
gnode_atxt.txt: gnode.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gnode_atxt.exe: htmlgendecl_atxt.dats   gnode_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gnode:: ;   scp HTML/gnode.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gnode_atxt.exe
cleanall:: ; $(RMF) HTML/gnode.html

all_html:: HTML/gflist.html
HTML/gflist.html:   gflist_atxt.exe ; $(CAT) ../gflist.sats | ./$< > $@
gflist_atxt.txt: gflist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_atxt.exe: htmlgendecl_atxt.dats   gflist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gflist:: ;   scp HTML/gflist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_atxt.exe
cleanall:: ; $(RMF) HTML/gflist.html

all_html:: HTML/gflist_vt.html
HTML/gflist_vt.html:   gflist_vt_atxt.exe ; $(CAT) ../gflist_vt.sats | ./$< > $@
gflist_vt_atxt.txt: gflist_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_vt_atxt.exe: htmlgendecl_atxt.dats   gflist_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gflist_vt:: ;   scp HTML/gflist_vt.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_vt_atxt.exe
cleanall:: ; $(RMF) HTML/gflist_vt.html

all_html:: HTML/gfarray.html
HTML/gfarray.html:   gfarray_atxt.exe ; $(CAT) ../gfarray.sats | ./$< > $@
gfarray_atxt.txt: gfarray.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gfarray_atxt.exe: htmlgendecl_atxt.dats   gfarray_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gfarray:: ;   scp HTML/gfarray.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gfarray_atxt.exe
cleanall:: ; $(RMF) HTML/gfarray.html

all_html:: HTML/ilist_prf.html
HTML/ilist_prf.html:   ilist_prf_atxt.exe ; $(CAT) ../ilist_prf.sats | ./$< > $@
ilist_prf_atxt.txt: ilist_prf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
ilist_prf_atxt.exe: htmlgendecl_atxt.dats   ilist_prf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_ilist_prf:: ;   scp HTML/ilist_prf.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) ilist_prf_atxt.exe
cleanall:: ; $(RMF) HTML/ilist_prf.html

all_html:: HTML/funmap_list.html
HTML/funmap_list.html:   funmap_list_atxt.exe ; $(CAT) ../funmap_list.sats | ./$< > $@
funmap_list_atxt.txt: funmap_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_list_atxt.exe: htmlgendecl_atxt.dats   funmap_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funmap_list:: ;   scp HTML/funmap_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funmap_list_atxt.exe
cleanall:: ; $(RMF) HTML/funmap_list.html

all_html:: HTML/funmap_avltree.html
HTML/funmap_avltree.html:   funmap_avltree_atxt.exe ; $(CAT) ../funmap_avltree.sats | ./$< > $@
funmap_avltree_atxt.txt: funmap_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_avltree_atxt.exe: htmlgendecl_atxt.dats   funmap_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funmap_avltree:: ;   scp HTML/funmap_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funmap_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/funmap_avltree.html

all_html:: HTML/funset_avltree.html
HTML/funset_avltree.html:   funset_avltree_atxt.exe ; $(CAT) ../funset_avltree.sats | ./$< > $@
funset_avltree_atxt.txt: funset_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_avltree_atxt.exe: htmlgendecl_atxt.dats   funset_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funset_avltree:: ;   scp HTML/funset_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funset_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/funset_avltree.html

all_html:: HTML/funset_listord.html
HTML/funset_listord.html:   funset_listord_atxt.exe ; $(CAT) ../funset_listord.sats | ./$< > $@
funset_listord_atxt.txt: funset_listord.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_listord_atxt.exe: htmlgendecl_atxt.dats   funset_listord_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funset_listord:: ;   scp HTML/funset_listord.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funset_listord_atxt.exe
cleanall:: ; $(RMF) HTML/funset_listord.html

all_html:: HTML/funralist_nested.html
HTML/funralist_nested.html:   funralist_nested_atxt.exe ; $(CAT) ../funralist_nested.sats | ./$< > $@
funralist_nested_atxt.txt: funralist_nested.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funralist_nested_atxt.exe: htmlgendecl_atxt.dats   funralist_nested_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funralist_nested:: ;   scp HTML/funralist_nested.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funralist_nested_atxt.exe
cleanall:: ; $(RMF) HTML/funralist_nested.html

all_html:: HTML/fundeque_fingertree.html
HTML/fundeque_fingertree.html:   fundeque_fingertree_atxt.exe ; $(CAT) ../fundeque_fingertree.sats | ./$< > $@
fundeque_fingertree_atxt.txt: fundeque_fingertree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
fundeque_fingertree_atxt.exe: htmlgendecl_atxt.dats   fundeque_fingertree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_fundeque_fingertree:: ;   scp HTML/fundeque_fingertree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) fundeque_fingertree_atxt.exe
cleanall:: ; $(RMF) HTML/fundeque_fingertree.html

all_html:: HTML/linmap_list.html
HTML/linmap_list.html:   linmap_list_atxt.exe ; $(CAT) ../linmap_list.sats | ./$< > $@
linmap_list_atxt.txt: linmap_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_list_atxt.exe: htmlgendecl_atxt.dats   linmap_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linmap_list:: ;   scp HTML/linmap_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_list_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_list.html

all_html:: HTML/linmap_randbst.html
HTML/linmap_randbst.html:   linmap_randbst_atxt.exe ; $(CAT) ../linmap_randbst.sats | ./$< > $@
linmap_randbst_atxt.txt: linmap_randbst.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_randbst_atxt.exe: htmlgendecl_atxt.dats   linmap_randbst_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linmap_randbst:: ;   scp HTML/linmap_randbst.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_randbst_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_randbst.html

all_html:: HTML/linmap_skiplist.html
HTML/linmap_skiplist.html:   linmap_skiplist_atxt.exe ; $(CAT) ../linmap_skiplist.sats | ./$< > $@
linmap_skiplist_atxt.txt: linmap_skiplist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_skiplist_atxt.exe: htmlgendecl_atxt.dats   linmap_skiplist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linmap_skiplist:: ;   scp HTML/linmap_skiplist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_skiplist_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_skiplist.html

all_html:: HTML/linheap_binomial.html
HTML/linheap_binomial.html:   linheap_binomial_atxt.exe ; $(CAT) ../linheap_binomial.sats | ./$< > $@
linheap_binomial_atxt.txt: linheap_binomial.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linheap_binomial_atxt.exe: htmlgendecl_atxt.dats   linheap_binomial_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linheap_binomial:: ;   scp HTML/linheap_binomial.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linheap_binomial_atxt.exe
cleanall:: ; $(RMF) HTML/linheap_binomial.html

all_html:: HTML/linheap_fibonacci.html
HTML/linheap_fibonacci.html:   linheap_fibonacci_atxt.exe ; $(CAT) ../linheap_fibonacci.sats | ./$< > $@
linheap_fibonacci_atxt.txt: linheap_fibonacci.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linheap_fibonacci_atxt.exe: htmlgendecl_atxt.dats   linheap_fibonacci_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linheap_fibonacci:: ;   scp HTML/linheap_fibonacci.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linheap_fibonacci_atxt.exe
cleanall:: ; $(RMF) HTML/linheap_fibonacci.html

all_html:: HTML/linqueue_list.html
HTML/linqueue_list.html:   linqueue_list_atxt.exe ; $(CAT) ../linqueue_list.sats | ./$< > $@
linqueue_list_atxt.txt: linqueue_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linqueue_list_atxt.exe: htmlgendecl_atxt.dats   linqueue_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_linqueue_list:: ;   scp HTML/linqueue_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linqueue_list_atxt.exe
cleanall:: ; $(RMF) HTML/linqueue_list.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
