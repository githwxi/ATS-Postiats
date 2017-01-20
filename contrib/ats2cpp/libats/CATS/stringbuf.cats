/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: November, 2013 *)
*/

/* ****** ****** */

#ifndef ATS2CPP_LIBATS_CATS_STRINGBUF
#define ATS2CPP_LIBATS_CATS_STRINGBUF

/* ****** ****** */

#include <stdarg.h>
#include <string.h>

/* ****** ****** */

#define atslib_stringbuf_memcpy memcpy
#define atslib_stringbuf_memmove memmove

/* ****** ****** */

/*
extern
fun _stringbuf_pow2min
  (sizeGte(1), size_t): sizeGte(1) = "mac#%"
implement
_stringbuf_pow2min (s1, s2) =
  if s1 >= s2
    then s1 else _stringbuf_pow2min (s1+s1, s2)
  // end of [if]
*/
ATSinline()
atstype_size
atslib__stringbuf_pow2min
(
  atstype_size s1, atstype_size s2
)
{
  while (s1 < s2) { s1 = s1 + s1 ; } ; return s1 ; 
} // end of [atslib__stringbuf_pow2min]

/* ****** ****** */
//
extern "C"
{
atstype_int
atslib_stringbuf_insert_snprintf
  (atstype_ptr sbf, atstype_int recap, atstype_string fmt, ...) ;
}
extern "C"
{
atstype_int
atslib_stringbuf_insert_vsnprintf
(
  atstype_ptr sbf, atstype_int recap, atstype_string fmt, va_list ap
) ; // end of [atslib_stringbuf_insert_vsnprintf]
}
//
/* ****** ****** */

#endif // ifndef(ATS2CPP_LIBATS_CATS_STRINGBUF)

/* ****** ****** */

/* end of [stringbuf.cats] */
