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

all_html:: HTML/patsopt_src_cboot.html
HTML/patsopt_src_cboot.html: patsopt_src_cboot_atxt.exe ; ./$< > $@
all_script:: SCRIPT/patsopt_src_cboot.bash
SCRIPT/patsopt_src_cboot.bash: patsopt_src_cboot_atxt.exe ; ./$< > $@
patsopt_src_cboot_atxt.dats: ATEXT/patsopt_src_cboot.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patsopt_src_cboot_atxt.exe: patsopt_src_cboot_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patsopt_src_cboot_atxt.exe
cleanall:: ; $(RMF) HTML/patsopt_src_cboot.html
cleanall:: ; $(RMF) SCRIPT/patsopt_src_cboot.bash


######

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

all_html:: HTML/atslib_libats_ML.html
HTML/atslib_libats_ML.html: atslib_libats_ML_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atslib_libats_ML.bash
SCRIPT/atslib_libats_ML.bash: atslib_libats_ML_atxt.exe ; ./$< > $@
atslib_libats_ML_atxt.dats: ATEXT/atslib_libats_ML.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_ML_atxt.exe: atslib_libats_ML_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_ML_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_ML.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_ML.bash


######

all_html:: HTML/ccomp_atslib.html
HTML/ccomp_atslib.html: ccomp_atslib_atxt.exe ; ./$< > $@
all_script:: SCRIPT/ccomp_atslib.bash
SCRIPT/ccomp_atslib.bash: ccomp_atslib_atxt.exe ; ./$< > $@
ccomp_atslib_atxt.dats: ATEXT/ccomp_atslib.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
ccomp_atslib_atxt.exe: ccomp_atslib_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) ccomp_atslib_atxt.exe
cleanall:: ; $(RMF) HTML/ccomp_atslib.html
cleanall:: ; $(RMF) SCRIPT/ccomp_atslib.bash

all_html:: HTML/ccomp_runtime.html
HTML/ccomp_runtime.html: ccomp_runtime_atxt.exe ; ./$< > $@
all_script:: SCRIPT/ccomp_runtime.bash
SCRIPT/ccomp_runtime.bash: ccomp_runtime_atxt.exe ; ./$< > $@
ccomp_runtime_atxt.dats: ATEXT/ccomp_runtime.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
ccomp_runtime_atxt.exe: ccomp_runtime_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) ccomp_runtime_atxt.exe
cleanall:: ; $(RMF) HTML/ccomp_runtime.html
cleanall:: ; $(RMF) SCRIPT/ccomp_runtime.bash


######

all_html:: HTML/utils_atscc.html
HTML/utils_atscc.html: utils_atscc_atxt.exe ; ./$< > $@
all_script:: SCRIPT/utils_atscc.bash
SCRIPT/utils_atscc.bash: utils_atscc_atxt.exe ; ./$< > $@
utils_atscc_atxt.dats: ATEXT/utils_atscc.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
utils_atscc_atxt.exe: utils_atscc_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) utils_atscc_atxt.exe
cleanall:: ; $(RMF) HTML/utils_atscc.html
cleanall:: ; $(RMF) SCRIPT/utils_atscc.bash


######

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

all_html:: HTML/doc_example_pcpv.html
HTML/doc_example_pcpv.html: doc_example_pcpv_atxt.exe ; ./$< > $@
all_script:: SCRIPT/doc_example_pcpv.bash
SCRIPT/doc_example_pcpv.bash: doc_example_pcpv_atxt.exe ; ./$< > $@
doc_example_pcpv_atxt.dats: ATEXT/doc_example_pcpv.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_pcpv_atxt.exe: doc_example_pcpv_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_pcpv_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_pcpv.html
cleanall:: ; $(RMF) SCRIPT/doc_example_pcpv.bash


######
#
all_html:: HTML/atscntrb_pcre.html
HTML/atscntrb_pcre.html: atscntrb_pcre_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_pcre.bash
SCRIPT/atscntrb_pcre.bash: atscntrb_pcre_atxt.exe ; ./$< > $@
atscntrb_pcre_atxt.dats: ATEXT/atscntrb_pcre.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_pcre_atxt.exe: atscntrb_pcre_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_pcre_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_pcre.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_pcre.bash

#
all_html:: HTML/atscntrb_libgmp.html
HTML/atscntrb_libgmp.html: atscntrb_libgmp_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_libgmp.bash
SCRIPT/atscntrb_libgmp.bash: atscntrb_libgmp_atxt.exe ; ./$< > $@
atscntrb_libgmp_atxt.dats: ATEXT/atscntrb_libgmp.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_libgmp_atxt.exe: atscntrb_libgmp_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_libgmp_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_libgmp.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_libgmp.bash

