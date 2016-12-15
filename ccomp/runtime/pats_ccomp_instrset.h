/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: October, 2012 *)
*/

/* ****** ****** */

#ifndef PATS_CCOMP_INSTRSET_H
#define PATS_CCOMP_INSTRSET_H

/* ****** ****** */
//
// HX: boolean values
//
#define atsbool_true 1
#define atsbool_false 0
//
/* ****** ****** */

#define ATStysum() struct{ int contag; }
#define ATStyexn() struct{ int exntag; char *exnmsg; }
#define ATStylist(tyelt) struct{ tyelt head; void *tail; }
#define ATStyclo() struct{ void *cfun; }

/* ****** ****** */
//
// HX: for supporting lazy-evaluation
//
#define \
ATStylazy(tyval) \
  struct{ int flag; union{ void* thunk; tyval saved; } lazy; }
//
/* ****** ****** */

#define ATSif(x) if(x)
#define ATSthen()
#define ATSelse() else

/* ****** ****** */

#define ATSifthen(x) if(x)
#define ATSifnthen(x) if(!(x))

/* ****** ****** */

#define ATSdo() do
#define ATSwhile(x) while(x)
#define ATSbreak() break
#define ATScontinue() continue

/* ****** ****** */
//
// HX: handling for/while loops
//
#define \
ATSloop_open(init, fini, cont) \
  do { init:
#define \
ATSloop_close(init, fini, cont) \
  goto init ; fini: break ; } while(0)
//
#define ATSbreak2(fini) goto fini
#define ATScontinue2(cont) goto cont
//
/* ****** ****** */

#define ATSreturn(x) return(x)
#define ATSreturn_void(x) return

/* ****** ****** */

#define ATSFCreturn(x) return(x)
#define ATSFCreturn_void(x) (x); return

/* ****** ****** */
//
#define ATSbranch_beg()
#define ATSbranch_end() break ;
//
#define ATScaseof_beg() do {
#define ATScaseof_end() } while(0) ;
//
/* ****** ****** */

#define ATSextcode_beg()
#define ATSextcode_end()

/* ****** ****** */

#define ATSfunbody_beg()
#define ATSfunbody_end()

/* ****** ****** */

#define ATSPMVint(i) i
#define ATSPMVintrep(rep) (rep)

#define ATSPMVbool_true() atsbool_true
#define ATSPMVbool_false() atsbool_false
#define ATSPMVchar(c) (c)
#define ATSPMVfloat(rep) (rep)
#define ATSPMVstring(str) (str)

#define ATSPMVi0nt(tok) (tok)
#define ATSPMVf0loat(tok) (tok)

/* ****** ****** */

#define ATSCSTSPmyfil(info) info
#define ATSCSTSPmyloc(info) info

/* ****** ****** */
//
#define ATSPMVtop() atserror_top
//
#define ATSPMVempty() /*empty*/
#define ATSPMVextval(name) (name)
//
/* ****** ****** */

#define ATSPMVtyrep(tyrep) tyrep

/* ****** ****** */
//
#define ATSPMVfunlab(flab) (flab)
//
// HX-2015-07-06: not yet in use:
//
#define ATSPMVfunlab2(flab, arity) (flab)
//
/* ****** ****** */

#define ATSPMVcfunlab(knd, flab, env) (flab##__closurerize)env

/* ****** ****** */

#define ATSPMVptrof(lval) (&(lval))
#define ATSPMVptrof_void(lval) ((void*)0)

/* ****** ****** */

#define ATSPMVrefarg0(val) (val)
#define ATSPMVrefarg1(ref) (ref)

/* ****** ****** */

#define ATSPMVsizeof(hit) (sizeof(hit))

/* ****** ****** */
//
// HX: castfn application
//
#define ATSPMVcastfn(d2c, hit, arg) ((hit)arg)
//
/* ****** ****** */

#define ATSfuncall(fun, funarg) (fun)funarg

/* ****** ****** */
//
#define ATSextfcall(fun, funarg) (fun)funarg
#define ATSextmcall(obj, mtd, funarg) (obj->mtd)funarg
//
/* ****** ****** */
//
#define \
ATSfunclo_fun(pmv, targs, tres) ((tres(*)targs)(pmv))
#define \
ATSfunclo_clo(pmv, targs, tres) ((tres(*)targs)(((ATStyclo()*)pmv)->cfun))
//
/* ****** ****** */
//
#define ATStmpdec(tmp, hit) hit tmp
#define ATStmpdec_void(tmp)
//
#define ATSstatmpdec(tmp, hit) static hit tmp
#define ATSstatmpdec_void(tmp)
//
/* ****** ****** */

#define ATSderef(pmv, hit) (*(hit*)pmv)

