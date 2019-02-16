######
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

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"

######

INCLATS:=-IATS $(ATSHOMEQ)

######
#
GCFLAG=
#
# GCFLAG=-D_ATS_GCATS
#
######

CAT=cat
CPF=cp -f
CPRF=cp -rf
RMF=rm -f
RMRF=rm -rf
MAKE=make
TARZVCF=tar -zvcf

######

ATSDIST=ATS-Postiats

######

all::
all_script::

######

all_script:: \
SCRIPT/patsopt_src.bash
SCRIPT/patsopt_src.bash: patsopt_src_atxt.exe ; ./$< > $@
patsopt_src_atxt.dats: ATEXT/patsopt_src.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patsopt_src_atxt.exe: patsopt_src_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patsopt_src_atxt.exe
cleanall:: ; $(RMF) HTML/patsopt_src.html
cleanall:: ; $(RMF) SCRIPT/patsopt_src.bash

all_script:: \
SCRIPT/patsopt_src_cboot.bash
SCRIPT/patsopt_src_cboot.bash: patsopt_src_cboot_atxt.exe ; ./$< > $@
patsopt_src_cboot_atxt.dats: ATEXT/patsopt_src_cboot.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patsopt_src_cboot_atxt.exe: patsopt_src_cboot_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patsopt_src_cboot_atxt.exe
cleanall:: ; $(RMF) HTML/patsopt_src_cboot.html
cleanall:: ; $(RMF) SCRIPT/patsopt_src_cboot.bash


######

all_script:: \
SCRIPT/ccomp_atslib.bash
SCRIPT/ccomp_atslib.bash: ccomp_atslib_atxt.exe ; ./$< > $@
ccomp_atslib_atxt.dats: ATEXT/ccomp_atslib.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
ccomp_atslib_atxt.exe: ccomp_atslib_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) ccomp_atslib_atxt.exe
cleanall:: ; $(RMF) HTML/ccomp_atslib.html
cleanall:: ; $(RMF) SCRIPT/ccomp_atslib.bash

all_script:: \
SCRIPT/ccomp_runtime.bash
SCRIPT/ccomp_runtime.bash: ccomp_runtime_atxt.exe ; ./$< > $@
ccomp_runtime_atxt.dats: ATEXT/ccomp_runtime.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
ccomp_runtime_atxt.exe: ccomp_runtime_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) ccomp_runtime_atxt.exe
cleanall:: ; $(RMF) HTML/ccomp_runtime.html
cleanall:: ; $(RMF) SCRIPT/ccomp_runtime.bash


######

all_script:: \
SCRIPT/atslib_prelude.bash
SCRIPT/atslib_prelude.bash: atslib_prelude_atxt.exe ; ./$< > $@
atslib_prelude_atxt.dats: ATEXT/atslib_prelude.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_prelude_atxt.exe: atslib_prelude_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_prelude_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_prelude.html
cleanall:: ; $(RMF) SCRIPT/atslib_prelude.bash


######

all_script:: \
SCRIPT/atslib_libats.bash
SCRIPT/atslib_libats.bash: atslib_libats_atxt.exe ; ./$< > $@
atslib_libats_atxt.dats: ATEXT/atslib_libats.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_atxt.exe: atslib_libats_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats.bash

all_script:: \
SCRIPT/atslib_libats_ML.bash
SCRIPT/atslib_libats_ML.bash: atslib_libats_ML_atxt.exe ; ./$< > $@
atslib_libats_ML_atxt.dats: ATEXT/atslib_libats_ML.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_ML_atxt.exe: atslib_libats_ML_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_ML_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_ML.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_ML.bash

all_script:: \
SCRIPT/atslib_libats_libc.bash
SCRIPT/atslib_libats_libc.bash: atslib_libats_libc_atxt.exe ; ./$< > $@
atslib_libats_libc_atxt.dats: ATEXT/atslib_libats_libc.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_libc_atxt.exe: atslib_libats_libc_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_libc_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_libc.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_libc.bash

all_script:: \
SCRIPT/atslib_libats_ATS1.bash
SCRIPT/atslib_libats_ATS1.bash: atslib_libats_ATS1_atxt.exe ; ./$< > $@
atslib_libats_ATS1_atxt.dats: ATEXT/atslib_libats_ATS1.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_ATS1_atxt.exe: atslib_libats_ATS1_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_ATS1_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_ATS1.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_ATS1.bash

all_script:: \
SCRIPT/atslib_libats_ATS2.bash
SCRIPT/atslib_libats_ATS2.bash: atslib_libats_ATS2_atxt.exe ; ./$< > $@
atslib_libats_ATS2_atxt.dats: ATEXT/atslib_libats_ATS2.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_ATS2_atxt.exe: atslib_libats_ATS2_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_ATS2_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_ATS2.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_ATS2.bash

all_script:: \
SCRIPT/atslib_libats_BUCS320.bash
SCRIPT/atslib_libats_BUCS320.bash: atslib_libats_BUCS320_atxt.exe ; ./$< > $@
atslib_libats_BUCS320_atxt.dats: ATEXT/atslib_libats_BUCS320.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
atslib_libats_BUCS320_atxt.exe: atslib_libats_BUCS320_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) atslib_libats_BUCS320_atxt.exe
cleanall:: ; $(RMF) HTML/atslib_libats_BUCS320.html
cleanall:: ; $(RMF) SCRIPT/atslib_libats_BUCS320.bash


