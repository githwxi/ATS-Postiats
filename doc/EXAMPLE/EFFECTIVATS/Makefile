#
# A simple Makefile
#

######

all::
all::file-copying
file-copying:: ; make -C file-copying all
all::queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 all
word-counting:: ; make -C word-counting all

######

cleanall::
cleanall::file-copying
file-copying:: ; make -C file-copying cleanall
cleanall::queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 cleanall

######

uploadall::
uploadall::upload_file-copying
uploadall::upload_queue-sllist2
uploadall::upload_loop-as-tailrec
uploadall::upload_word-counting

######

upload_file-copying:: ; scp file-copying/* \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_queue-sllist2:: ; scp queue-sllist2/* \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

upload_loop-as-tailrec:: ; scp loop-as-tailrec/* \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

upload_word-counting:: ; scp word-counting/* \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

###### end of [Makefile] ######