/* ****** ****** */
//
// HX: [ATSSELcon] is the same as [ATSSELboxrec]
//
#define ATSSELcon(pmv, tysum, lab) (((tysum*)pmv)->lab)
//
#define ATSSELrecsin(pmv, tyrec, lab) (pmv)
#define ATSSELfltrec(pmv, tyrec, lab) ((pmv).lab)
#define ATSSELboxrec(pmv, tyrec, lab) (((tyrec*)pmv)->lab)
#define ATSSELarrind(pmv, tyarr, lab) (((tyarr)pmv).lab)
#define ATSSELarrptrind(pmv, tyelt, lab) (((tyelt*)pmv)lab)
//
/* ****** ****** */
//
#define ATSCKnot(x) ((x)==0)
//
#define ATSCKiseqz(x) ((x)==0)
#define ATSCKisneqz(x) ((x)!=0)
//
#define ATSCKptriscons(x) (0 != (void*)(x))
#define ATSCKptrisnull(x) (0 == (void*)(x))
//
/* ****** ****** */
//
#define ATSCKpat_int(pmv, pat) ((pmv)==pat)
#define ATSCKpat_bool(pmv, pat) ((pmv)==pat)
#define ATSCKpat_char(pmv, pat) ((pmv)==pat)
#define ATSCKpat_float(pmv, pat) ((pmv)==pat)
#define ATSCKpat_string(pmv, pat) (atspre_string_equal(pmv, pat))
//
/*
** a datatype should not contain more than 1024 constructors!
*/
#define ATS_DATACONMAX 1024
//
#define ATSCKpat_con0(pmv, tag) ((pmv)==(void*)tag)
#define ATSCKpat_con1(pmv, tag) \
  ((pmv)>=(void*)ATS_DATACONMAX && ((ATStysum()*)(pmv))->contag==tag)
//
#define ATSCKpat_exn0(pmv, d2con) ((pmv)==(void*)(&(d2con)))
#define ATSCKpat_exn1(pmv, d2con) (((ATStyexn()*)(pmv))->exntag==(&(d2con))->exntag)
//
/* ****** ****** */
//
#define ATSINSlab(lab) lab
#define ATSINSgoto(lab) goto lab
//
#define ATSINSflab(flab) flab
#define ATSINSfgoto(flab) goto flab
//
/* ****** ****** */

#define ATSINSfreeclo(cloptr) ATS_MFREE(cloptr)
#define ATSINSfreecon(datconptr) ATS_MFREE(datconptr)

/* ****** ****** */

#define ATSINSmove(tmp, val) (tmp = val)
#define ATSINSpmove(tmp, hit, val) (*(hit*)tmp = val)

/* ****** ****** */
/*
** HX-2013-01-20:
** Do not have parentheses around [command]
*/
#define ATSINSmove_void(tmp, command) command
#define ATSINSpmove_void(tmp, hit, command) command

/* ****** ****** */

#define ATSINSmove_ptralloc(tmp, hit) (tmp = ATS_MALLOC(sizeof(hit)))

/* ****** ****** */
//
#define \
ATSINSmove_nil(tmp) (tmp = ((void*)0))
//
#define \
ATSINSmove_con0(tmp, tag) (tmp = ((void*)tag))
//
#define ATSINSmove_con1_beg()
#define ATSINSmove_con1_end()
#define ATSINSmove_con1_new(tmp, tysum) (tmp = ATS_MALLOC(sizeof(tysum)))
#define ATSINSstore_con1_tag(tmp, val) (((ATStysum()*)(tmp))->contag = val)
#define ATSINSstore_con1_ofs(tmp, tysum, lab, val) (((tysum*)(tmp))->lab = val)
//
/* ****** ****** */
//
#define ATSINSmove_exn0(tmp, d2con) (tmp = &(d2con))
//
#define ATSINSmove_exn1_beg()
#define ATSINSmove_exn1_end()
#define ATSINSmove_exn1_new(tmp, tyexn) (tmp = ATS_MALLOC(sizeof(tyexn)))
#define ATSINSstore_exn1_tag(tmp, d2con) (((ATStyexn()*)tmp)->exntag = (&(d2con))->exntag)
#define ATSINSstore_exn1_msg(tmp, d2con) (((ATStyexn()*)tmp)->exnmsg = (&(d2con))->exnmsg)
//
/* ****** ****** */
//
#define ATStailcal_beg() do {
#define ATStailcal_end() } while(0) ;
//
#define ATSINSmove_tlcal(apy, tmp) (apy = tmp)
#define ATSINSargmove_tlcal(arg, apy) (arg = apy)
//
/* ****** ****** */

#define ATSINSmove_fltrec_beg()
#define ATSINSmove_fltrec_end()
#define ATSINSstore_fltrec_ofs(tmp, tyrec, lab, val) ((tmp).lab = val)

/* ****** ****** */

#define ATSINSmove_boxrec_beg()
#define ATSINSmove_boxrec_end()
#define ATSINSmove_boxrec_new(tmp, tyrec) (tmp = ATS_MALLOC(sizeof(tyrec)))
#define ATSINSstore_boxrec_ofs(tmp, tyrec, lab, val) (((tyrec*)(tmp))->lab = val)

/* ****** ****** */