######
#
all_script:: \
SCRIPT/contrib_atscntrb.bash
SCRIPT/contrib_atscntrb.bash: contrib_atscntrb_atxt.exe ; ./$< > $@
contrib_atscntrb_atxt.dats: ATEXT/contrib_atscntrb.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscntrb_atxt.exe: contrib_atscntrb_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscntrb_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscntrb.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscntrb.bash

#
######

all_script:: \
SCRIPT/utils_emacs.bash
SCRIPT/utils_emacs.bash: utils_emacs_atxt.exe ; ./$< > $@
utils_emacs_atxt.dats: ATEXT/utils_emacs.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
utils_emacs_atxt.exe: utils_emacs_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) utils_emacs_atxt.exe
cleanall:: ; $(RMF) HTML/utils_emacs.html
cleanall:: ; $(RMF) SCRIPT/utils_emacs.bash

all_script:: \
SCRIPT/utils_atscc.bash
SCRIPT/utils_atscc.bash: utils_atscc_atxt.exe ; ./$< > $@
utils_atscc_atxt.dats: ATEXT/utils_atscc.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
utils_atscc_atxt.exe: utils_atscc_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) utils_atscc_atxt.exe
cleanall:: ; $(RMF) HTML/utils_atscc.html
cleanall:: ; $(RMF) SCRIPT/utils_atscc.bash

all_script:: \
SCRIPT/utils_myatscc.bash
SCRIPT/utils_myatscc.bash: utils_myatscc_atxt.exe ; ./$< > $@
utils_myatscc_atxt.dats: ATEXT/utils_myatscc.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
utils_myatscc_atxt.exe: utils_myatscc_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) utils_myatscc_atxt.exe
cleanall:: ; $(RMF) HTML/utils_myatscc.html
cleanall:: ; $(RMF) SCRIPT/utils_myatscc.bash

all_script:: \
SCRIPT/utils_libatsopt.bash
SCRIPT/utils_libatsopt.bash: utils_libatsopt_atxt.exe ; ./$< > $@
utils_libatsopt_atxt.dats: ATEXT/utils_libatsopt.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
utils_libatsopt_atxt.exe: utils_libatsopt_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) utils_libatsopt_atxt.exe
cleanall:: ; $(RMF) HTML/utils_libatsopt.html
cleanall:: ; $(RMF) SCRIPT/utils_libatsopt.bash


######

all_script:: \
SCRIPT/contrib_ats2cpp.bash
SCRIPT/contrib_ats2cpp.bash: contrib_ats2cpp_atxt.exe ; ./$< > $@
contrib_ats2cpp_atxt.dats: ATEXT/contrib_ats2cpp.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_ats2cpp_atxt.exe: contrib_ats2cpp_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_ats2cpp_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_ats2cpp.html
cleanall:: ; $(RMF) SCRIPT/contrib_ats2cpp.bash


######
#
all_script:: \
SCRIPT/contrib_extsolve.bash
SCRIPT/contrib_extsolve.bash: contrib_extsolve_atxt.exe ; ./$< > $@
contrib_extsolve_atxt.dats: ATEXT/contrib_extsolve.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_extsolve_atxt.exe: contrib_extsolve_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_extsolve_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_extsolve.html
cleanall:: ; $(RMF) SCRIPT/contrib_extsolve.bash

all_script:: \
SCRIPT/contrib_extsolve_z3.bash
SCRIPT/contrib_extsolve_z3.bash: contrib_extsolve_z3_atxt.exe ; ./$< > $@
contrib_extsolve_z3_atxt.dats: ATEXT/contrib_extsolve_z3.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_extsolve_z3_atxt.exe: contrib_extsolve_z3_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_extsolve_z3_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_extsolve_z3.html
cleanall:: ; $(RMF) SCRIPT/contrib_extsolve_z3.bash

all_script:: \
SCRIPT/contrib_extsolve_smt2.bash
SCRIPT/contrib_extsolve_smt2.bash: contrib_extsolve_smt2_atxt.exe ; ./$< > $@
contrib_extsolve_smt2_atxt.dats: ATEXT/contrib_extsolve_smt2.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_extsolve_smt2_atxt.exe: contrib_extsolve_smt2_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_extsolve_smt2_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_extsolve_smt2.html
cleanall:: ; $(RMF) SCRIPT/contrib_extsolve_smt2.bash

#
all_script:: \
SCRIPT/contrib_parsemit.bash
SCRIPT/contrib_parsemit.bash: contrib_parsemit_atxt.exe ; ./$< > $@
contrib_parsemit_atxt.dats: ATEXT/contrib_parsemit.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_parsemit_atxt.exe: contrib_parsemit_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_parsemit_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_parsemit.html
cleanall:: ; $(RMF) SCRIPT/contrib_parsemit.bash

#
all_script:: \
SCRIPT/contrib_atscc2js.bash
SCRIPT/contrib_atscc2js.bash: contrib_atscc2js_atxt.exe ; ./$< > $@
contrib_atscc2js_atxt.dats: ATEXT/contrib_atscc2js.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2js_atxt.exe: contrib_atscc2js_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2js_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2js.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2js.bash

