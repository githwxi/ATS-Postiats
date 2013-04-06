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
(* Start time: April, 2013 *)
*/

/* ****** ****** */
//
#include <stdio.h>
//
extern void exit (int) ; // in [stdlib.h]
//
/* ****** ****** */

#include "pats_ccomp_basics.h"
#include "pats_ccomp_typedefs.h"
#include "pats_ccomp_exception.h"

/* ****** ****** */
//
// HX-2013-04: some pre-defined exceptions
//
/* ****** ****** */

atstype_exncon
AssertExnCon = { 10, "AssertException" } ;
atstype_exnconptr AssertExnConPtr = &AssertExnCon ;

atstype_exncon
IllegalArgExnCon = { 20, "IllegalArgException" } ;
atstype_exnconptr IllegalArgExnConPtr = &IllegalArgExnCon ;

/* ****** ****** */

atstype_exncon
ListSubscriptExnCon =
{
  50, "ListSubscriptException"
} ;
atstype_exnconptr
ListSubscriptExnConPtr = &ListSubscriptExnCon ;

atstype_exncon
ArraySubscriptExnCon =
{
  60, "ArraySubscriptException"
} ;
atstype_exnconptr
ArraySubscriptExnConPtr = &ArraySubscriptExnCon ;

atstype_exncon
NotSomeExnCon = { 70, "NotSomeException" } ;
atstype_exnconptr NotSomeExnConPtr = &NotSomeExnCon ;

/* ****** ****** */

extern
atstype_exnconptr
atspre_ListSubscriptExn_make(
) { return ListSubscriptExnConPtr ; }
extern
atstype_bool
atspre_isListSubscriptExn
(
  const atstype_exnconptr exn
)
{
return
(
  exn->exntag==ListSubscriptExnCon.exntag ? atsbool_true : atsbool_false
) ;
} // end of [atspre_isListSubscriptExn]

/* ****** ****** */

extern
atstype_exnconptr
atspre_ArraySubscriptExn_make(
) { return ArraySubscriptExnConPtr ; }
extern
atstype_bool
atspre_isArraySubscriptExn
(
  const atstype_exnconptr exn
)
{
return
(
  exn->exntag==ArraySubscriptExnCon.exntag ? atsbool_true : atsbool_false
) ;
} // end of [atspre_isArraySubscriptExn]

/* ****** ****** */

extern
atstype_exnconptr
atspre_NotSomeExn_make() { return NotSomeExnConPtr ; }
extern
atstype_bool
atspre_isNotSomeExn
(
  const atstype_exnconptr exn
) {
  return (exn->exntag==NotSomeExnCon.exntag ? atsbool_true : atsbool_false) ;
} // end of [atspre_isNotSomeExn]

/* ****** ****** */

extern
atsvoid_t0ype
atsruntime_handle_uncaughtexn
  (const atstype_exnconptr exn)
{
  fprintf(
    stderr, "exit(ATS): uncaught exception: %s(%d)\n", exn->exnname, exn->exntag
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_uncaughtexn] */

/* ****** ****** */

extern
atsvoid_t0ype
atsruntime_raise
(
  const atstype_exnconptr exn
)
{
  atsruntime_handle_uncaughtexn(exn) ; return ;
} /* end of [atsruntime_raise] */

/* ****** ****** */

/* end of [pats_ccomp_runtime.c] */
