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

#ifndef Z3_Z3_PROPEQ_CATS
#define Z3_Z3_PROPEQ_CATS

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_true
  (Z3_context ctx)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_true(ctx)) ;
} // end of [atscntrb_Z3_mk_true]

ATSinline()
Z3_ast
atscntrb_Z3_mk_false
  (Z3_context ctx)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_false(ctx)) ;
} // end of [atscntrb_Z3_mk_false]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_eq
  (Z3_context ctx, Z3_ast l, Z3_ast r)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_eq(ctx, l, r)) ;
} // end of [atscntrb_Z3_mk_eq]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_not
  (Z3_context ctx, Z3_ast arg)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_not(ctx, arg)) ;
} // end of [atscntrb_Z3_mk_not]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_or2
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  Z3_ast a01[2] ;
  a01[0] = a0 ; a01[1] = a1 ;
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_or(ctx, 2, a01)) ;
} // end of [atscntrb_Z3_mk_or2]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_and2
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  Z3_ast a01[2] ;
  a01[0] = a0 ; a01[1] = a1 ;
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_and(ctx, 2, a01)) ;
} // end of [atscntrb_Z3_mk_and2]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_implies
  (Z3_context ctx, Z3_ast a0, Z3_ast a1)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_implies(ctx, a0, a1)) ;
} // end of [atscntrb_Z3_mk_implies]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_ite
  (Z3_context ctx, Z3_ast a0, Z3_ast a1, Z3_ast a2)
{
  return atscntrb_Z3_inc_ref(ctx, Z3_mk_ite(ctx, a0, a1, a2)) ;
} // end of [atscntrb_Z3_mk_ite]

/* ****** ****** */

#endif // end of [Z3_Z3_PROPEQ_CATS]

/* ****** ****** */

/* end of [z3_propeq.cats] */
