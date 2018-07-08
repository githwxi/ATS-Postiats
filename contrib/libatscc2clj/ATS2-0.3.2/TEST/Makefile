#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2CLJ=$(PATSHOME)/bin/atscc2clj

######
#
JAVA=java
#
CLOJURE=\
$(JAVA) -Xss4m \
  -cp /usr/share/java/clojure-1.4.jar
#
CLOJURE2=\
$(CLOJURE) clojure.main \
  -i ./../output/libatscc2clj_all.clj
#
######

all::
regress::
cleanall::

######

all:: \
test01
test01: test01_dats.clj
regress:: \
test_test01
test_test01: \
test01_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) test01_dats.clj

######

all:: \
test02
test02: test02_dats.clj
regress:: \
test_test02
test_test02: \
test02_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) test02_dats.clj

######

%_dats.clj: %.dats ; $(PATSOPT) -d $< | $(ATSCC2CLJ) -o $@

######

testall:: all
testall:: regress
testall:: cleanall

######
#
RMF=rm -f
RMRF=rm -rf
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
