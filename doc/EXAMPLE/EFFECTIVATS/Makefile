#
# A simple Makefile
#

######
#
TARGET=all
#
# TARGET=main.html
#
# TARGET=all upload_main
#
######

all::

all :: \
prop-logic
prop-logic:: ; \
make -C $@ $(TARGET)

all :: \
file-copying
file-copying:: ; \
make -C $@ $(TARGET)

all :: \
list-folding
list-folding:: ; \
make -C $@ $(TARGET)

all :: \
loop-as-tailrec
loop-as-tailrec:: ; \
make -C $@ $(TARGET)

all :: \
HanoiTowers
HanoiTowers:: ; \
make -C $@ $(TARGET)

all :: \
word-counting
word-counting:: ; \
make -C $@ $(TARGET)

all :: \
stack-array
stack-array:: ; \
make -C $@ $(TARGET)

all :: \
queue-sllist2
queue-sllist2:: ; \
make -C $@ $(TARGET)

all :: \
mergesort
mergesort:: ; \
make -C $@ $(TARGET)

all :: \
sorting-linear-lists
sorting-linear-lists:: ; \
make -C $@ $(TARGET)

all :: \
DiningPhil
DiningPhil:: ; \
make -C $@ $(TARGET)

all :: \
DiningPhil2
DiningPhil2:: ; \
make -C $@ $(TARGET)

all :: \
Producer-Consumer
Producer-Consumer:: ; \
make -C $@ $(TARGET)

all :: \
Readers-and-Writers
Readers-and-Writers:: ; \
make -C $@ $(TARGET)

all :: \
IPC-hiredis
IPC-hiredis:: ; \
make -C $@ $(TARGET)

# all :: \
# http-server
# http-server:: ; \
# make -C $@ $(TARGET)

all :: \
Sierpinski-3angle
Sierpinski-3angle:: ; \
make -C $@ $(TARGET)

all :: \
PwTP-bool-vs-prop
PwTP-bool-vs-prop:: ; \
make -C $@ $(TARGET)

all :: \
parsing-cmbntr-cps
parsing-cmbntr-cps:: ; \
make -C $@ $(TARGET)

all :: \
ssntyped-channels-1
ssntyped-channels-1:: ; \
make -C $@ $(TARGET)

all :: \
ssntyped-channels-2
ssntyped-channels-2:: ; \
make -C $@ $(TARGET)

all :: \
linear-streams
linear-streams:: ; \
make -C $@ $(TARGET)

all :: \
FRP-bacon.js
FRP-bacon.js:: ; make -C $@ $(TARGET)

all :: \
funcomb-style
funcomb-style:: ; make -C $@ $(TARGET)

all :: \
GraphSearch
GraphSearch:: ; make -C $@ $(TARGET)

######

cleanall::
cleanall:: ; make -C prop-logic cleanall
cleanall:: ; make -C file-copying cleanall
cleanall:: ; make -C list-folding cleanall
cleanall:: ; make -C loop-as-tailrec cleanall
cleanall:: ; make -C HanoiTowers cleanall
cleanall:: ; make -C word-counting cleanall
cleanall:: ; make -C stack-array cleanall
cleanall:: ; make -C queue-sllist2 cleanall
cleanall:: ; make -C mergesort cleanall
cleanall:: ; make -C sorting-linear-lists cleanall
cleanall:: ; make -C DiningPhil cleanall
cleanall:: ; make -C DiningPhil2 cleanall
cleanall:: ; make -C Producer-Consumer cleanall
cleanall:: ; make -C Readers-and-Writers cleanall
cleanall:: ; make -C IPC-hiredis cleanall
cleanall:: ; make -C http-server cleanall
cleanall:: ; make -C Sierpinski-3angle cleanall
cleanall:: ; make -C PwTP-bool-vs-prop cleanall
cleanall:: ; make -C parsing-cmbntr-cps cleanall
cleanall:: ; make -C ssntyped-channels-1 cleanall
cleanall:: ; make -C ssntyped-channels-2 cleanall
cleanall:: ; make -C linear-streams cleanall
cleanall:: ; make -C FRP-bacon.js cleanall
cleanall:: ; make -C funcomb-style cleanall
cleanall:: ; make -C GraphSearch cleanall