all_script:: \
SCRIPT/contrib_atscc2pl.bash
SCRIPT/contrib_atscc2pl.bash: contrib_atscc2pl_atxt.exe ; ./$< > $@
contrib_atscc2pl_atxt.dats: ATEXT/contrib_atscc2pl.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2pl_atxt.exe: contrib_atscc2pl_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2pl_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2pl.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2pl.bash

all_script:: \
SCRIPT/contrib_atscc2py3.bash
SCRIPT/contrib_atscc2py3.bash: contrib_atscc2py3_atxt.exe ; ./$< > $@
contrib_atscc2py3_atxt.dats: ATEXT/contrib_atscc2py3.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2py3_atxt.exe: contrib_atscc2py3_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2py3_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2py3.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2py3.bash

all_script:: \
SCRIPT/contrib_atscc2php.bash
SCRIPT/contrib_atscc2php.bash: contrib_atscc2php_atxt.exe ; ./$< > $@
contrib_atscc2php_atxt.dats: ATEXT/contrib_atscc2php.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2php_atxt.exe: contrib_atscc2php_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2php_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2php.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2php.bash

all_script:: \
SCRIPT/contrib_atscc2scm.bash
SCRIPT/contrib_atscc2scm.bash: contrib_atscc2scm_atxt.exe ; ./$< > $@
contrib_atscc2scm_atxt.dats: ATEXT/contrib_atscc2scm.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2scm_atxt.exe: contrib_atscc2scm_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2scm_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2scm.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2scm.bash

all_script:: \
SCRIPT/contrib_atscc2clj.bash
SCRIPT/contrib_atscc2clj.bash: contrib_atscc2clj_atxt.exe ; ./$< > $@
contrib_atscc2clj_atxt.dats: ATEXT/contrib_atscc2clj.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2clj_atxt.exe: contrib_atscc2clj_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2clj_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2clj.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2clj.bash

all_script:: \
SCRIPT/contrib_atscc2r34.bash
SCRIPT/contrib_atscc2r34.bash: contrib_atscc2r34_atxt.exe ; ./$< > $@
contrib_atscc2r34_atxt.dats: ATEXT/contrib_atscc2r34.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_atscc2r34_atxt.exe: contrib_atscc2r34_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_atscc2r34_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_atscc2r34.html
cleanall:: ; $(RMF) SCRIPT/contrib_atscc2r34.bash

#
######

all_script:: \
SCRIPT/contrib_libatscc.bash
SCRIPT/contrib_libatscc.bash: contrib_libatscc_atxt.exe ; ./$< > $@
contrib_libatscc_atxt.dats: ATEXT/contrib_libatscc.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc_atxt.exe: contrib_libatscc_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc.bash

all_script:: \
SCRIPT/contrib_libatscc2js.bash
SCRIPT/contrib_libatscc2js.bash: contrib_libatscc2js_atxt.exe ; ./$< > $@
contrib_libatscc2js_atxt.dats: ATEXT/contrib_libatscc2js.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2js_atxt.exe: contrib_libatscc2js_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2js_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2js.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2js.bash

all_script:: \
SCRIPT/contrib_libatscc2pl.bash
SCRIPT/contrib_libatscc2pl.bash: contrib_libatscc2pl_atxt.exe ; ./$< > $@
contrib_libatscc2pl_atxt.dats: ATEXT/contrib_libatscc2pl.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2pl_atxt.exe: contrib_libatscc2pl_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2pl_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2pl.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2pl.bash

all_script:: \
SCRIPT/contrib_libatscc2py3.bash
SCRIPT/contrib_libatscc2py3.bash: contrib_libatscc2py3_atxt.exe ; ./$< > $@
contrib_libatscc2py3_atxt.dats: ATEXT/contrib_libatscc2py3.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2py3_atxt.exe: contrib_libatscc2py3_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2py3_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2py3.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2py3.bash

all_script:: \
SCRIPT/contrib_libatscc2php.bash
SCRIPT/contrib_libatscc2php.bash: contrib_libatscc2php_atxt.exe ; ./$< > $@
contrib_libatscc2php_atxt.dats: ATEXT/contrib_libatscc2php.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2php_atxt.exe: contrib_libatscc2php_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2php_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2php.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2php.bash

all_script:: \
SCRIPT/contrib_libatscc2scm.bash
SCRIPT/contrib_libatscc2scm.bash: contrib_libatscc2scm_atxt.exe ; ./$< > $@
contrib_libatscc2scm_atxt.dats: ATEXT/contrib_libatscc2scm.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2scm_atxt.exe: contrib_libatscc2scm_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2scm_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2scm.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2scm.bash

all_script:: \
SCRIPT/contrib_libatscc2clj.bash
SCRIPT/contrib_libatscc2clj.bash: contrib_libatscc2clj_atxt.exe ; ./$< > $@
contrib_libatscc2clj_atxt.dats: ATEXT/contrib_libatscc2clj.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2clj_atxt.exe: contrib_libatscc2clj_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2clj_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2clj.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2clj.bash

