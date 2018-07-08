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

/* ****** ****** */
//
// HX-2013-04: some pre-initialized exceptions
//
/* ****** ****** */

#ifndef \
_ATS_CCOMP_EXCEPTION_NONE_
//
atstype_exncon
ATSLIB_056_prelude__AssertExn = { 10, "AssertException" } ;
atstype_exncon
ATSLIB_056_prelude__GenerallyExn = { 20, "GenerallyException" } ;
atstype_exncon
ATSLIB_056_prelude__IllegalArgExn = { 30, "IllegalArgException" } ;
//
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]

/* ****** ****** */

#ifndef \
_ATS_CCOMP_EXCEPTION_NONE_
//
atstype_exncon
ATSLIB_056_prelude__NotSomeExn = { 40, "NotSomeException" } ;
atstype_exncon
ATSLIB_056_prelude__NotFoundExn = { 41, "NotFoundException" } ;
//
atstype_exncon
ATSLIB_056_prelude__ListSubscriptExn = { 50, "ListSubscriptException" } ;
atstype_exncon
ATSLIB_056_prelude__StreamSubscriptExn = { 51, "StreamSubscriptException" } ;
//
atstype_exncon
ATSLIB_056_prelude__ArraySubscriptExn = { 60, "ArraySubscriptException" } ;
atstype_exncon
ATSLIB_056_prelude__MatrixSubscriptExn = { 61, "MatrixSubscriptException" } ;
//
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]

/* ****** ****** */

#ifndef \
_ATS_CCOMP_EXCEPTION_NONE_
//
extern
void
the_atsexncon_initize
(
  atstype_exncon *d2c, char* exnmsg
)
{
//
  static int the_atsexntag = 1024 ;
//
  if (!d2c->exntag)
  {
    d2c->exntag = the_atsexntag ;
    the_atsexntag = the_atsexntag + 1 ;
  }
  d2c->exnmsg = exnmsg ;
  return ;
} // end of [the_atsexncon_initize]
//
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]

/* ****** ****** */
//
// HX-2013:
// for reporting pattern matching failure
//
extern
void
atsruntime_handle_unmatchedval
  (char *msg0)
{
  fprintf
  ( stderr
  , "exit(ATS): unmatched value at run-time:\n%s\n", msg0
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_unmatchedval] */
//
/* ****** ****** */
//
// HX-2014-06:
// for reporting funarg-pattern matching failure
//
extern
void
atsruntime_handle_unmatchedarg
  (char *msg0)
{
  fprintf
  ( stderr
  , "exit(ATS): unmatched funarg at run-time:\n%s\n", msg0
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_unmatchedarg] */
//
/* ****** ****** */
//
// HX-2014-06:
// for reporting failure due to uncaught exception
//
extern
void
atsruntime_handle_uncaughtexn_rest
  (atstype_exncon *exn0)
{
  fprintf
  ( stderr
  , "exit(ATS): uncaught exception at run-time:\n%s(%d)\n", exn0->exnmsg, exn0->exntag
  ) ; exit(1) ;
  return ; // deadcode
} /* end of [atsruntime_handle_uncaughtexn_rest] */
//
/* ****** ****** */

/* end of [pats_ccomp_runtime.c] */