#
all_html:: HTML/atscntrb_zeromq.html
HTML/atscntrb_zeromq.html: atscntrb_zeromq_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_zeromq.bash
SCRIPT/atscntrb_zeromq.bash: atscntrb_zeromq_atxt.exe ; ./$< > $@
atscntrb_zeromq_atxt.dats: ATEXT/atscntrb_zeromq.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_zeromq_atxt.exe: atscntrb_zeromq_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_zeromq_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_zeromq.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_zeromq.bash

#
all_html:: HTML/atscntrb_libcurl.html
HTML/atscntrb_libcurl.html: atscntrb_libcurl_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_libcurl.bash
SCRIPT/atscntrb_libcurl.bash: atscntrb_libcurl_atxt.exe ; ./$< > $@
atscntrb_libcurl_atxt.dats: ATEXT/atscntrb_libcurl.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_libcurl_atxt.exe: atscntrb_libcurl_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_libcurl_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_libcurl.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_libcurl.bash

#
all_html:: HTML/atscntrb_GTK.html
HTML/atscntrb_GTK.html: atscntrb_GTK_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_GTK.bash
SCRIPT/atscntrb_GTK.bash: atscntrb_GTK_atxt.exe ; ./$< > $@
atscntrb_GTK_atxt.dats: ATEXT/atscntrb_GTK.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_GTK_atxt.exe: atscntrb_GTK_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_GTK_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_GTK.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_GTK.bash

all_html:: HTML/atscntrb_glib.html
HTML/atscntrb_glib.html: atscntrb_glib_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_glib.bash
SCRIPT/atscntrb_glib.bash: atscntrb_glib_atxt.exe ; ./$< > $@
atscntrb_glib_atxt.dats: ATEXT/atscntrb_glib.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_glib_atxt.exe: atscntrb_glib_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_glib_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_glib.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_glib.bash

all_html:: HTML/atscntrb_cairo.html
HTML/atscntrb_cairo.html: atscntrb_cairo_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_cairo.bash
SCRIPT/atscntrb_cairo.bash: atscntrb_cairo_atxt.exe ; ./$< > $@
atscntrb_cairo_atxt.dats: ATEXT/atscntrb_cairo.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_cairo_atxt.exe: atscntrb_cairo_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_cairo_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_cairo.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_cairo.bash

#
all_html:: HTML/atscntrb_json-c.html
HTML/atscntrb_json-c.html: atscntrb_json-c_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_json-c.bash
SCRIPT/atscntrb_json-c.bash: atscntrb_json-c_atxt.exe ; ./$< > $@
atscntrb_json-c_atxt.dats: ATEXT/atscntrb_json-c.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_json-c_atxt.exe: atscntrb_json-c_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_json-c_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_json-c.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_json-c.bash

all_html:: HTML/atscntrb_jansson.html
HTML/atscntrb_jansson.html: atscntrb_jansson_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_jansson.bash
SCRIPT/atscntrb_jansson.bash: atscntrb_jansson_atxt.exe ; ./$< > $@
atscntrb_jansson_atxt.dats: ATEXT/atscntrb_jansson.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_jansson_atxt.exe: atscntrb_jansson_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_jansson_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_jansson.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_jansson.bash

all_html:: HTML/atscntrb_hiredis.html
HTML/atscntrb_hiredis.html: atscntrb_hiredis_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_hiredis.bash
SCRIPT/atscntrb_hiredis.bash: atscntrb_hiredis_atxt.exe ; ./$< > $@
atscntrb_hiredis_atxt.dats: ATEXT/atscntrb_hiredis.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_hiredis_atxt.exe: atscntrb_hiredis_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_hiredis_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_hiredis.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_hiredis.bash

#
all_html:: HTML/atscntrb_JNI.html
HTML/atscntrb_JNI.html: atscntrb_JNI_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_JNI.bash
SCRIPT/atscntrb_JNI.bash: atscntrb_JNI_atxt.exe ; ./$< > $@
atscntrb_JNI_atxt.dats: ATEXT/atscntrb_JNI.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_JNI_atxt.exe: atscntrb_JNI_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_JNI_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_JNI.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_JNI.bash

#
all_html:: HTML/atscntrb_HTML.html
HTML/atscntrb_HTML.html: atscntrb_HTML_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_HTML.bash
SCRIPT/atscntrb_HTML.bash: atscntrb_HTML_atxt.exe ; ./$< > $@
atscntrb_HTML_atxt.dats: ATEXT/atscntrb_HTML.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_HTML_atxt.exe: atscntrb_HTML_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_HTML_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_HTML.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_HTML.bash

