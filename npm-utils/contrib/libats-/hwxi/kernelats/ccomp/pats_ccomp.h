/* ****** ****** */
//
// HX-2014-10-22:
// For C code generated from ATS source
//
/* ****** ****** */

/*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/* ****** ****** */

#ifndef KERNELATS_PATS_CCOMP_H
#define KERNELATS_PATS_CCOMP_H

/* ****** ****** */
//
#define ATSstruct struct
/*
#define ATStypedef typedef
*/
//
/* ****** ****** */

#define ATSextern() extern
#define ATSstatic() static

/* ****** ****** */

#define ATSinline() static inline

/* ****** ****** */

#define ATSdyncst_mac(d2c)
#define ATSdyncst_castfn(d2c)
#define ATSdyncst_extfun(d2c, targs, tres) ATSextern() tres d2c targs
#define ATSdyncst_stafun(d2c, targs, tres) ATSstatic() tres d2c targs

/* ****** ****** */
//
// HX: boolean values
//
#define atsbool_true 1
#define atsbool_false 0
//
/* ****** ****** */
//
#ifndef NULL
#define NULL ((void*)0)
#endif // ifndef(NULL)
//
/*
#define atsptr_null ((void*)0)
*/
#define the_atsptr_null ((void*)0)
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

#define ATSempty()

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
//
#define ATSPMVint(i) i
#define ATSPMVintrep(rep) (rep)
//
#define ATSPMVbool_true() atsbool_true
#define ATSPMVbool_false() atsbool_false
//
#define ATSPMVchar(c) (c)
//
#define ATSPMVfloat(rep) (rep)
//
/*
#define ATSPMVstring(str) (str)
*/
#define ATSPMVstring(strcst) strcst
//
#define ATSPMVi0nt(tok) (tok)
#define ATSPMVf0loat(tok) (tok)
//
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

#define ATSPMVfunlab(flab) (flab)

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
#define ATSextfcall(fun, funarg) fun funarg
//
/* ****** ****** */
//
#define ATStmpdec(tmp, hit) hit tmp
#define ATSstatmpdec(tmp, hit) static hit tmp
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
#define ATSCKiseqz(x) ((x)==0)
#define ATSCKisneqz(x) ((x)!=0)
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
/* ****** ****** */
//
#define ATSINSlab(lab) lab
#define ATSINSgoto(lab) goto lab
//
#define ATSINSflab(flab) flab
#define ATSINSfgoto(flab) goto flab
//
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

#define ATSINSload(tmp, pmv) (tmp = pmv)
#define ATSINSstore(pmv1, pmv2) (pmv1 = pmv2)
#define ATSINSxstore(tmp, pmv1, pmv2) (tmp = pmv1, pmv1 = pmv2, pmv2 = tmp)

/* ****** ****** */

#define ATSINSextvar_assign(var, pmv) var = (pmv)
#define ATSINSdyncst_valbind(d2c, pmv) d2c = (pmv)

/* ****** ****** */

typedef void atstype_void ;
typedef void atsvoid_t0ype ;

/* ****** ****** */

typedef int atstype_int ;
typedef unsigned int atstype_uint ;

typedef long int atstype_lint ;
typedef unsigned long int atstype_ulint ;

typedef long long int atstype_llint ;
typedef unsigned long long int atstype_ullint ;

typedef short int atstype_sint ;
typedef unsigned short int atstype_usint ;

/* ****** ****** */

typedef atstype_lint atstype_ssize ;
typedef atstype_ulint atstype_size ;

/* ****** ****** */
//
// HX: true/false: 1/0
//
typedef int atstype_bool ;
//
/* ****** ****** */

typedef unsigned char atstype_byte ;

/* ****** ****** */

typedef char atstype_char ;
typedef signed char atstype_schar ;
typedef unsigned char atstype_uchar ;

/* ****** ****** */

typedef char *atstype_string ;
typedef char *atstype_stropt ;
typedef char *atstype_strptr ;

/* ****** ****** */

typedef float atstype_float ;
typedef double atstype_double ;
typedef long double atstype_ldouble ;

/* ****** ****** */
/*
** HX: for pointers
*/
typedef void *atstype_ptr ;
typedef void *atstype_ptrk ;
/*
** HX: for references
*/
typedef void *atstype_ref ;
/*
** HX: for boxed values
*/
typedef void* atstype_boxed ;
/*
** HX: for [datconptr]
*/
typedef void* atstype_datconptr ;
/*
** HX: for [datcontyp]
*/
typedef void* atstype_datcontyp ;

/* ****** ****** */
/*
** HX: for pointers to arrays
*/
typedef void* atstype_arrptr ;
/*
** HX: for arrays plus size info
*/
typedef
struct {
  atstype_arrptr ptr ; atstype_size size ;
} atstype_arrpsz ;

/* ****** ****** */

typedef void* atstype_funptr ;
typedef void* atstype_cloptr ;

/* ****** ****** */

#define atstkind_type(tk) tk
#define atstkind_t0ype(tk) tk

/* ****** ****** */
//
// HX-2014-09-16:
// making it unusable unless
// _ATS_ARRAY_FIELD is defined
//
#ifdef _ATS_ARRAY_FIELD
#define atstyarr_field(fname) fname[]
#else
#define atstyarr_field(fname) atstyarr_field_undef(fname)
#endif // end of [_ATS_ARRAY_FIELD]
//
/* ****** ****** */
//
// HX-2014-05:
// making it not usable!!!
//
#ifdef _ATSTYPE_VAR_SIZE_
// HX: it is set by the user
#else
#define _ATSTYPE_VAR_SIZE_ 0X10000
#endif // end of [#ifdef]
//
// HX-2014-05:
// for 8-bit or 16-bit march,
// _ATSTYPE_VAR_SIZE_ can be set to 0X100
//
typedef
struct{char _[_ATSTYPE_VAR_SIZE_];} atstype_var[0] ;
//
/* ****** ****** */

#define atstyvar_type(a) atstype_var

/* ****** ****** */

#define atstybox_type(hit) atstype_boxed

/* ****** ****** */

#define atstyclo_top struct{ void *cfun; }
#define atstyclo_type(flab) flab##__closure_t0ype

/* ****** ****** */

#define atsrefarg0_type(hit) hit
#define atsrefarg1_type(hit) atstype_ref

/* ****** ****** */
//
#if(0)
//
// HX-2014-11-19: for example
//
#include \
"kernelats/prelude/CATS/integer.cats"
#include \
"kernelats/prelude/CATS/pointer.cats"
//
#include \
"kernelats/prelude/CATS/integer_long.cats"
#include \
"kernelats/prelude/CATS/integer_size.cats"
#include \
"kernelats/prelude/CATS/integer_short.cats"
//
#include "kernelats/prelude/CATS/bool.cats"
#include "kernelats/prelude/CATS/char.cats"
//
#include					\
"kernelats/prelude/CATS/integer_fixed.cats"
//
#include "kernelats/prelude/CATS/string.cats"
//
#include "kernelats/prelude/CATS/array.cats"
#include "kernelats/prelude/CATS/arrayptr.cats"
#include "kernelats/prelude/CATS/arrayref.cats"
//
#endif // if(0)
//
/* ****** ****** */

#endif // end of [KERNELATS_PATS_CCOMP_H]

/* ****** ****** */

/* end of [pats_ccomp.h] */
