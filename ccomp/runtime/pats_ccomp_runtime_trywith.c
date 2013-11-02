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
#include "pats_ccomp_basics.h"
#include "pats_ccomp_typedefs.h"
#include "pats_ccomp_exception.h"
//
/* ****** ****** */
//
// HX-2013-06:
// it is only for single-threaded programs
//
/* ****** ****** */

extern
atsexnframe_ptr
*my_atsexnframe_getref ()
{
//
static
atsexnframe_t *my_atsexnframe = (void*)0 ;
//
return &(my_atsexnframe) ;
//
} // end of [my_atsexnframe_getref]

/* ****** ****** */

extern
void
atsruntime_raise
  (void *exn0)
{
//
  atsexnframe_t *frame ;
  frame = *(my_atsexnframe_getref()) ;
//
  do {
    if (!frame) break ;
    (frame)->exn = (atstype_exnconptr)exn0 ;
    atspre_longjmp((frame)->env, 1/*retval*/) ;
  } while (0) ; // end of [do]
//
  atsruntime_handle_uncaughtexn(exn0) ;
//
  return ;
//
} /* end of [atsruntime_raise] */

/* ****** ****** */

/* end of [pats_ccomp_runtime_trywith.c] */
