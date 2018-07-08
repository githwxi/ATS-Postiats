/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
*) */

/* ****** ****** */

/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/array.atxt
** Time of generation: Fri Feb 28 17:55:37 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_PRELUDE_CATS_ARRAY
#define ATS2CPP_PRELUDE_CATS_ARRAY

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_array_foreach_funenv_tsz
(
  atstype_ptr A
, atstype_size n
, atstype_size tsz
, atstype_funptr f
, atstype_boxed env
) {
  char *p ;
  atstype_size i ;
  p = (char*)A ;
  for (i = 0 ; i < n ; i += 1)
  {
    ((void(*)(void*, void*))(f))(p, env) ; p += tsz ;
  }
  return ;
} // end of [atspre_array_foreach_funenv_tsz]

/* ****** ****** */

#endif // ifndef(ATS2CPP_PRELUDE_CATS_ARRAY)

/* ****** ****** */

/* end of [array.cats] */
