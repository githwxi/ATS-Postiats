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

#ifndef Z3_Z3_QUANTIFIER_CATS
#define Z3_Z3_QUANTIFIER_CATS

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_bound
(
  Z3_context ctx, int index, Z3_sort ty
) {
  return
  atscntrb_Z3_inc_ref(ctx, Z3_mk_bound(ctx, index, ty)) ;
} // end of [atscntrb_Z3_mk_bound]

/* ****** ****** */

ATSinline()
Z3_pattern
atscntrb_Z3_mk_pattern
(
  Z3_context ctx, int n, Z3_ast *terms
) {
  Z3_pattern
  pat = Z3_mk_pattern(ctx, n, terms);
  Z3_inc_ref(ctx, Z3_pattern_to_ast(ctx, pat));
  return pat;
} // end of [atscntrb_Z3_mk_pattern]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_forall
(
  Z3_context ctx
, int weight
, int npat, Z3_pattern *patterns
, int ndec, Z3_sort *sorts, Z3_symbol *names
, Z3_ast body
) {
  return
  atscntrb_Z3_inc_ref
  ( ctx
  , Z3_mk_forall(ctx, weight, npat, patterns, ndec, sorts, names, body)
  ) ; // atscntrb_Z3_inc_ref
} // end of [atscntrb_Z3_mk_forall]

ATSinline()
Z3_ast
atscntrb_Z3_mk_exists
(
  Z3_context ctx
, int weight
, int npat, Z3_pattern *patterns
, int ndec, Z3_sort *sorts, Z3_symbol *names
, Z3_ast body
) {
  return
  atscntrb_Z3_inc_ref
  ( ctx
  , Z3_mk_exists(ctx, weight, npat, patterns, ndec, sorts, names, body)
  ) ; // atscntrb_Z3_inc_ref
} // end of [atscntrb_Z3_mk_exists]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_quantifier
(
  Z3_context ctx
, int forall
, int weight
, int npat, Z3_pattern *patterns
, int ndec, Z3_sort *sorts, Z3_symbol *names
, Z3_ast body
) {
  return
  atscntrb_Z3_inc_ref
  ( ctx
  , Z3_mk_quantifier(ctx, forall, weight, npat, patterns, ndec, sorts, names, body)
  ) ; // atscntrb_Z3_inc_ref
} // end of [atscntrb_Z3_mk_quantifier]

ATSinline()
Z3_ast
atscntrb_Z3_mk_quantifier_nwp
(
  Z3_context ctx
, int forall
, int ndec, Z3_sort *sorts, Z3_symbol *names
, Z3_ast body
) {
  return
  atscntrb_Z3_inc_ref
  ( ctx
  , Z3_mk_quantifier(ctx, forall, 0, 0, (Z3_pattern*)0, ndec, sorts, names, body)
  ) ; // atscntrb_Z3_inc_ref
} // end of [atscntrb_Z3_mk_quantifier_nwp]

/* ****** ****** */
//
#define \
atscntrb_Z3_pattern_dec_ref(ctx, ty) \
  atscntrb_Z3_dec_ref(ctx, Z3_pattern_to_ast(ctx, ty))
//
ATSinline()
Z3_pattern
atscntrb_Z3_pattern_inc_ref
  (Z3_context ctx, Z3_pattern ty)
{
  Z3_inc_ref(ctx, Z3_pattern_to_ast(ctx, ty)); return ty;
}
//
/* ****** ****** */

#endif // end of [Z3_Z3_QUANTIFIER_CATS]

/* ****** ****** */

/* end of [z3_quantifier.cats] */
