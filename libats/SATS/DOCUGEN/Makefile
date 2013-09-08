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
HTML/gnode.html:   gnode_atxt.exe ; ./$< > $@
gnode_atxt.txt: gnode.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gnode_atxt.exe: htmlgendecl_atxt.dats   gnode_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gnode:: ;   scp HTML/gnode.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gnode_atxt.exe
cleanall:: ; $(RMF) HTML/gnode.html

all_html:: HTML/qlist.html
HTML/qlist.html:   qlist_atxt.exe ; ./$< > $@
qlist_atxt.txt: qlist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
qlist_atxt.exe: htmlgendecl_atxt.dats   qlist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_qlist:: ;   scp HTML/qlist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) qlist_atxt.exe
cleanall:: ; $(RMF) HTML/qlist.html

all_html:: HTML/sllist.html
HTML/sllist.html:   sllist_atxt.exe ; ./$< > $@
sllist_atxt.txt: sllist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
sllist_atxt.exe: htmlgendecl_atxt.dats   sllist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_sllist:: ;   scp HTML/sllist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) sllist_atxt.exe
cleanall:: ; $(RMF) HTML/sllist.html

all_html:: HTML/dllist.html
HTML/dllist.html:   dllist_atxt.exe ; ./$< > $@
dllist_atxt.txt: dllist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
dllist_atxt.exe: htmlgendecl_atxt.dats   dllist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_dllist:: ;   scp HTML/dllist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) dllist_atxt.exe
cleanall:: ; $(RMF) HTML/dllist.html

all_html:: HTML/stkarray.html
HTML/stkarray.html:   stkarray_atxt.exe ; ./$< > $@
stkarray_atxt.txt: stkarray.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
stkarray_atxt.exe: htmlgendecl_atxt.dats   stkarray_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_stkarray:: ;   scp HTML/stkarray.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) stkarray_atxt.exe
cleanall:: ; $(RMF) HTML/stkarray.html

all_html:: HTML/dynarray.html
HTML/dynarray.html:   dynarray_atxt.exe ; ./$< > $@
dynarray_atxt.txt: dynarray.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
dynarray_atxt.exe: htmlgendecl_atxt.dats   dynarray_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_dynarray:: ;   scp HTML/dynarray.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) dynarray_atxt.exe
cleanall:: ; $(RMF) HTML/dynarray.html

all_html:: HTML/refcount.html
HTML/refcount.html:   refcount_atxt.exe ; ./$< > $@
refcount_atxt.txt: refcount.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
refcount_atxt.exe: htmlgendecl_atxt.dats   refcount_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_refcount:: ;   scp HTML/refcount.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) refcount_atxt.exe
cleanall:: ; $(RMF) HTML/refcount.html


all_html:: HTML/ilist_prf.html
HTML/ilist_prf.html:   ilist_prf_atxt.exe ; ./$< > $@
ilist_prf_atxt.txt: ilist_prf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
ilist_prf_atxt.exe: htmlgendecl_atxt.dats   ilist_prf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_ilist_prf:: ;   scp HTML/ilist_prf.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) ilist_prf_atxt.exe
cleanall:: ; $(RMF) HTML/ilist_prf.html

all_html:: HTML/gflist.html
HTML/gflist.html:   gflist_atxt.exe ; ./$< > $@
gflist_atxt.txt: gflist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_atxt.exe: htmlgendecl_atxt.dats   gflist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gflist:: ;   scp HTML/gflist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_atxt.exe
cleanall:: ; $(RMF) HTML/gflist.html

all_html:: HTML/gflist_vt.html
HTML/gflist_vt.html:   gflist_vt_atxt.exe ; ./$< > $@
gflist_vt_atxt.txt: gflist_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_vt_atxt.exe: htmlgendecl_atxt.dats   gflist_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gflist_vt:: ;   scp HTML/gflist_vt.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_vt_atxt.exe
cleanall:: ; $(RMF) HTML/gflist_vt.html

all_html:: HTML/gfarray.html
HTML/gfarray.html:   gfarray_atxt.exe ; ./$< > $@
gfarray_atxt.txt: gfarray.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gfarray_atxt.exe: htmlgendecl_atxt.dats   gfarray_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gfarray:: ;   scp HTML/gfarray.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gfarray_atxt.exe
cleanall:: ; $(RMF) HTML/gfarray.html


