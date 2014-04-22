#
# A simple Makefile
#

######

all::

all::mergesort
mergesort:: ; make -C mergesort all

all::stack-array
stack-array:: ; make -C stack-array all

all::queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 all

all::loop-as-tailrec
loop-as-tailrec:: ; make -C loop-as-tailrec all

all::file-copying
file-copying:: ; make -C file-copying all

all::word-counting
word-counting:: ; make -C word-counting all

all::DiningPhil
DiningPhil:: ; make -C DiningPhil all

all::DiningPhil
DiningPhil2:: ; make -C DiningPhil2 all

all::Producer-Consumer
Producer-Consumer:: ; make -C Producer-Consumer all

all::IPC-redis
IPC-redis:: ; make -C IPC-redis all

######

cleanall::
cleanall:: ; make -C mergesort cleanall
cleanall:: ; make -C stack-array cleanall
cleanall:: ; make -C queue-sllist2 cleanall
cleanall:: ; make -C loop-as-tailrec cleanall
cleanall:: ; make -C file-copying cleanall
cleanall:: ; make -C word-counting cleanall
cleanall:: ; make -C DiningPhil cleanall
cleanall:: ; make -C DiningPhil2 cleanall
cleanall:: ; make -C Producer-Consumer cleanall
cleanall:: ; make -C IPC-redis cleanall

######

uploadall::
uploadall::upload_mergesort
uploadall::upload_stack-array
uploadall::upload_queue-sllist2
uploadall::upload_loop-as-tailrec
uploadall::upload_file-copying
uploadall::upload_word-counting
uploadall::upload_DiningPhil
uploadall::upload_DiningPhil2
uploadall::upload_Producer-Consumer
uploadall::upload_IPC-redis

######

upload_mergesort:: ; \
  scp \
  mergesort/Makefile \
  mergesort/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

upload_stack-array:: ; \
  scp \
  stack-array/Makefile \
  stack-array/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

upload_queue-sllist2:: ; \
  scp \
  queue-sllist2/Makefile \
  queue-sllist2/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

upload_file-copying:: ; \
  scp \
  file-copying/Makefile \
  file-copying/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_loop-as-tailrec:: ; \
  scp \
  loop-as-tailrec/Makefile \
  loop-as-tailrec/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

upload_word-counting:: ; \
  scp \
  word-counting/Makefile \
  word-counting/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

upload_DiningPhil:: ; \
  scp \
  DiningPhil/Makefile \
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
  DiningPhil2/DiningPhil2.sats \
  DiningPhil2/DiningPhil2.dats \
  DiningPhil2/DiningPhil2_fork.dats \
  DiningPhil2/DiningPhil2_thread.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/

######

upload_Producer-Consumer:: ; \
  scp \
  Producer-Consumer/Makefile \
  Producer-Consumer/sbuffer.sats \
  Producer-Consumer/sbuffer.dats \
  Producer-Consumer/SharedResource.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Producer-Consumer/

######

upload_Readers-and-Writers:: ; \
  scp \
  Readers-and-Writers/Makefile \
  Readers-and-Writers/DB_read_write.sats \
  Readers-and-Writers/DB_read_write.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Readers-and-Writers/

######

upload_IPC-redis:: ; \
  scp \
  IPC-redis/Makefile \
  IPC-redis/mylib.dats \
  IPC-redis/msgchan.sats \
  IPC-redis/msgchan.dats \
  IPC-redis/params.hats \
  IPC-redis/redisContextSetup.dats \
  IPC-redis/test_up.dats \
  IPC-redis/test_dn.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-redis/

######

###### end of [Makefile] ######