all_script:: \
SCRIPT/contrib_libatscc2r34.bash
SCRIPT/contrib_libatscc2r34.bash: contrib_libatscc2r34_atxt.exe ; ./$< > $@
contrib_libatscc2r34_atxt.dats: ATEXT/contrib_libatscc2r34.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
contrib_libatscc2r34_atxt.exe: contrib_libatscc2r34_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) contrib_libatscc2r34_atxt.exe
cleanall:: ; $(RMF) HTML/contrib_libatscc2r34.html
cleanall:: ; $(RMF) SCRIPT/contrib_libatscc2r34.bash


######

all_script:: \
SCRIPT/doc_example_pcpv.bash
SCRIPT/doc_example_pcpv.bash: doc_example_pcpv_atxt.exe ; ./$< > $@
doc_example_pcpv_atxt.dats: ATEXT/doc_example_pcpv.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_pcpv_atxt.exe: doc_example_pcpv_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_pcpv_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_pcpv.html
cleanall:: ; $(RMF) SCRIPT/doc_example_pcpv.bash

all_script:: \
SCRIPT/doc_example_misc.bash
SCRIPT/doc_example_misc.bash: doc_example_misc_atxt.exe ; ./$< > $@
doc_example_misc_atxt.dats: ATEXT/doc_example_misc.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_misc_atxt.exe: doc_example_misc_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_misc_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_misc.html
cleanall:: ; $(RMF) SCRIPT/doc_example_misc.bash

all_script:: \
SCRIPT/doc_example_intro.bash
SCRIPT/doc_example_intro.bash: doc_example_intro_atxt.exe ; ./$< > $@
doc_example_intro_atxt.dats: ATEXT/doc_example_intro.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_intro_atxt.exe: doc_example_intro_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_intro_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_intro.html
cleanall:: ; $(RMF) SCRIPT/doc_example_intro.bash

all_script:: \
SCRIPT/doc_example_atslib.bash
SCRIPT/doc_example_atslib.bash: doc_example_atslib_atxt.exe ; ./$< > $@
doc_example_atslib_atxt.dats: ATEXT/doc_example_atslib.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
doc_example_atslib_atxt.exe: doc_example_atslib_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) doc_example_atslib_atxt.exe
cleanall:: ; $(RMF) HTML/doc_example_atslib.html
cleanall:: ; $(RMF) SCRIPT/doc_example_atslib.bash


######

all_script:: \
SCRIPT/npm_utils_contrib_atscntrb.bash
SCRIPT/npm_utils_contrib_atscntrb.bash: npm_utils_contrib_atscntrb_atxt.exe ; ./$< > $@
npm_utils_contrib_atscntrb_atxt.dats: ATEXT/npm_utils_contrib_atscntrb.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
npm_utils_contrib_atscntrb_atxt.exe: npm_utils_contrib_atscntrb_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) npm_utils_contrib_atscntrb_atxt.exe
cleanall:: ; $(RMF) HTML/npm_utils_contrib_atscntrb.html
cleanall:: ; $(RMF) SCRIPT/npm_utils_contrib_atscntrb.bash

all_script:: \
SCRIPT/npm_utils_contrib_libats_hwxi.bash
SCRIPT/npm_utils_contrib_libats_hwxi.bash: npm_utils_contrib_libats_hwxi_atxt.exe ; ./$< > $@
npm_utils_contrib_libats_hwxi_atxt.dats: ATEXT/npm_utils_contrib_libats_hwxi.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
npm_utils_contrib_libats_hwxi_atxt.exe: npm_utils_contrib_libats_hwxi_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) npm_utils_contrib_libats_hwxi_atxt.exe
cleanall:: ; $(RMF) HTML/npm_utils_contrib_libats_hwxi.html
cleanall:: ; $(RMF) SCRIPT/npm_utils_contrib_libats_hwxi.bash


######
#
all_script:: \
SCRIPT/patscontrib_JNI.bash
SCRIPT/patscontrib_JNI.bash: patscontrib_JNI_atxt.exe ; ./$< > $@
patscontrib_JNI_atxt.dats: ATEXT/patscontrib_JNI.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_JNI_atxt.exe: patscontrib_JNI_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_JNI_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_JNI.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_JNI.bash

#
all_script:: \
SCRIPT/patscontrib_glib.bash
SCRIPT/patscontrib_glib.bash: patscontrib_glib_atxt.exe ; ./$< > $@
patscontrib_glib_atxt.dats: ATEXT/patscontrib_glib.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_glib_atxt.exe: patscontrib_glib_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_glib_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_glib.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_glib.bash

all_script:: \
SCRIPT/patscontrib_GTK.bash
SCRIPT/patscontrib_GTK.bash: patscontrib_GTK_atxt.exe ; ./$< > $@
patscontrib_GTK_atxt.dats: ATEXT/patscontrib_GTK.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_GTK_atxt.exe: patscontrib_GTK_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_GTK_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_GTK.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_GTK.bash

all_script:: \
SCRIPT/patscontrib_SDL2.bash
SCRIPT/patscontrib_SDL2.bash: patscontrib_SDL2_atxt.exe ; ./$< > $@
patscontrib_SDL2_atxt.dats: ATEXT/patscontrib_SDL2.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_SDL2_atxt.exe: patscontrib_SDL2_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_SDL2_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_SDL2.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_SDL2.bash