all_html:: HTML/gvector.html
HTML/gvector.html:   gvector_atxt.exe ; ./$< > $@
gvector_atxt.txt: gvector.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gvector_atxt.exe: htmlgendecl_atxt.dats   gvector_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gvector:: ;   scp HTML/gvector.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gvector_atxt.exe
cleanall:: ; $(RMF) HTML/gvector.html

all_html:: HTML/gmatrix.html
HTML/gmatrix.html:   gmatrix_atxt.exe ; ./$< > $@
gmatrix_atxt.txt: gmatrix.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gmatrix_atxt.exe: htmlgendecl_atxt.dats   gmatrix_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gmatrix:: ;   scp HTML/gmatrix.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gmatrix_atxt.exe
cleanall:: ; $(RMF) HTML/gmatrix.html

all_html:: HTML/gmatrix_col.html
HTML/gmatrix_col.html:   gmatrix_col_atxt.exe ; ./$< > $@
gmatrix_col_atxt.txt: gmatrix_col.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gmatrix_col_atxt.exe: htmlgendecl_atxt.dats   gmatrix_col_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gmatrix_col:: ;   scp HTML/gmatrix_col.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gmatrix_col_atxt.exe
cleanall:: ; $(RMF) HTML/gmatrix_col.html

all_html:: HTML/gmatrix_row.html
HTML/gmatrix_row.html:   gmatrix_row_atxt.exe ; ./$< > $@
gmatrix_row_atxt.txt: gmatrix_row.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gmatrix_row_atxt.exe: htmlgendecl_atxt.dats   gmatrix_row_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_gmatrix_row:: ;   scp HTML/gmatrix_row.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gmatrix_row_atxt.exe
cleanall:: ; $(RMF) HTML/gmatrix_row.html


all_html:: HTML/funset_listord.html
HTML/funset_listord.html:   funset_listord_atxt.exe ; ./$< > $@
funset_listord_atxt.txt: funset_listord.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_listord_atxt.exe: htmlgendecl_atxt.dats   funset_listord_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funset_listord:: ;   scp HTML/funset_listord.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funset_listord_atxt.exe
cleanall:: ; $(RMF) HTML/funset_listord.html

all_html:: HTML/funset_avltree.html
HTML/funset_avltree.html:   funset_avltree_atxt.exe ; ./$< > $@
funset_avltree_atxt.txt: funset_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_avltree_atxt.exe: htmlgendecl_atxt.dats   funset_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funset_avltree:: ;   scp HTML/funset_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funset_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/funset_avltree.html

all_html:: HTML/funmap_list.html
HTML/funmap_list.html:   funmap_list_atxt.exe ; ./$< > $@
funmap_list_atxt.txt: funmap_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_list_atxt.exe: htmlgendecl_atxt.dats   funmap_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funmap_list:: ;   scp HTML/funmap_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funmap_list_atxt.exe
cleanall:: ; $(RMF) HTML/funmap_list.html

all_html:: HTML/funmap_avltree.html
HTML/funmap_avltree.html:   funmap_avltree_atxt.exe ; ./$< > $@
funmap_avltree_atxt.txt: funmap_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_avltree_atxt.exe: htmlgendecl_atxt.dats   funmap_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funmap_avltree:: ;   scp HTML/funmap_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funmap_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/funmap_avltree.html

all_html:: HTML/fundeque_fngtree.html
HTML/fundeque_fngtree.html:   fundeque_fngtree_atxt.exe ; ./$< > $@
fundeque_fngtree_atxt.txt: fundeque_fngtree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
fundeque_fngtree_atxt.exe: htmlgendecl_atxt.dats   fundeque_fngtree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_fundeque_fngtree:: ;   scp HTML/fundeque_fngtree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) fundeque_fngtree_atxt.exe
cleanall:: ; $(RMF) HTML/fundeque_fngtree.html

all_html:: HTML/funralist_nested.html
HTML/funralist_nested.html:   funralist_nested_atxt.exe ; ./$< > $@
funralist_nested_atxt.txt: funralist_nested.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funralist_nested_atxt.exe: htmlgendecl_atxt.dats   funralist_nested_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funralist_nested:: ;   scp HTML/funralist_nested.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funralist_nested_atxt.exe
cleanall:: ; $(RMF) HTML/funralist_nested.html


all_html:: HTML/linset_listord.html
HTML/linset_listord.html:   linset_listord_atxt.exe ; ./$< > $@
linset_listord_atxt.txt: linset_listord.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linset_listord_atxt.exe: htmlgendecl_atxt.dats   linset_listord_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linset_listord:: ;   scp HTML/linset_listord.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linset_listord_atxt.exe
cleanall:: ; $(RMF) HTML/linset_listord.html

