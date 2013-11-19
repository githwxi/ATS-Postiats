#
# A simple Makefile
#

######

all::
all::file-copying
file-copying:: ; make -C file-copying all
all::queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 all
all::word-counting
word-counting:: ; make -C word-counting all
all::DiningPhil
DiningPhil:: ; make -C DiningPhil all
all::DiningPhil
DiningPhil2:: ; make -C DiningPhil2 all
all::Producer-Consumer
Producer-Consumer:: ; make -C Producer-Consumer all

######

cleanall::
cleanall:: ; make -C file-copying cleanall
cleanall:: ; make -C queue-sllist2 cleanall
cleanall:: ; make -C loop-as-tailrec cleanall
cleanall:: ; make -C word-counting cleanall
cleanall:: ; make -C DiningPhil cleanall
cleanall:: ; make -C DiningPhil2 cleanall
cleanall:: ; make -C Producer-Consumer cleanall

######

uploadall::
uploadall::upload_stack-array
uploadall::upload_file-copying
uploadall::upload_queue-sllist2
uploadall::upload_loop-as-tailrec
uploadall::upload_word-counting
uploadall::upload_DiningPhil
uploadall::upload_DiningPhil2
uploadall::upload_Producer-Consumer

######

upload_stack-array:: ; \
  scp \
  stack-array/Makefile \
  stack-array/main.html \
  stack-array/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

upload_queue-sllist2:: ; \
  scp \
  queue-sllist2/Makefile \
  queue-sllist2/main.html \
  queue-sllist2/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

upload_file-copying:: ; \
  scp \
  file-copying/Makefile \
  file-copying/main.html \
  file-copying/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_loop-as-tailrec:: ; \
  scp \
  loop-as-tailrec/Makefile \
  loop-as-tailrec/main.html \
  loop-as-tailrec/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

upload_word-counting:: ; \
  scp \
  word-counting/Makefile \
  word-counting/main.html \
  word-counting/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

upload_DiningPhil:: ; \
  scp \
  DiningPhil/Makefile \
  DiningPhil/main.html \
  DiningPhil/DiningPhil.sats \
  DiningPhil/DiningPhil.dats \
  DiningPhil/DiningPhil_fork.dats \
  DiningPhil/DiningPhil_dine.dats \
  DiningPhil/DiningPhil_think.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil/

######

upload_DiningPhil2:: ; \
  scp \
  DiningPhil2/Makefile \
  DiningPhil2/main.html \
  DiningPhil2/DiningPhil2.sats \
  DiningPhil2/DiningPhil2.dats \
  DiningPhil2/DiningPhil2_fork.dats \
  DiningPhil2/DiningPhil2_thread.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/

######

upload_Producer-Consumer:: ; \
  scp \
  Producer-Consumer/Makefile \
  Producer-Consumer/main.html \
  Producer-Consumer/sbuffer.sats \
  Producer-Consumer/sbuffer.dats \
  Producer-Consumer/SharedResource.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Producer-Consumer/

######

###### end of [Makefile] ######
