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

#define ATSextval(val) (val)

/* ****** ****** */

#define ATSMACmove(tmp, val) (tmp = val)

/* ****** ****** */

#define ATSMACmove_ptralloc(tmp, hit) (tmp = ATS_MALLOC(sizeof(hit))

/* ****** ****** */

#define ATSMACmove_fltrec_ofs(tmp, tyrec, lab, val) (tmp.lab = val)
#define ATSMACmove_boxrec_ofs(tmp, tyrec, lab, val) ((*(tyrec*)tmp).lab = val)

/* ****** ****** */

#define ATSMACcastfn(castfn, arg) (arg) // castfn application

/* ****** ****** */

#endif /* PATS_BASICS_H */

/* end of [pats_basics.h] */