all_html:: HTML/linset_avltree.html
HTML/linset_avltree.html:   linset_avltree_atxt.exe ; ./$< > $@
linset_avltree_atxt.txt: linset_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linset_avltree_atxt.exe: htmlgendecl_atxt.dats   linset_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linset_avltree:: ;   scp HTML/linset_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linset_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/linset_avltree.html

all_html:: HTML/linmap_list.html
HTML/linmap_list.html:   linmap_list_atxt.exe ; ./$< > $@
linmap_list_atxt.txt: linmap_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_list_atxt.exe: htmlgendecl_atxt.dats   linmap_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linmap_list:: ;   scp HTML/linmap_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_list_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_list.html

all_html:: HTML/linmap_avltree.html
HTML/linmap_avltree.html:   linmap_avltree_atxt.exe ; ./$< > $@
linmap_avltree_atxt.txt: linmap_avltree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_avltree_atxt.exe: htmlgendecl_atxt.dats   linmap_avltree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linmap_avltree:: ;   scp HTML/linmap_avltree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_avltree_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_avltree.html

all_html:: HTML/linmap_randbst.html
HTML/linmap_randbst.html:   linmap_randbst_atxt.exe ; ./$< > $@
linmap_randbst_atxt.txt: linmap_randbst.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_randbst_atxt.exe: htmlgendecl_atxt.dats   linmap_randbst_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linmap_randbst:: ;   scp HTML/linmap_randbst.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_randbst_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_randbst.html

all_html:: HTML/linmap_skiplist.html
HTML/linmap_skiplist.html:   linmap_skiplist_atxt.exe ; ./$< > $@
linmap_skiplist_atxt.txt: linmap_skiplist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linmap_skiplist_atxt.exe: htmlgendecl_atxt.dats   linmap_skiplist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linmap_skiplist:: ;   scp HTML/linmap_skiplist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linmap_skiplist_atxt.exe
cleanall:: ; $(RMF) HTML/linmap_skiplist.html

all_html:: HTML/linhashtbl_chain.html
HTML/linhashtbl_chain.html:   linhashtbl_chain_atxt.exe ; ./$< > $@
linhashtbl_chain_atxt.txt: linhashtbl_chain.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linhashtbl_chain_atxt.exe: htmlgendecl_atxt.dats   linhashtbl_chain_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linhashtbl_chain:: ;   scp HTML/linhashtbl_chain.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linhashtbl_chain_atxt.exe
cleanall:: ; $(RMF) HTML/linhashtbl_chain.html

all_html:: HTML/linheap_binomial.html
HTML/linheap_binomial.html:   linheap_binomial_atxt.exe ; ./$< > $@
linheap_binomial_atxt.txt: linheap_binomial.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linheap_binomial_atxt.exe: htmlgendecl_atxt.dats   linheap_binomial_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linheap_binomial:: ;   scp HTML/linheap_binomial.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linheap_binomial_atxt.exe
cleanall:: ; $(RMF) HTML/linheap_binomial.html

all_html:: HTML/linheap_fibonacci.html
HTML/linheap_fibonacci.html:   linheap_fibonacci_atxt.exe ; ./$< > $@
linheap_fibonacci_atxt.txt: linheap_fibonacci.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linheap_fibonacci_atxt.exe: htmlgendecl_atxt.dats   linheap_fibonacci_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linheap_fibonacci:: ;   scp HTML/linheap_fibonacci.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linheap_fibonacci_atxt.exe
cleanall:: ; $(RMF) HTML/linheap_fibonacci.html

all_html:: HTML/lindeque_dllist.html
HTML/lindeque_dllist.html:   lindeque_dllist_atxt.exe ; ./$< > $@
lindeque_dllist_atxt.txt: lindeque_dllist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
lindeque_dllist_atxt.exe: htmlgendecl_atxt.dats   lindeque_dllist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_lindeque_dllist:: ;   scp HTML/lindeque_dllist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) lindeque_dllist_atxt.exe
cleanall:: ; $(RMF) HTML/lindeque_dllist.html

all_html:: HTML/linralist_nested.html
HTML/linralist_nested.html:   linralist_nested_atxt.exe ; ./$< > $@
linralist_nested_atxt.txt: linralist_nested.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
linralist_nested_atxt.exe: htmlgendecl_atxt.dats   linralist_nested_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_linralist_nested:: ;   scp HTML/linralist_nested.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) linralist_nested_atxt.exe
cleanall:: ; $(RMF) HTML/linralist_nested.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