#define ATSINSload(tmp, pmv) (tmp = pmv)
#define ATSINSstore(pmv1, pmv2) (pmv1 = pmv2)
#define ATSINSxstore(tmp, pmv1, pmv2) (tmp = pmv1, pmv1 = pmv2, pmv2 = tmp)

/* ****** ****** */
//
#define ATSINSmove_list_nil(tmp) (tmp = (void*)0)
#define ATSINSmove_list_phead(tmp1, tmp2, tyelt) (tmp1 = &(((ATStylist(tyelt)*)(*(void**)tmp2))->head))
#define ATSINSmove_list_ptail(tmp1, tmp2, tyelt) (tmp1 = &(((ATStylist(tyelt)*)(*(void**)tmp2))->tail))
#define ATSINSpmove_list_nil(tmp) (*(void**)tmp = (void*)0)
#define ATSINSpmove_list_cons(tmp, tyelt) (*(void**)tmp = ATS_MALLOC(sizeof(ATStylist(tyelt))))
//
/* ****** ****** */
//
#define ATSINSstore_arrpsz_asz(tmp, asz) ((tmp).size = asz)
#define ATSINSstore_arrpsz_ptr(tmp, tyelt, asz) ((tmp).ptr = ATS_MALLOC(asz*sizeof(tyelt)))
//
#define ATSINSmove_arrpsz_ptr(tmp, psz) (tmp = (psz).ptr)
//
#define ATSINSupdate_ptrinc(tmp, tyelt) (tmp = (tyelt*)(tmp) + 1)
#define ATSINSupdate_ptrdec(tmp, tyelt) (tmp = (tyelt*)(tmp) - 1)
//
/* ****** ****** */

#define ATSINSextvar_assign(var, pmv) var = (pmv)
#define ATSINSdyncst_valbind(d2cst, pmv) d2cst = (pmv)

/* ****** ****** */

#define ATSINSclosure_initize(flab, tmpenv) (flab##__closureinit)tmpenv

/* ****** ****** */
//
#define ATSINSraise_exn(tmp, pmv) atsruntime_raise(pmv)
//
/* ****** ****** */
//
#define ATSINScaseof_fail(msg) atsruntime_handle_unmatchedval(msg)
#define ATSINSfunarg_fail(msg) atsruntime_handle_unmatchedarg(msg)
//
/* ****** ****** */

#define \
ATSINSmove_delay(tmpret, tyval, pmv_thk) \
do { \
  tmpret = \
    ATS_MALLOC(sizeof(ATStylazy(tyval))) ; \
  (*(ATStylazy(tyval)*)tmpret).flag = 0 ; \
  (*(ATStylazy(tyval)*)tmpret).lazy.thunk = pmv_thk ; \
} while(0) ; /* end of [do ... while ...] */

#define \
ATSINSmove_lazyeval(tmpret, tyval, pmv_lazy) \
do { \
  if ( \
    (*(ATStylazy(tyval)*)pmv_lazy).flag==0 \
  ) { \
    (*(ATStylazy(tyval)*)pmv_lazy).flag += 1 ; \
    atstype_cloptr __thunk = (*(ATStylazy(tyval)*)pmv_lazy).lazy.thunk ; \
    tmpret = ATSfuncall(ATSfunclo_clo(__thunk, (atstype_cloptr), tyval), (__thunk)) ; \
    (*(ATStylazy(tyval)*)pmv_lazy).lazy.saved = tmpret ; \
  } else { \
    tmpret = (*(ATStylazy(tyval)*)pmv_lazy).lazy.saved ; \
  } /* end of [if] */ \
} while(0) /* end of [do ... while ...] */

/* ****** ****** */

#define \
ATSINSmove_ldelay(tmpret, tyval, __thunk) \
do { \
  ATSINSmove(tmpret, __thunk) ; \
} while(0) /* end of [do ... while ...] */

#define \
ATSINSmove_llazyeval(tmpret, tyval, __thunk) \
do { \
  tmpret = \
  ATSfuncall(ATSfunclo_clo(__thunk, (atstype_cloptr, atstype_bool), tyval), (__thunk, atsbool_true)) ; \
  ATS_MFREE(__thunk) ; \
} while(0) /* end of [do ... while ...] */

/* ****** ****** */

#define \
atspre_lazy_vt_free(__thunk) \
do { \
  ATSfuncall(ATSfunclo_clo(__thunk, (atstype_cloptr, atstype_bool), void), (__thunk, atsbool_false)) ; \
  ATS_MFREE(__thunk) ; \
} while(0) /* atspre_lazy_vt_free */

/* ****** ****** */
//
// HX-2014-10:
//
#define atspre_lazy2cloref(pmv_lazy) ((*(ATStylazy(atstype_ptr)*)pmv_lazy).lazy.thunk)
//
/* ****** ****** */

#endif /* PATS_CCOMP_INSTRSET_H */

/* ****** ****** */

/* end of [pats_ccomp_instrset.h] */
