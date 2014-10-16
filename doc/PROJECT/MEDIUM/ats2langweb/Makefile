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
all:: Libraries.html
all:: Community.html
all:: Papers.html
all:: Examples.html

######

all:: Patsoptaas.html
all:: Patsoptaas_serve.php

######
#
Home.html:: ; $(PHP) -f LAYOUT/theHome_layout.html > $@
Downloads.html:: ; $(PHP) -f LAYOUT/theDownloads_layout.html > $@
Documents.html:: ; $(PHP) -f LAYOUT/theDocuments_layout.html > $@
Libraries.html:: ; $(PHP) -f LAYOUT/theLibraries_layout.html > $@
Community.html:: ; $(PHP) -f LAYOUT/theCommunity_layout.html > $@
Papers.html:: ; $(PHP) -f LAYOUT/thePapers_layout.html > $@
Examples.html:: ; $(PHP) -f LAYOUT/theExamples_layout.html > $@
#
Patsoptaas.html:: ; \
$(PHP) -f LAYOUT/thePatsoptaas_layout.html > MYDATA/$@
Patsoptaas_serve.php:: ; \
$(PHP) -f LAYOUT/thePatsoptaas_layout.html 1 > SERVER/MYCODE/$@
#
######

cleanall:: ; $(RMF) Home.html
cleanall:: ; $(RMF) Downloads.html
cleanall:: ; $(RMF) Documents.html
cleanall:: ; $(RMF) Libraries.html
cleanall:: ; $(RMF) Community.html
cleanall:: ; $(RMF) Papers.html
cleanall:: ; $(RMF) Examples.html
cleanall:: ; $(RMF) MYDATA/Patsoptaas.html
cleanall:: ; $(RMF) SERVER/MYCODE/Patsoptaas_serve.php

###### end of [Makefile] ######