######

uploadall::
uploadall::upload_index
uploadall::upload_prop-logic
uploadall::upload_file-copying
uploadall::upload_list-folding
uploadall::upload_loop-as-tailrec
uploadall::upload_word-counting
uploadall::upload_stack-array
uploadall::upload_queue-sllist2
uploadall::upload_mergesort
uploadall::upload_sorting-linear-lists
uploadall::upload_DiningPhil
uploadall::upload_DiningPhil2
uploadall::upload_Producer-Consumer
uploadall::upload_Readers-and-Writers
uploadall::upload_IPC-hiredis
uploadall::upload_http-server
uploadall::upload_Sierpinski-3angle
uploadall::upload_PwTP-bool-vs-prop
uploadall::upload_parsing-cmbntr-cps
uploadall::upload_ssntyped-channels-1
uploadall::upload_ssntyped-channels-2
uploadall::upload_linear-streams
uploadall::upload_FRP-bacon.js
uploadall::upload_funcomb-style
uploadall::upload_GraphSearch

######

SCP=scp

######

upload_index:: ; \
  $(SCP) \
  ./index.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/

######

upload_prop-logic:: ; \
  $(SCP) \
  prop-logic/index.html \
  prop-logic/Makefile prop-logic/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/prop-logic/

######

upload_file-copying:: ; \
  $(SCP) \
  file-copying/index.html \
  file-copying/Makefile file-copying/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_list-folding:: ; \
  $(SCP) \
  list-folding/index.html \
  list-folding/Makefile list-folding/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/list-folding/

######

upload_loop-as-tailrec:: ; \
  $(SCP) \
  loop-as-tailrec/index.html \
  loop-as-tailrec/Makefile loop-as-tailrec/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

upload_stack-array:: ; \
  $(SCP) \
  stack-array/index.html \
  stack-array/Makefile stack-array/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

upload_queue-sllist2:: ; \
  $(SCP) \
  queue-sllist2/index.html \
  queue-sllist2/Makefile queue-sllist2/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

upload_HanoiTowers:: ; \
  $(SCP) \
  HanoiTowers/index.html \
  HanoiTowers/Makefile \
  HanoiTowers/HanoiTowers-1.dats \
  HanoiTowers/HanoiTowers-2.dats \
  HanoiTowers/HanoiTowers-3.dats \
  HanoiTowers/HanoiTowers_txt.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/HanoiTowers/

######

upload_word-counting:: ; \
  $(SCP) \
  word-counting/index.html \
  word-counting/Makefile word-counting/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

upload_mergesort:: ; \
  $(SCP) \
  mergesort/index.html \
  mergesort/Makefile mergesort/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

upload_sorting-linear-lists:: ; \
  $(SCP) \
  sorting-linear-lists/index.html \
  sorting-linear-lists/Makefile \
  sorting-linear-lists/mylist.dats \
  sorting-linear-lists/mylist_mergesort.dats \
  sorting-linear-lists/mergesort_sllist.dats \
  sorting-linear-lists/mergesort_list_vt.dats \
  sorting-linear-lists/mylist_quicksort.dats \
  sorting-linear-lists/quicksort_sllist.dats \
  sorting-linear-lists/quicksort_list_vt.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/sorting-linear-lists

######

upload_DiningPhil:: ; \
  $(SCP) \
  DiningPhil/index.html \
  DiningPhil/Makefile \
  DiningPhil/DiningPhil.sats \
  DiningPhil/DiningPhil.dats \
  DiningPhil/DiningPhil_fork.dats \
  DiningPhil/DiningPhil_dine.dats \
  DiningPhil/DiningPhil_think.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil/

######

upload_DiningPhil2:: ; \
  $(SCP) \
  DiningPhil2/index.html \
  DiningPhil2/Makefile \
  DiningPhil2/DiningPhil2.sats \
  DiningPhil2/DiningPhil2.dats \
  DiningPhil2/DiningPhil2_fork.dats \
  DiningPhil2/DiningPhil2_mylib.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/

######