all_html:: HTML/atscntrb_HTML_canvas-2d.html
HTML/atscntrb_HTML_canvas-2d.html: atscntrb_HTML_canvas-2d_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_HTML_canvas-2d.bash
SCRIPT/atscntrb_HTML_canvas-2d.bash: atscntrb_HTML_canvas-2d_atxt.exe ; ./$< > $@
atscntrb_HTML_canvas-2d_atxt.dats: ATEXT/atscntrb_HTML_canvas-2d.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_HTML_canvas-2d_atxt.exe: atscntrb_HTML_canvas-2d_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_HTML_canvas-2d_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_HTML_canvas-2d.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_HTML_canvas-2d.bash

#
all_html:: HTML/atscntrb_libatshwxi.html
HTML/atscntrb_libatshwxi.html: atscntrb_libatshwxi_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_libatshwxi.bash
SCRIPT/atscntrb_libatshwxi.bash: atscntrb_libatshwxi_atxt.exe ; ./$< > $@
atscntrb_libatshwxi_atxt.dats: ATEXT/atscntrb_libatshwxi.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_libatshwxi_atxt.exe: atscntrb_libatshwxi_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_libatshwxi_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_libatshwxi.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_libatshwxi.bash

all_html:: HTML/atscntrb_libatshwxi_teaching.html
HTML/atscntrb_libatshwxi_teaching.html: atscntrb_libatshwxi_teaching_atxt.exe ; ./$< > $@
all_script:: SCRIPT/atscntrb_libatshwxi_teaching.bash
SCRIPT/atscntrb_libatshwxi_teaching.bash: atscntrb_libatshwxi_teaching_atxt.exe ; ./$< > $@
atscntrb_libatshwxi_teaching_atxt.dats: ATEXT/atscntrb_libatshwxi_teaching.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atscntrb_libatshwxi_teaching_atxt.exe: atscntrb_libatshwxi_teaching_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atscntrb_libatshwxi_teaching_atxt.exe
cleanall:: ; $(RMF) HTML/atscntrb_libatshwxi_teaching.html
cleanall:: ; $(RMF) SCRIPT/atscntrb_libatshwxi_teaching.bash

#
######

atspackaging:: srcget_home
atspackaging:: srcget_share
atspackaging:: srcget_patsrc
atspackaging:: srcget_patsrc_cboot
atspackaging:: srcget_atslib
atspackaging:: srcget_ccomp_atslib
atspackaging:: srcget_ccomp_runtime
atspackaging:: srcget_utils_atscc
atspackaging:: srcget_doc_example
atspackaging:: ; (cd ATS-Postiats && ./autogen.sh)

######

srcget_home:: ; $(CPF) ../../AUTHORS $(ATSDIST)/
srcget_home:: ; $(CPF) ../../COPYING $(ATSDIST)/
srcget_home:: ; $(CPF) ../../INSTALL $(ATSDIST)/
srcget_home:: ; $(CPF) ../../VERSION.txt $(ATSDIST)/
srcget_home:: ; $(CPF) ../../configure.ac $(ATSDIST)/
srcget_home:: ; $(CPF) ../../config.mk.in $(ATSDIST)/
srcget_home:: ; $(CPF) ../../bin/patscc_env.sh.in $(ATSDIST)/bin/
srcget_home:: ; $(CPF) ../../bin/patsopt_env.sh.in $(ATSDIST)/bin/

######

srcget_share:: ; \
  $(CPF) ../../share/Makefile.gen $(ATSDIST)/share/
srcget_share:: ; \
  $(CPF) ../../share/atspre_define.hats $(ATSDIST)/share/
srcget_share:: ; \
  $(CPF) ../../share/atspre_staload.hats $(ATSDIST)/share/
srcget_share:: ; \
  $(CPF) ../../share/HATS/atspre_define_pkgreloc.hats $(ATSDIST)/share/HATS/
srcget_share:: ; \
  $(CPF) ../../share/HATS/atspre_staload_libats_ML.hats $(ATSDIST)/share/HATS/
srcget_share:: ; $(CPF) ../../share/atsmake-pre.mk $(ATSDIST)/share/
srcget_share:: ; $(CPF) ../../share/atsmake-post.mk $(ATSDIST)/share/

######

srcget_patsrc:: SCRIPT/patsopt_src.bash ; bash $<
srcget_patsrc_cboot:: SCRIPT/patsopt_src_cboot.bash ; bash $<

######

