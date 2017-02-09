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

#ifndef Z3_Z3_CONSTAPP_CATS
#define Z3_Z3_CONSTAPP_CATS

/* ****** ****** */

#define \
atscntrb_Z3_mk_const(ctx, sym, ty) \
  atscntrb_Z3_inc_ref(ctx, Z3_mk_const(ctx, sym, ty))

/* ****** ****** */

#define \
atscntrb_Z3_mk_fresh_const(ctx, prefix, ty) \
  atscntrb_Z3_inc_ref(ctx, Z3_mk_fresh_const(ctx, prefix, ty))

/* ****** ****** */

ATSinline()
Z3_func_decl
atscntrb_Z3_mk_func_decl
(
  Z3_context ctx
, Z3_symbol sym
, int n, Z3_sort *args, Z3_sort res
)
{
  Z3_func_decl
  fd = Z3_mk_func_decl(ctx, sym, n, args, res);
  Z3_inc_ref(ctx, Z3_func_decl_to_ast(ctx, fd));
  return fd;
} // end of [atscntrb_Z3_mk_func_decl]

/* ****** ****** */

ATSinline()
Z3_func_decl
atscntrb_Z3_mk_func_decl_0
(
  Z3_context ctx
, Z3_symbol sym, Z3_sort res
)
{
  return
  atscntrb_Z3_mk_func_decl(ctx, sym, 0, (Z3_sort*)0, res);
}

ATSinline()
Z3_func_decl
atscntrb_Z3_mk_func_decl_1
(
  Z3_context ctx
, Z3_symbol sym, Z3_sort arg, Z3_sort res
)
{
  Z3_sort args[1] = {arg};
  return atscntrb_Z3_mk_func_decl(ctx, sym, 1, args, res);
}

ATSinline()
Z3_func_decl
atscntrb_Z3_mk_func_decl_2
(
  Z3_context ctx
, Z3_symbol sym, Z3_sort arg0, Z3_sort arg1, Z3_sort res
)
{
  Z3_sort args[2] = {arg0, arg1};
  return atscntrb_Z3_mk_func_decl(ctx, sym, 2, args, res);
}

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_app
(
  Z3_context ctx
, Z3_func_decl fd, int n, Z3_ast *args
)
{
  Z3_ast
  ast = Z3_mk_app(ctx, fd, n, args);
  return atscntrb_Z3_inc_ref(ctx, ast);
} // end of [atscntrb_Z3_mk_app]

/* ****** ****** */

ATSinline()
Z3_ast
atscntrb_Z3_mk_app_0
(
  Z3_context ctx
, Z3_func_decl fd
)
{
  return
  atscntrb_Z3_mk_app(ctx, fd, 0, (Z3_ast*)0);
}

ATSinline()
Z3_ast
atscntrb_Z3_mk_app_1
(
  Z3_context ctx
, Z3_func_decl fd, Z3_ast arg
)
{
  Z3_ast args[1] = {arg};
  return atscntrb_Z3_mk_app(ctx, fd, 1, args);
}

ATSinline()
Z3_ast
atscntrb_Z3_mk_app_2
(
  Z3_context ctx
, Z3_func_decl fd, Z3_ast a0, Z3_ast a1
)
{
  Z3_ast args[2] = {a0, a1};
  return atscntrb_Z3_mk_app(ctx, fd, 2, args);
}

/* ****** ****** */
//
#define \
atscntrb_Z3_func_decl_dec_ref(ctx, fd) \
  atscntrb_Z3_dec_ref(ctx, Z3_func_decl_to_ast(ctx, fd))
//
ATSinline()
Z3_func_decl
atscntrb_Z3_func_decl_inc_ref
  (Z3_context ctx, Z3_func_decl fd)
{
  Z3_inc_ref(ctx, Z3_func_decl_to_ast(ctx, fd)); return fd;
}
//
/* ****** ****** */

#endif // end of [Z3_Z3_CONSTAPP_CATS]

/* ****** ****** */

/* end of [z3_constapp.cats] */
