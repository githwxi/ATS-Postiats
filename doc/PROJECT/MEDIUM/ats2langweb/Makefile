#
# Makefile for atslangweb
#

###### beg of [Makefile] ######

PHP=php
CPF=cp -f
RMF=rm -f

######

all:: Home.html
all:: Downloads.html
all:: Documents.html
all:: Papers.html
all:: Examples.html

######
#
Home.html:: ; $(PHP) -f LAYOUT/theHome_layout.html > $@
Downloads.html:: ; $(PHP) -f LAYOUT/theDownloads_layout.html > $@
Documents.html:: ; $(PHP) -f LAYOUT/theDocuments_layout.html > $@
Papers.html:: ; $(PHP) -f LAYOUT/thePapers_layout.html > $@
Examples.html:: ; $(PHP) -f LAYOUT/theExamples_layout.html > $@
#
######

cleanall:: ; $(RMF) Home.html
cleanall:: ; $(RMF) Downloads.html
cleanall:: ; $(RMF) Documents.html
cleanall:: ; $(RMF) Papers.html
cleanall:: ; $(RMF) Examples.html

###### end of [Makefile] ######
