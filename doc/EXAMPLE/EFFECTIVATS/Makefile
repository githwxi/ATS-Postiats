#
# A simple Makefile
#

######

all::

all:: \
file-copying
file-copying:: ; make -C file-copying all

all:: \
loop-as-tailrec
loop-as-tailrec:: ; make -C loop-as-tailrec all

all:: \
HanoiTowers
HanoiTowers:: ; make -C HanoiTowers all

all:: \
word-counting
word-counting:: ; make -C word-counting all

all:: \
stack-array
stack-array:: ; make -C stack-array all

all:: \
queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 all

all:: \
mergesort
mergesort:: ; make -C mergesort all

all:: \
sorting-linear-lists
sorting-linear-lists:: ; make -C sorting-linear-lists all

all:: \
DiningPhil
DiningPhil:: ; make -C DiningPhil all

all:: \
DiningPhil2
DiningPhil2:: ; make -C DiningPhil2 all

all:: \
Producer-Consumer
Producer-Consumer:: ; make -C Producer-Consumer all

all:: \
Readers-and-Writers
Readers-and-Writers:: ; make -C Readers-and-Writers all

all:: \
IPC-hiredis
IPC-hiredis:: ; make -C IPC-hiredis all

all:: \
http-server
http-server:: ; make -C http-server all

all:: \
Sierpinski-3angle
Sierpinski-3angle:: ; make -C Sierpinski-3angle all

all:: \
PwTP-bool-vs-prop
PwTP-bool-vs-prop:: ; make -C PwTP-bool-vs-prop all

all:: \
parsing-cmbntr-cps
parsing-cmbntr-cps:: ; make -C parsing-cmbntr-cps all

all:: \
ssntyped-channels-1
ssntyped-channels-1:: ; make -C ssntyped-channels-1 all

all:: \
ssntyped-channels-2
ssntyped-channels-2:: ; make -C ssntyped-channels-2 all

######

cleanall::
cleanall:: ; make -C file-copying cleanall
cleanall:: ; make -C prop-logic cleanall
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

######

uploadall::
uploadall::upload_index
uploadall::upload_file-copying
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

######

SCP=scp

######

upload_index:: ; \
  $(SCP) \
  ./index.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/

######

upload_file-copying:: ; \
  $(SCP) \
  file-copying/index.html \
  file-copying/Makefile file-copying/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_prop-logic:: ; \
  $(SCP) \
  prop-logic/index.html \
  prop-logic/Makefile prop-logic/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/prop-logic/

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

###### end of [Makefile] ######
