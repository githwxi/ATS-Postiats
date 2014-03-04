/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
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

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_STDARG_CATS
#define ATS_LIBC_STDARG_CATS

/* ****** ****** */

#include <stdarg.h>

/* ****** ****** */

ATSinline()
ats_bool_type
atslib_va_arg_bool (ats_ref_type ap)
  { return va_arg(*(va_list*)ap, ats_int_type) ; }
// end of ...

ATSinline()
ats_char_type // note the need for alignment
atslib_va_arg_char (ats_ref_type ap)
  { return va_arg(*(va_list*)ap, ats_int_type) ; }
// end of ...

ATSinline()
ats_int_type
atslib_va_arg_int (ats_ref_type ap)
  { return va_arg(*(va_list*)ap, ats_int_type) ; }
// end of ...

ATSinline()
ats_ptr_type
atslib_va_arg_ptr (ats_ref_type ap)
  { return va_arg(*(va_list*)ap, ats_ptr_type) ; }
// end of ...

/* ****** ****** */

ATSinline()
ats_void_type
atslib_va_end (ats_ref_type ap) { va_end(*(va_list*)ap) ; return ; }

/* ****** ****** */

ATSinline()
ats_void_type
atslib_va_copy (ats_ref_type dst, va_list src) {
  va_copy(*(va_list*)dst, src) ; return ; // do dst and src share?
} // end of [atslib_va_copy]

/* ****** ****** */

#endif /* ATS_LIBC_STDARG_CATS */

/* end of [stdarg.cats] */