srcget_atslib:: srcget_atslib_prelude
srcget_atslib_prelude:: SCRIPT/atslib_prelude.bash ; bash $<
srcget_atslib:: srcget_atslib_libc
srcget_atslib_libc:: SCRIPT/atslib_libc.bash ; bash $<
srcget_atslib:: srcget_atslib_libats
srcget_atslib_libats:: SCRIPT/atslib_libats.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_ML
srcget_atslib_libats_ML:: SCRIPT/atslib_libats_ML.bash ; bash $<

######

srcget_ccomp_atslib:: SCRIPT/ccomp_atslib.bash ; bash $<
srcget_ccomp_runtime:: SCRIPT/ccomp_runtime.bash ; bash $<

######

srcget_utils_atscc:: SCRIPT/utils_atscc.bash ; bash $<

######

srcget_doc_example:: srcget_doc_example_intro
srcget_doc_example:: srcget_doc_example_atslib
srcget_doc_example:: srcget_doc_example_misc
srcget_doc_example:: srcget_doc_example_pcpv
srcget_doc_example_intro:: SCRIPT/doc_example_intro.bash ; bash $<
srcget_doc_example_atslib:: SCRIPT/doc_example_atslib.bash ; bash $<
srcget_doc_example_misc:: SCRIPT/doc_example_misc.bash ; bash $<
srcget_doc_example_pcpv:: SCRIPT/doc_example_pcpv.bash ; bash $<

######

atscontribing:: srcget_atscntrb

######

srcget_atscntrb:: srcget_atscntrb_pcre
srcget_atscntrb_pcre:: SCRIPT/atscntrb_pcre.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_libgmp
srcget_atscntrb_libgmp:: SCRIPT/atscntrb_libgmp.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_zeromq
srcget_atscntrb_zeromq:: SCRIPT/atscntrb_zeromq.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_libcurl
srcget_atscntrb_libcurl:: SCRIPT/atscntrb_libcurl.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_GTK
srcget_atscntrb_GTK:: SCRIPT/atscntrb_GTK.bash ; bash $<
srcget_atscntrb:: srcget_atscntrb_glib
srcget_atscntrb_glib:: SCRIPT/atscntrb_glib.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_cairo
srcget_atscntrb_cairo:: SCRIPT/atscntrb_cairo.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_json-c
srcget_atscntrb_json-c:: SCRIPT/atscntrb_json-c.bash ; bash $<
srcget_atscntrb:: srcget_atscntrb_jansson
srcget_atscntrb_jansson:: SCRIPT/atscntrb_jansson.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_hiredis
srcget_atscntrb_hiredis:: SCRIPT/atscntrb_hiredis.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_JNI
srcget_atscntrb_JNI:: SCRIPT/atscntrb_JNI.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_HTML
srcget_atscntrb_HTML:: SCRIPT/atscntrb_HTML.bash ; bash $<
srcget_atscntrb:: srcget_atscntrb_HTML_canvas-2d
srcget_atscntrb_HTML_canvas-2d:: SCRIPT/atscntrb_HTML_canvas-2d.bash ; bash $<

######

srcget_atscntrb:: srcget_atscntrb_libatshwxi
srcget_atscntrb_libatshwxi:: SCRIPT/atscntrb_libatshwxi.bash ; bash $<
srcget_atscntrb:: srcget_atscntrb_libatshwxi_teaching
srcget_atscntrb_libatshwxi_teaching:: SCRIPT/atscntrb_libatshwxi_teaching.bash ; bash $<

######

PACKNAME=ATS2-Postiats-0.0.5
atspacktar:: ; rm -rf $(PACKNAME)
atspacktar:: ; cp -rf ATS-Postiats $(PACKNAME)
atspacktar:: ; $(RMF) $(PACKNAME)/Makefile_conf
atspacktar:: ; $(RMF) $(PACKNAME)/missing ; $(CPF) ATS-Postiats/missing $(PACKNAME)/
atspacktar:: ; $(RMF) $(PACKNAME)/install-sh ; $(CPF) ATS-Postiats/install-sh $(PACKNAME)/
atspacktar:: ; make -C $(PACKNAME) cleanall
atspacktar:: ; tar -zvcf  $(PACKNAME).tgz  $(PACKNAME)/

CNTRBNAME=ATS2-Postiats-contrib-0.0.4
atscntrbtar:: ; rm -rf $(CNTRBNAME)
atscntrbtar:: ; cp -rf ATS-Postiats-contrib $(CNTRBNAME)
atscntrbtar:: ; tar -zvcf  $(CNTRBNAME).tgz  $(CNTRBNAME)/

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
