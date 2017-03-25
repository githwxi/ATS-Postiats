#
# A simple Makefile
#
######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
LIBATCC2JS=$(PATSCONTRIB)/contrib/libatscc/libatscc2js
#
######
#
all:: rpc_client_dats.js
all:: rpc_server_dats_.js
#
all:: test_client_dats.js
all:: test_server_dats_.js
#
all:: test2_client_dats.js
all:: test2_server_dats_.js
#
all:: test3_client_dats.js
all:: test3_server_dats_.js
#
######
#
rpc_client_dats.c: rpc_client.dats; $(PATSOPT) -o $@ -d $<
rpc_client_dats.js: rpc_client_dats.c; $(ATSCC2JS) -o $@ -i $<
rpc_server_dats.c: rpc_server.dats; $(PATSOPT) -o $@ -d $<
rpc_server_dats.js: rpc_server_dats.c; $(ATSCC2JS) -o $@ -i $<
rpc_server_dats_.js: rpc_server_dats.js; $(CAT) $(LIBATCC2JS)/output/libatscc2js_all.js $< > $@
#
######
#
test_client_dats.c: test_client.dats; $(PATSOPT) -o $@ -d $<
test_client_dats.js: test_client_dats.c; $(ATSCC2JS) -o $@ -i $<
test_server_dats.c: test_server.dats; $(PATSOPT) -o $@ -d $<
test_server_dats.js: test_server_dats.c; $(ATSCC2JS) -o $@ -i $<
test_server_dats_.js: test_server_dats.js; $(CAT) $(LIBATCC2JS)/output/libatscc2js_all.js $< > $@
#
######
#
test2_client_dats.c: test2_client.dats; $(PATSOPT) -o $@ -d $<
test2_client_dats.js: test2_client_dats.c; $(ATSCC2JS) -o $@ -i $<
test2_server_dats.c: test2_server.dats; $(PATSOPT) -o $@ -d $<
test2_server_dats.js: test2_server_dats.c; $(ATSCC2JS) -o $@ -i $<
test2_server_dats_.js: test2_server_dats.js; $(CAT) $(LIBATCC2JS)/output/libatscc2js_all.js $< > $@
#
######
#
test3_client_dats.c: test3_client.dats; $(PATSOPT) -o $@ -d $<
test3_client_dats.js: test3_client_dats.c; $(ATSCC2JS) -o $@ -i $<
test3_server_dats.c: test3_server.dats; $(PATSOPT) -o $@ -d $<
test3_server_dats.js: test3_server_dats.c; $(ATSCC2JS) -o $@ -i $<
test3_server_dats_.js: test3_server_dats.js; $(CAT) $(LIBATCC2JS)/output/libatscc2js_all.js $< > $@
#
######

CAT=cat
RMF=rm -f

######

testall:: all
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) rpc_client_dats.js
cleanall:: ; $(RMF) rpc_server_dats.js
cleanall:: ; $(RMF) rpc_server_dats_.js
#
cleanall:: ; $(RMF) test_client_dats.js
cleanall:: ; $(RMF) test_server_dats.js
cleanall:: ; $(RMF) test_server_dats_.js
#
cleanall:: ; $(RMF) test2_client_dats.js
cleanall:: ; $(RMF) test2_server_dats.js
cleanall:: ; $(RMF) test2_server_dats_.js
#
cleanall:: ; $(RMF) test3_client_dats.js
cleanall:: ; $(RMF) test3_server_dats.js
cleanall:: ; $(RMF) test3_server_dats_.js
#
###### end of [Makefile] ######
