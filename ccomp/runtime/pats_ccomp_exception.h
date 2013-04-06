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

#ifndef PATS_CCOMP_EXCEPTION_H
#define PATS_CCOMP_EXCEPTION_H

/* ****** ****** */
//
extern
atstype_exnconptr atspre_ListSubscriptExn_make () ;
extern
atstype_bool
atspre_isListSubscriptExn (const atstype_exnconptr exn) ;
//
extern
atstype_exnconptr atspre_ArraySubscriptExn_make () ;
extern
atstype_bool
atspre_isArraySubscriptExn (const atstype_exnconptr exn) ;
//
extern
atstype_exnconptr atspre_NotSomeExn_make () ;
extern
atstype_bool
atspre_isNotSomeExn (const atstype_exnconptr exn) ;
//
/* ****** ****** */

extern
atsvoid_t0ype atsruntime_raise (const atstype_exnconptr exn) ;

/* ****** ****** */

#endif /* PATS_CCOMP_EXCEPTION_H */

/* ****** ****** */

/* end of [pats_ccomp_exception.h] */