#
all_script:: \
SCRIPT/patscontrib_zeromq.bash
SCRIPT/patscontrib_zeromq.bash: patscontrib_zeromq_atxt.exe ; ./$< > $@
patscontrib_zeromq_atxt.dats: ATEXT/patscontrib_zeromq.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_zeromq_atxt.exe: patscontrib_zeromq_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_zeromq_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_zeromq.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_zeromq.bash

#
all_script:: \
SCRIPT/patscontrib_OpenSSL.bash
SCRIPT/patscontrib_OpenSSL.bash: patscontrib_OpenSSL_atxt.exe ; ./$< > $@
patscontrib_OpenSSL_atxt.dats: ATEXT/patscontrib_OpenSSL.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_OpenSSL_atxt.exe: patscontrib_OpenSSL_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_OpenSSL_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_OpenSSL.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_OpenSSL.bash

#
all_script:: \
SCRIPT/patscontrib_HTML-emscripten.bash
SCRIPT/patscontrib_HTML-emscripten.bash: patscontrib_HTML-emscripten_atxt.exe ; ./$< > $@
patscontrib_HTML-emscripten_atxt.dats: ATEXT/patscontrib_HTML-emscripten.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_HTML-emscripten_atxt.exe: patscontrib_HTML-emscripten_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_HTML-emscripten_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_HTML-emscripten.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_HTML-emscripten.bash

all_script:: \
SCRIPT/patscontrib_HTML-emscripten_canvas-2d.bash
SCRIPT/patscontrib_HTML-emscripten_canvas-2d.bash: patscontrib_HTML-emscripten_canvas-2d_atxt.exe ; ./$< > $@
patscontrib_HTML-emscripten_canvas-2d_atxt.dats: ATEXT/patscontrib_HTML-emscripten_canvas-2d.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_HTML-emscripten_canvas-2d_atxt.exe: patscontrib_HTML-emscripten_canvas-2d_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_HTML-emscripten_canvas-2d_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_HTML-emscripten_canvas-2d.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_HTML-emscripten_canvas-2d.bash

#
all_script:: \
SCRIPT/patscontrib_libats_hwxi.bash
SCRIPT/patscontrib_libats_hwxi.bash: patscontrib_libats_hwxi_atxt.exe ; ./$< > $@
patscontrib_libats_hwxi_atxt.dats: ATEXT/patscontrib_libats_hwxi.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_libats_hwxi_atxt.exe: patscontrib_libats_hwxi_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_libats_hwxi_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_libats_hwxi.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_libats_hwxi.bash

all_script:: \
SCRIPT/patscontrib_libats_hwxi_teaching.bash
SCRIPT/patscontrib_libats_hwxi_teaching.bash: patscontrib_libats_hwxi_teaching_atxt.exe ; ./$< > $@
patscontrib_libats_hwxi_teaching_atxt.dats: ATEXT/patscontrib_libats_hwxi_teaching.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_libats_hwxi_teaching_atxt.exe: patscontrib_libats_hwxi_teaching_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_libats_hwxi_teaching_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_libats_hwxi_teaching.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_libats_hwxi_teaching.bash

