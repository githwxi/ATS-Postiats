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

INCLATS:=-IATS $(ATSHOMEQ)

######

ATSGCFLAG=-D_ATS_GCATS

######

CAT=cat
CPF=cp -f
RMF=rm -f

######

ATSDIST=ATS-Postiats

######

all::
all_html::
all_script::

######

all_html:: HTML/patsopt_src.html
HTML/patsopt_src.html: patsopt_src_atxt.exe ; ./$< > $@
all_script:: SCRIPT/patsopt_src.bash
SCRIPT/patsopt_src.bash: patsopt_src_atxt.exe ; ./$< > $@
patsopt_src_atxt.dats: ATEXT/patsopt_src.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patsopt_src_atxt.exe: patsopt_src_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patsopt_src_atxt.exe
cleanall:: ; $(RMF) HTML/patsopt_src.html
cleanall:: ; $(RMF) SCRIPT/patsopt_src.bash


all_html:: HTML/atslib_prelude.html
HTML/atslib_prelude.html: atslib_prelude_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atslib_prelude.bash
SCRIPT/atslib_prelude.bash: atslib_prelude_atxt.exe ; ./$< > $@
atslib_prelude_atxt.dats: ATEXT/atslib_prelude.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_prelude_atxt.exe: atslib_prelude_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_prelude_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_prelude.html
cleanall:: ; $(RMF) SCRIPT/atslib_prelude.bash

all_html:: HTML/atslib_libc.html
HTML/atslib_libc.html: atslib_libc_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atslib_libc.bash
SCRIPT/atslib_libc.bash: atslib_libc_atxt.exe ; ./$< > $@
atslib_libc_atxt.dats: ATEXT/atslib_libc.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libc_atxt.exe: atslib_libc_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libc_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libc.html
cleanall:: ; $(RMF) SCRIPT/atslib_libc.bash

all_html:: HTML/atslib_libats.html
HTML/atslib_libats.html: atslib_libats_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atslib_libats.bash
SCRIPT/atslib_libats.bash: atslib_libats_atxt.exe ; ./$< > $@
atslib_libats_atxt.dats: ATEXT/atslib_libats.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_atxt.exe: atslib_libats_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats.bash


all_html:: HTML/ccomp_runtime.html
HTML/ccomp_runtime.html: ccomp_runtime_atxt.exe ; ./$< > $@
all_script:: SCRIPT/ccomp_runtime.bash
SCRIPT/ccomp_runtime.bash: ccomp_runtime_atxt.exe ; ./$< > $@
ccomp_runtime_atxt.dats: ATEXT/ccomp_runtime.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
ccomp_runtime_atxt.exe: ccomp_runtime_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) ccomp_runtime_atxt.exe
cleanall:: ; $(RMF) HTML/ccomp_runtime.html
cleanall:: ; $(RMF) SCRIPT/ccomp_runtime.bash


all_html:: HTML/doc_example_intro.html
HTML/doc_example_intro.html: doc_example_intro_atxt.exe ; ./$< > $@
all_script:: SCRIPT/doc_example_intro.bash
SCRIPT/doc_example_intro.bash: doc_example_intro_atxt.exe ; ./$< > $@
doc_example_intro_atxt.dats: ATEXT/doc_example_intro.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_intro_atxt.exe: doc_example_intro_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_intro_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_intro.html
cleanall:: ; $(RMF) SCRIPT/doc_example_intro.bash

all_html:: HTML/doc_example_atslib.html
HTML/doc_example_atslib.html: doc_example_atslib_atxt.exe ; ./$< > $@
all_script:: SCRIPT/doc_example_atslib.bash
SCRIPT/doc_example_atslib.bash: doc_example_atslib_atxt.exe ; ./$< > $@
doc_example_atslib_atxt.dats: ATEXT/doc_example_atslib.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_atslib_atxt.exe: doc_example_atslib_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_atslib_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_atslib.html
cleanall:: ; $(RMF) SCRIPT/doc_example_atslib.bash

all_html:: HTML/doc_example_misc.html
HTML/doc_example_misc.html: doc_example_misc_atxt.exe ; ./$< > $@
all_script:: SCRIPT/doc_example_misc.bash
SCRIPT/doc_example_misc.bash: doc_example_misc_atxt.exe ; ./$< > $@
doc_example_misc_atxt.dats: ATEXT/doc_example_misc.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_misc_atxt.exe: doc_example_misc_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_misc_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_misc.html
cleanall:: ; $(RMF) SCRIPT/doc_example_misc.bash


######

srcgetall:: srcget_share
srcgetall:: srcget_patsrc
srcgetall:: srcget_atslib
srcgetall:: srcget_ccomp_runtime
srcgetall:: srcget_doc_example

######

srcget_share:: ; \
  $(CPF) ../../share/atspre_staload_tmpdef.hats $(ATSDIST)/share/

######

srcget_patsrc:: SCRIPT/patsopt_src.bash ; bash $<

######

srcget_atslib:: srcget_atslib_prelude
srcget_atslib:: srcget_atslib_libc
srcget_atslib:: srcget_atslib_libats
srcget_atslib_prelude:: SCRIPT/atslib_prelude.bash ; bash $<
srcget_atslib_libc:: SCRIPT/atslib_libc.bash ; bash $<
srcget_atslib_libats:: SCRIPT/atslib_libats.bash ; bash $<

######

srcget_ccomp_runtime:: SCRIPT/ccomp_runtime.bash ; bash $<

######

srcget_doc_example:: srcget_doc_example_intro
srcget_doc_example:: srcget_doc_example_atslib
srcget_doc_example:: srcget_doc_example_misc
srcget_doc_example_intro:: SCRIPT/doc_example_intro.bash ; bash $<
srcget_doc_example_atslib:: SCRIPT/doc_example_atslib.bash ; bash $<
srcget_doc_example_misc:: SCRIPT/doc_example_misc.bash ; bash $<

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
