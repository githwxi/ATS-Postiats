/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
*) */

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: October, 2012 *)
*/

/* ****** ****** */

#ifndef PATS_BASICS_H
#define PATS_BASICS_H

/* ****** ****** */

#define ATSglobaldec()
#define ATSstaticdec() static

/* ****** ****** */

#define ATSextfun() extern
#define ATSinline() static inline

/* ****** ****** */
//
// HX: boolean values
//
#define atsbool_true 1
#define atsbool_false 0
//
/* ****** ****** */

#define ATSptrof(pmv) (&(pmv))
#define ATSextval(name) (name)

/* ****** ****** */

#define ATStysum() struct{ int contag; }

/* ****** ****** */

#define ATSPATCKint(pmv, pat) ((pmv)==pat)
#define ATSPATCKbool(pmv, pat) ((pmv)==pat)
#define ATSPATCKchar(pmv, pat) ((pmv)==pat)
#define ATSPATCKfloat(pmv, pat) ((pmv)==pat)
#define ATSPATCKstring(pmv, pat) (atspre_string_equal(pmv, pat))

#define ATSPATCKcon(pmv, tag) (((ATStysum()*)(pmv))->contag==tag)

/* ****** ****** */

#define ATSMACmove(tmp, val) (tmp = val)
#define ATSMACpmove(tmp, hit, val) (*(hit*)tmp = val)

/* ****** ****** */

#define ATSMACmove_ptralloc(tmp, hit) (tmp = ATS_MALLOC(sizeof(hit)))

/* ****** ****** */

#define ATSMACmove_con(tmp, tysum) (tmp = ATS_MALLOC(sizeof(tysum)))
#define ATSMACassgn_con_tag(tmp, val) (((ATStysum()*)(tmp))->contag = val)
#define ATSMACassgn_con_ofs(tmp, tyrec, lab, val) (((tyrec*)(tmp))->lab = val)

/* ****** ****** */

#define ATSMACassgn_fltrec_ofs(tmp, tyrec, lab, val) ((tmp).lab = val)

/* ****** ****** */

#define ATSMACmove_boxrec(tmp, tyrec) (tmp = ATS_MALLOC(sizeof(tyrec)))
#define ATSMACassgn_boxrec_ofs(tmp, tyrec, lab, val) (((tyrec*)(tmp))->lab = val)

/* ****** ****** */
//
#define ATSlist(tyelt) struct{ tyelt head; void *tail; }
#define ATSMACmove_list_nil(tmp) (tmp = (void*)0)
#define ATSMACpmove_list_nil(tmp) (*(void**)tmp = (void*)0)
#define ATSMACpmove_list_cons(tmp, tyelt) (*(void**)tmp = ATS_MALLOC(sizeof(ATSlist(tyelt))))
#define ATSMACupdate_list_head(tmp1, tmp2, tyelt) (tmp1 = &(((ATSlist(tyelt)*)(*(void**)tmp2))->head))
#define ATSMACupdate_list_tail(tmp1, tmp2, tyelt) (tmp1 = &(((ATSlist(tyelt)*)(*(void**)tmp2))->tail))
//
/* ****** ****** */
//
#define ATSMACassgn_arrpsz_asz(tmp, asz) (tmp.size = asz)
#define ATSMACassgn_arrpsz_ptr(tmp, tyelt, asz) (tmp.ptr = ATS_MALLOC(asz*sizeof(tyelt)))
//
#define ATSMACmove_arrpsz_ptr(tmp, psz) (tmp1 = (psz).ptr)
//
#define ATSMACupdate_ptrinc(tmp, tyelt) (tmp = (tyelt*)tmp + 1)
#define ATSMACupdate_ptrdec(tmp, tyelt) (tmp = (tyelt*)tmp - 1)
//
/* ****** ****** */

#define ATSMACcastfn(castfn, arg) (arg) // castfn application

/* ****** ****** */

#endif /* PATS_BASICS_H */

/* end of [pats_basics.h] */