upload_Producer-Consumer:: ; \
  $(SCP) \
  Producer-Consumer/index.html \
  Producer-Consumer/Makefile \
  Producer-Consumer/sbuffer.sats \
  Producer-Consumer/sbuffer.dats \
  Producer-Consumer/SharedResource.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Producer-Consumer/

######

upload_Readers-and-Writers:: ; \
  $(SCP) \
  Readers-and-Writers/index.html \
  Readers-and-Writers/Makefile \
  Readers-and-Writers/DB_read_write.sats \
  Readers-and-Writers/DB_read_write.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Readers-and-Writers/

######

upload_IPC-hiredis:: ; \
  $(SCP) \
  IPC-hiredis/index.html \
  IPC-hiredis/Makefile \
  IPC-hiredis/mylib.dats \
  IPC-hiredis/msgchan.sats \
  IPC-hiredis/msgchan.dats \
  IPC-hiredis/params.hats \
  IPC-hiredis/redisContextSetup.dats \
  IPC-hiredis/test_up.dats \
  IPC-hiredis/test_dn.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-hiredis/

######

upload_http-server:: ; \
  $(SCP) \
  http-server/index.html \
  http-server/Makefile \
  http-server/myserver.dats \
  http-server/myserver2.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/http-server

######

upload_Sierpinski-3angle:: ; \
  $(SCP) \
  Sierpinski-3angle/index.html \
  Sierpinski-3angle/Makefile \
  Sierpinski-3angle/Sierpinski-3angle.html \
  Sierpinski-3angle/Sierpinski-3angle-part.dats \
  Sierpinski-3angle/Sierpinski-3angle-final.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Sierpinski-3angle

######

upload_PwTP-bool-vs-prop:: ; \
  $(SCP) \
  PwTP-bool-vs-prop/index.html \
  PwTP-bool-vs-prop/Makefile \
  PwTP-bool-vs-prop/bool-vs-prop.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/PwTP-bool-vs-prop

######

upload_parsing-cmbntr-cps:: ; \
  $(SCP) \
  parsing-cmbntr-cps/index.html \
  parsing-cmbntr-cps/Makefile \
  parsing-cmbntr-cps/tokenizer.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/parsing-cmbntr-cps

######

upload_ssntyped-channels-1:: ; \
  $(SCP) \
  ssntyped-channels-1/index.html \
  ssntyped-channels-1/Makefile \
  ssntyped-channels-1/introxmpl0.dats \
  ssntyped-channels-1/introxmpl1.dats \
  ssntyped-channels-1/introxmpl1_demo.html \
  ssntyped-channels-1/introxmpl1_prtcl.sats \
  ssntyped-channels-1/introxmpl1_client.dats \
  ssntyped-channels-1/introxmpl1_server.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/ssntyped-channels-1

######

upload_ssntyped-channels-2:: ; \
  $(SCP) \
  ssntyped-channels-2/index.html \
  ssntyped-channels-2/Makefile \
  ssntyped-channels-2/multest.html \
  ssntyped-channels-2/multest_prtcl.sats \
  ssntyped-channels-2/multest_client.dats \
  ssntyped-channels-2/multest_server.dats \
  ssntyped-channels-2/introxmpl1.html \
  ssntyped-channels-2/introxmpl1_prtcl.sats \
  ssntyped-channels-2/introxmpl1_client.dats \
  ssntyped-channels-2/introxmpl1_server.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/ssntyped-channels-2

######

upload_linear-streams:: ; \
  $(SCP) \
  linear-streams/index.html \
  linear-streams/Makefile linear-streams/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/linear-streams/

######

upload_FRP-bacon.js:: ; \
  $(SCP) -r \
  FRP-bacon.js/index.html \
  FRP-bacon.js/Makefile FRP-bacon.js/JS \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/FRP-bacon.js/

######

upload_funcomb-style:: ; \
  $(SCP) \
  funcomb-style/index.html \
  funcomb-style/Makefile funcomb-style/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/funcomb-style/

######

upload_GraphSearch:: ; \
  $(SCP) \
  GraphSearch/index.html \
  GraphSearch/Makefile GraphSearch/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/GraphSearch/

######

###### end of [Makefile] ######
