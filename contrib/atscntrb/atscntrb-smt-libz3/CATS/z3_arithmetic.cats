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

#ifndef Z3_Z3_ARITHMETIC_CATS
#define Z3_Z3_ARITHMETIC_CATS

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_unary_minus
  (Z3_context ctx, Z3_ast arg)
{
  return
  atscntrb_Z3_inc_ref(
    ctx, Z3_mk_unary_minus(ctx, arg)
  ) ; // end of [return]
} // end of [atscntrb_Z3_mk_unary_minus]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_add
  (Z3_context ctx, int n, Z3_ast *args)
{
  return
  atscntrb_Z3_inc_ref(ctx, Z3_mk_add(ctx, n, args)) ;
} // end of [atscntrb_Z3_mk_add]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_sub
  (Z3_context ctx, int n, Z3_ast *args)
{
  return
  atscntrb_Z3_inc_ref(ctx, Z3_mk_sub(ctx, n, args)) ;
} // end of [atscntrb_Z3_mk_sub]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_mul
  (Z3_context ctx, int n, Z3_ast *args)
{
  return
  atscntrb_Z3_inc_ref(ctx, Z3_mk_mul(ctx, n, args)) ;
} // end of [atscntrb_Z3_mk_mul]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_div
  (Z3_context ctx, Z3_ast arg0, Z3_ast arg1)
{
  return
  atscntrb_Z3_inc_ref(ctx, Z3_mk_div(ctx, arg0, arg1)) ;
} // end of [atscntrb_Z3_mk_div]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_add2
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  Z3_ast a01[2] ;
  a01[0] = a0 ; a01[1] = a1 ;
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_add(ctx, 2, a01)) ;
} // end of [atscntrb_Z3_mk_add2]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_sub2
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  Z3_ast a01[2] ;
  a01[0] = a0 ; a01[1] = a1 ;
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_sub(ctx, 2, a01)) ;
} // end of [atscntrb_Z3_mk_sub2]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_mul2
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  Z3_ast a01[2] ;
  a01[0] = a0 ; a01[1] = a1 ;
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_mul(ctx, 2, a01)) ;
} // end of [atscntrb_Z3_mk_mul2]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_lt
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_lt(ctx, a0, a1)) ;
} // end of [atscntrb_Z3_mk_lt]

ATSinline()
Z3_ast
atscntrb_Z3_mk_le
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_le(ctx, a0, a1)) ;
} // end of [atscntrb_Z3_mk_le]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_gt
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_gt(ctx, a0, a1)) ;
} // end of [atscntrb_Z3_mk_gt]

ATSinline()
Z3_ast
atscntrb_Z3_mk_ge
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_ge(ctx, a0, a1)) ;
} // end of [atscntrb_Z3_mk_ge]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_int2real
  (Z3_context ctx, Z3_ast a0)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_int2real(ctx, a0)) ;
} // end of [atscntrb_Z3_mk_int2real]

/* ****** ****** */

#endif // end of [Z3_Z3_ARITHMETIC_CATS]

/* ****** ****** */

/* end of [z3_airthmetic.cats] */