#
#make_entry("patscontrib_libatscc")
#make_entry("patscontrib_libatscc2js")
#make_entry("patscontrib_libatscc2pl")
#make_entry("patscontrib_libatscc2py3")
#make_entry("patscontrib_libatscc2php")
#make_entry("patscontrib_libatscc2scm")
#make_entry("patscontrib_libatscc2clj")
#
all_script:: \
SCRIPT/patscontrib_kernelats.bash
SCRIPT/patscontrib_kernelats.bash: patscontrib_kernelats_atxt.exe ; ./$< > $@
patscontrib_kernelats_atxt.dats: ATEXT/patscontrib_kernelats.atxt ; \
  $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patscontrib_kernelats_atxt.exe: patscontrib_kernelats_atxt.dats ; $(ATSCC) $(INCLATS) $(GCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patscontrib_kernelats_atxt.exe
cleanall:: ; $(RMF) HTML/patscontrib_kernelats.html
cleanall:: ; $(RMF) SCRIPT/patscontrib_kernelats.bash

#
######
#
atspackaging:: srcget_home
atspackaging:: srcget_share
#
atspackaging:: srcget_patsrc
atspackaging:: srcget_patsrc_cboot
#
atspackaging:: srcget_ccomp_atslib
atspackaging:: srcget_ccomp_runtime
#
atspackaging:: srcget_atslib
atspackaging:: srcget_contrib_atscntrb
#
atspackaging:: srcget_utils_emacs
atspackaging:: srcget_utils_atscc
atspackaging:: srcget_utils_myatscc
#
######
#
# atspackaging:: srcget_utils_libatsopt
#
######
#
atspackaging:: srcget_contrib_ats2cpp
#
atspackaging:: srcget_contrib_extsolve
atspackaging:: srcget_contrib_extsolve_z3
atspackaging:: srcget_contrib_extsolve_smt2
#
atspackaging:: srcget_contrib_parsemit
#
atspackaging:: srcget_contrib_atscc2js
atspackaging:: srcget_contrib_atscc2pl
atspackaging:: srcget_contrib_atscc2py3
atspackaging:: srcget_contrib_atscc2php
atspackaging:: srcget_contrib_atscc2scm
atspackaging:: srcget_contrib_atscc2clj
atspackaging:: srcget_contrib_atscc2r34
#
atspackaging:: srcget_contrib_libatscc
atspackaging:: srcget_contrib_libatscc2js
atspackaging:: srcget_contrib_libatscc2pl
atspackaging:: srcget_contrib_libatscc2py3
atspackaging:: srcget_contrib_libatscc2php
atspackaging:: srcget_contrib_libatscc2scm
atspackaging:: srcget_contrib_libatscc2clj
atspackaging:: srcget_contrib_libatscc2r34
#
atspackaging:: srcget_doc_example
#
atspackaging:: srcget_npm_utils_contrib
#
######
#
atspackaging:: srcget_dist_cleanup
#
atspackaging:: ; (cd ATS-Postiats && ./autogen.sh)
#
######

srcget_home:: ; $(CPF) ../../AUTHORS $(ATSDIST)/
srcget_home:: ; $(CPF) ../../COPYING $(ATSDIST)/
srcget_home:: ; $(CPF) ../../INSTALL $(ATSDIST)/
srcget_home:: ; $(CPF) ../../VERSION $(ATSDIST)/
srcget_home:: ; $(CPF) ../../CHANGES-ats2 $(ATSDIST)/
srcget_home:: ; $(CPF) ../../CHANGES-contrib $(ATSDIST)/
#srcget_home:: ; $(CPF) ../../configure.ac $(ATSDIST)/
#srcget_home:: ; $(CPF) ../../config.mk.in $(ATSDIST)/
#srcget_home:: ; $(CPF) ../../bin/patscc_env.sh.in $(ATSDIST)/bin/
#srcget_home:: ; $(CPF) ../../bin/myatscc_env.sh.in $(ATSDIST)/bin/
#srcget_home:: ; $(CPF) ../../bin/patsopt_env.sh.in $(ATSDIST)/bin/

######
#
srcget_share:: ; \
  $(CPF) ../../share/Makefile.gen $(ATSDIST)/share/.
srcget_share:: ; \
  $(CPF) ../../share/atspre_define.hats $(ATSDIST)/share/.
srcget_share:: ; \
  $(CPF) ../../share/atspre_staload.hats $(ATSDIST)/share/.
srcget_share:: ; \
  $(CPF) ../../share/atspre_staload_libats_ML.hats $(ATSDIST)/share/.
srcget_share:: ; \
  $(CPF) ../../share/H/pats_atslib.h $(ATSDIST)/share/H/.
srcget_share:: ; \
  $(CPF) ../../share/HATS/atspre_define_pkgreloc.hats $(ATSDIST)/share/HATS/.
srcget_share:: ; \
  $(CPF) ../../share/HATS/atspre_staload_prelude.hats $(ATSDIST)/share/HATS/.
srcget_share:: ; \
  $(CPF) ../../share/HATS/atspre_staload_libats_ML.hats $(ATSDIST)/share/HATS/.
srcget_share:: ; \
  $(CPF) ../../share/HATS/atslib_staload_libats_libc.hats $(ATSDIST)/share/HATS/.
#
srcget_share:: ; $(CPF) ../../share/atsmake-pre.mk $(ATSDIST)/share/.
srcget_share:: ; $(CPF) ../../share/atsmake-post.mk $(ATSDIST)/share/.
#
######

srcget_patsrc:: SCRIPT/patsopt_src.bash ; bash $<
srcget_patsrc_cboot:: SCRIPT/patsopt_src_cboot.bash ; bash $<

######
#
srcget_atslib:: srcget_atslib_prelude
srcget_atslib_prelude:: SCRIPT/atslib_prelude.bash ; bash $<
srcget_atslib:: srcget_atslib_libats
srcget_atslib_libats:: SCRIPT/atslib_libats.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_ML
srcget_atslib_libats_ML:: SCRIPT/atslib_libats_ML.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_libc
srcget_atslib_libats_libc:: SCRIPT/atslib_libats_libc.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_ATS1
srcget_atslib_libats_ATS1:: SCRIPT/atslib_libats_ATS1.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_ATS2
srcget_atslib_libats_ATS2:: SCRIPT/atslib_libats_ATS2.bash ; bash $<
srcget_atslib:: srcget_atslib_libats_BUCS320
srcget_atslib_libats_BUCS320:: SCRIPT/atslib_libats_BUCS320.bash ; bash $<
#
srcget_contrib_atscntrb:: SCRIPT/contrib_atscntrb.bash ; bash $<
#
######

srcget_ccomp_atslib:: SCRIPT/ccomp_atslib.bash ; bash $<
srcget_ccomp_runtime:: SCRIPT/ccomp_runtime.bash ; bash $<

######

srcget_utils_emacs:: SCRIPT/utils_emacs.bash ; bash $<
srcget_utils_atscc:: SCRIPT/utils_atscc.bash ; bash $<
srcget_utils_myatscc:: SCRIPT/utils_myatscc.bash ; bash $<

######
#
# srcget_utils_libatsopt:: SCRIPT/utils_libatsopt.bash ; bash $<
#
######

srcget_contrib_ats2cpp:: SCRIPT/contrib_ats2cpp.bash ; bash $<

######
#
srcget_contrib_extsolve:: SCRIPT/contrib_extsolve.bash ; bash $<
srcget_contrib_extsolve_z3:: SCRIPT/contrib_extsolve_z3.bash ; bash $<
srcget_contrib_extsolve_smt2:: SCRIPT/contrib_extsolve_smt2.bash ; bash $<
#
srcget_contrib_parsemit:: SCRIPT/contrib_parsemit.bash ; bash $<
#
srcget_contrib_atscc2js:: SCRIPT/contrib_atscc2js.bash ; bash $<
srcget_contrib_atscc2pl:: SCRIPT/contrib_atscc2pl.bash ; bash $<
srcget_contrib_atscc2py3:: SCRIPT/contrib_atscc2py3.bash ; bash $<
srcget_contrib_atscc2php:: SCRIPT/contrib_atscc2php.bash ; bash $<
srcget_contrib_atscc2scm:: SCRIPT/contrib_atscc2scm.bash ; bash $<
srcget_contrib_atscc2clj:: SCRIPT/contrib_atscc2clj.bash ; bash $<
srcget_contrib_atscc2r34:: SCRIPT/contrib_atscc2r34.bash ; bash $<
#
srcget_contrib_libatscc:: SCRIPT/contrib_libatscc.bash ; bash $<
srcget_contrib_libatscc2js:: SCRIPT/contrib_libatscc2js.bash ; bash $<
srcget_contrib_libatscc2pl:: SCRIPT/contrib_libatscc2pl.bash ; bash $<
srcget_contrib_libatscc2py3:: SCRIPT/contrib_libatscc2py3.bash ; bash $<
srcget_contrib_libatscc2php:: SCRIPT/contrib_libatscc2php.bash ; bash $<
srcget_contrib_libatscc2scm:: SCRIPT/contrib_libatscc2scm.bash ; bash $<
srcget_contrib_libatscc2clj:: SCRIPT/contrib_libatscc2clj.bash ; bash $<
srcget_contrib_libatscc2r34:: SCRIPT/contrib_libatscc2r34.bash ; bash $<
#
######
#
srcget_doc_example:: srcget_doc_example_misc
srcget_doc_example:: srcget_doc_example_pcpv
srcget_doc_example:: srcget_doc_example_intro
srcget_doc_example:: srcget_doc_example_atslib
#
srcget_doc_example_misc:: SCRIPT/doc_example_misc.bash ; bash $<
srcget_doc_example_pcpv:: SCRIPT/doc_example_pcpv.bash ; bash $<
srcget_doc_example_intro:: SCRIPT/doc_example_intro.bash ; bash $<
srcget_doc_example_atslib:: SCRIPT/doc_example_atslib.bash ; bash $<
#
######

srcget_npm_utils_contrib:: srcget_npm_utils_contrib_atscntrb
srcget_npm_utils_contrib_atscntrb:: SCRIPT/npm_utils_contrib_atscntrb.bash; bash $<

srcget_npm_utils_contrib:: srcget_npm_utils_contrib_libats_hwxi
srcget_npm_utils_contrib_libats_hwxi:: SCRIPT/npm_utils_contrib_libats_hwxi.bash; bash $<

######
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2js/ATS2-0.3.2/output/DATS/*_?ats.js
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2js/ATS2-0.3.2/output/DATS/ML/*_?ats.js
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2js/ATS2-0.3.2/output/DATS/Bacon.js/*_?ats.js
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2js/ATS2-0.3.2/output/DATS/BUCS320/parcomb/*_?ats.js
#
srcget_dist_cleanup:: ; rm -rf ATS-Postiats/contrib/libatscc2py3/ATS2-0.3.2/output/__pycache__
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2py3/ATS2-0.3.2/output/DATS/*_?ats.py
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2py3/ATS2-0.3.2/output/DATS/ML/*_?ats.py
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2php/ATS2-0.3.2/output/DATS/*_?ats.php
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2php/ATS2-0.3.2/output/DATS/ML/*_?ats.php
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2scm/ATS2-0.3.2/output/DATS/*_?ats.scm
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2scm/ATS2-0.3.2/output/DATS/ML/*_?ats.scm
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2clj/ATS2-0.3.2/output/DATS/*_?ats.clj
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/contrib/libatscc2clj/ATS2-0.3.2/output/DATS/ML/*_?ats.clj
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/npm-utils/contrib/atscntrb/atscntrb-hx-libsdl2/TEST/DATA/*.png
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/npm-utils/contrib/atscntrb/atscntrb-hx-libcairo/TEST/DATA/*.png
#
srcget_dist_cleanup:: ; $(RMF) ATS-Postiats/npm-utils/contrib/libats-/hwxi/OpenSCAD/TEST/output/*.stl
#
######

atscontribing:: srcget_patscontrib

######

srcget_patscontrib:: srcget_patscontrib_JNI
srcget_patscontrib_JNI:: SCRIPT/patscontrib_JNI.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_GTK
srcget_patscontrib_GTK:: SCRIPT/patscontrib_GTK.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_glib
srcget_patscontrib_glib:: SCRIPT/patscontrib_glib.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_SDL2
srcget_patscontrib_SDL2:: SCRIPT/patscontrib_SDL2.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_zeromq
srcget_patscontrib_zeromq:: SCRIPT/patscontrib_zeromq.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_OpenSSL
srcget_patscontrib_OpenSSL:: SCRIPT/patscontrib_OpenSSL.bash ; bash $<

######
#
# srcget_patscontrib:: srcget_patscontrib_HTML-emscripten
# srcget_patscontrib_HTML-emscripten:: SCRIPT/patscontrib_HTML-emscripten.bash ; bash $<
# srcget_patscontrib:: srcget_patscontrib_HTML-emscripten_canvas-2d
# srcget_patscontrib_HTML-emscripten_canvas-2d:: SCRIPT/patscontrib_HTML-emscripten_canvas-2d.bash ; bash $<
#
######

srcget_patscontrib:: srcget_patscontrib_libats_hwxi
srcget_patscontrib_libats_hwxi:: SCRIPT/patscontrib_libats_hwxi.bash ; bash $<
srcget_patscontrib:: srcget_patscontrib_libats_hwxi_teaching
srcget_patscontrib_libats_hwxi_teaching:: SCRIPT/patscontrib_libats_hwxi_teaching.bash ; bash $<

######

srcget_patscontrib:: srcget_patscontrib_kernelats
srcget_patscontrib_kernelats:: SCRIPT/patscontrib_kernelats.bash ; bash $<

######

######
PATSVER=$(shell cat ${PATSHOME}/VERSION)
######
# PACKNAME=$(PACKNAMEgmp)
# atspacktarzvcf: atspacktarzvcf_int
# atspacktarzvcf: atspacktarzvcf_gmp
######
#
PACKNAMEgmp=ATS2-Postiats-gmp-0.3.13
PACKNAMEgmp=ATS2-Postiats-gmp-$(PATSVER)
#
atspacktarzvcf_gmp:: ; $(RMRF) $(PACKNAMEgmp)
atspacktarzvcf_gmp:: ; $(CPRF) ATS-Postiats $(PACKNAMEgmp)
atspacktarzvcf_gmp:: ; $(RMF) $(PACKNAMEgmp)/Makefile_conf
atspacktarzvcf_gmp:: ; $(RMF) $(PACKNAMEgmp)/missing ; $(CPF) ATS-Postiats/missing $(PACKNAMEgmp)/
atspacktarzvcf_gmp:: ; $(RMF) $(PACKNAMEgmp)/install-sh ; $(CPF) ATS-Postiats/install-sh $(PACKNAMEgmp)/
atspacktarzvcf_gmp:: ; $(MAKE) -C $(PACKNAMEgmp) cleanall
atspacktarzvcf_gmp:: ; $(TARZVCF) $(PACKNAMEgmp).tgz $(PACKNAMEgmp)/.
#
atspacktarzvcf_gmp_up:: ; \
scp $(PACKNAMEgmp).tgz ats-hwxi,ats-lang@web.sourceforge.net:htdocs/IMPLEMENT/Postiats/$(PACKNAME).tgz
#
######
#
PACKNAMEint=ATS2-Postiats-int-0.3.13
PACKNAMEint=ATS2-Postiats-int-$(PATSVER)
#
atspacktarzvcf_int:: ; $(RMRF) $(PACKNAMEint)
atspacktarzvcf_int:: ; $(CPRF) ATS-Postiats $(PACKNAMEint)
atspacktarzvcf_int:: ; $(RMF) $(PACKNAMEint)/Makefile_conf
atspacktarzvcf_int:: ; $(RMF) $(PACKNAMEint)/missing ; $(CPF) ATS-Postiats/missing $(PACKNAMEint)/
atspacktarzvcf_int:: ; $(RMF) $(PACKNAMEint)/install-sh ; $(CPF) ATS-Postiats/install-sh $(PACKNAMEint)/
atspacktarzvcf_int:: ; $(MAKE) -C $(PACKNAMEint) cleanall
atspacktarzvcf_int:: ; $(TARZVCF) $(PACKNAMEint).tgz $(PACKNAMEint)/.
atspacktarzvcf_int_up:: ; scp $(PACKNAMEint).tgz ats-hwxi,ats-lang@web.sourceforge.net:htdocs/IMPLEMENT/Postiats/$(PACKNAMEint).tgz
#
######
#
CONTRIBNAME=ATS2-Postiats-contrib-0.3.13
CONTRIBNAME=ATS2-Postiats-contrib-$(PATSVER)
#
atscontribtarzvcf:: ; $(RMRF) $(CONTRIBNAME)
atscontribtarzvcf:: ; $(CPRF) ATS-Postiats-contrib $(CONTRIBNAME)
atscontribtarzvcf:: ; $(TARZVCF)  $(CONTRIBNAME).tgz  $(CONTRIBNAME)/.
#
atscontribtarzvcf_up:: ; \
scp $(CONTRIBNAME).tgz ats-hwxi,ats-lang@web.sourceforge.net:htdocs/IMPLEMENT/Postiats/$(CONTRIBNAME).tgz
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
