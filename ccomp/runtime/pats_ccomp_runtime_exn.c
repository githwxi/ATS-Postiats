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
atstype_exncon
IllegalArgExnCon = { 20, "IllegalArgException" } ;

/* ****** ****** */

extern
atstype_exnconptr
atspre_AssertExn_make() { return &AssertExnCon ; }
extern
atstype_exnconptr
atspre_IllegalArgExn_make() { return &IllegalArgExnCon ; }

/* ****** ****** */

atstype_exncon
ListSubscriptExnCon = { 50, "ListSubscriptException" } ;
atstype_exncon
ArraySubscriptExnCon = { 60, "ArraySubscriptException" } ;

static
atstype_exncon NotSomeExnCon = { 70, "NotSomeException" } ;

/* ****** ****** */

extern
atstype_exnconptr
atspre_ListSubscriptExn_make() { return &ListSubscriptExnCon ; }
extern
atstype_bool
atspre_isListSubscriptExn
(
  const atstype_exncon *exn
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
atspre_ArraySubscriptExn_make() { return &ArraySubscriptExnCon ; }
extern
atstype_bool
atspre_isArraySubscriptExn
(
  const atstype_exncon *exn
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
atspre_NotSomeExn_make() { return &NotSomeExnCon ; }
extern
atstype_bool
atspre_isNotSomeExn
(
  const atstype_exncon *exn
) {
  return (exn->exntag==NotSomeExnCon.exntag ? atsbool_true : atsbool_false) ;
} // end of [atspre_isNotSomeExn]

/* ****** ****** */
//
// HX-2013-06:
// this is for single-threaded programs
//
/* ****** ****** */

extern
atsexnframe_ptr
*my_atsexnframe_getref ()
{
//
static atsexnframe_t *my_atsexnframe = 0;
//
return &my_atsexnframe ;
//
} // end of [my_atsexnframe_getref]

/* ****** ****** */

extern
void
atsruntime_raise
  (const void *exn0)
{
//
  atsexnframe_t *frame ;
  frame = *(my_atsexnframe_getref()) ;
//
  do {
    if (!frame) break ;
    (frame)->exn = (atstype_exnconptr)exn0 ;
    siglongjmp((frame)->env, 1) ;
  } while (0) ; // end of [do]
//
  atsruntime_handle_uncaughtexn(exn0) ;
//
  return ;
//
} /* end of [atsruntime_raise] */

/* ****** ****** */

/* end of [pats_ccomp_runtime_exn.c] */
