(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
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
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload SYM = "pats_symbol.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_stacst2"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_trans2_env.sats"
staload "pats_stacst2.sats"

(* ****** ****** *)

abstype s2cstnul (l:addr)
typedef s2cstnul = [l:agez] s2cstnul (l)

extern
castfn s2cstnul_none (x: ptr null):<> s2cstnul (null)

extern
castfn s2cstnul_some (x: s2cst):<> [l:agz] s2cstnul (l)
extern
castfn s2cstnul_unsome {l:agz} (x: s2cstnul l):<> s2cst

extern
fun s2cstnul_is_null {l:addr}
  (x: s2cstnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [s2cstnul_is_null]
extern
fun s2cstnul_isnot_null {l:addr}
  (x: s2cstnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [s2cstnul_isnot_null]

(* ****** ****** *)

local

typedef
syms2cst_struct = @{
  sym= symbol, cst= s2cstnul
} // end of [syms2cst_struct]

assume s2cstref_type = ref (syms2cst_struct)

in // in of [local]

fun s2cstref_get_sym
  (r: s2cstref): symbol = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->sym
end // end of [s2cstref_get_sym]

fun s2cstref_get_cstnul
  (r: s2cstref): s2cstnul = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst
end // end of [s2cstref_get_cstnul]
fun s2cstref_set_cstnul
  (r: s2cstref, s2c: s2cstnul): void = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst := s2c
end // end of [s2cstref_set_cstnul]

implement
s2cstref_make (name) = let
  val id = $SYM.symbol_make_string (name)
  val (pfgc, pfat | p) = ptr_alloc<syms2cst_struct> ()
  prval () = free_gc_elim (pfgc)
  val () = (p->sym := id; p->cst := s2cstnul_none (null))
in
  ref_make_view_ptr (pfat | p)
end  // end of [s2cstref_make]

end // end of [local]

(* ****** ****** *)

implement
s2cstref_get_cst (r) = let
//
fn auxerr
  (id: symbol): s2cst = let
  val () = prerr_interror ()
  val () = prerr ": s2cstref_get_cst: "
  val () = prerr "the pervasive static constant ["
  val () = $SYM.prerr_symbol (id)
  val () = prerr "] is not available."
  val () = prerr_newline ();
in
  $ERR.abort {s2cst} ()
end (* end of [auxerr] *)
//
  val s2c = s2cstref_get_cstnul (r)
  val isnul = s2cstnul_is_null (s2c)
//
in
//
if isnul then let
  val id = s2cstref_get_sym (r)
  val ans = the_s2expenv_pervasive_find (id)
in
//
case+ ans of
| ~Some_vt (s2i) => (
  case+ s2i of
  | S2ITMcst s2cs => let
      val- list_cons (s2c, _) = s2cs
      val () = s2cstref_set_cstnul (r, s2cstnul_some (s2c))
    in
      s2c
    end // end of [S2ITMcst]
  | _ => auxerr (id)
  ) // end of [Some_vt]
| ~None_vt () => auxerr (id)
//
end else
  s2cstnul_unsome (s2c)
// end of [if]
end // end of [s2cstref_get_cst]

(* ****** ****** *)

implement
s2cstref_equ_cst (r, s2c) =
  eq_s2cst_s2cst (s2cstref_get_cst (r), s2c)
// end of [s2cstref_equ_cst]

implement
s2cstref_equ_exp
  (r, s2e) = begin
  case+ s2e.s2exp_node of
  | S2Ecst s2c => s2cstref_equ_cst (r, s2c)
  | S2Eapp (s2e, _) => s2cstref_equ_exp (r, s2e)
  | _ => false
end // end of [s2cstref_equ_exp]

(* ****** ****** *)

implement
the_true_bool = s2cstref_make ("true_bool")
implement
the_false_bool = s2cstref_make ("false_bool")

implement
s2exp_bool (b) = let
  val s2cref = (
    if b then the_true_bool else the_false_bool
  ) : s2cstref // end of [val]
in
  s2exp_cst (s2cstref_get_cst (s2cref))
end // end of [s2exp_bool]

implement
the_bool_t0ype = s2cstref_make "bool_t0ype"
implement
the_bool_bool_t0ype = s2cstref_make "bool_bool_t0ype"

implement
s2exp_bool_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_bool_t0ype))
// end of [s2exp_bool_t0ype]

implement
s2exp_bool_bool_t0ype (b) = let
  val s2c = s2cstref_get_cst (the_bool_bool_t0ype)
  val ind = s2exp_bool (b)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_bool_bool_t0ype]

implement
s2exp_bool_index_t0ype (ind) = let
  val s2c = s2cstref_get_cst (the_bool_bool_t0ype)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_bool_index_t0ype]

(* ****** ****** *)

implement
the_int_kind = s2cstref_make "int_kind"
implement
the_lint_kind = s2cstref_make "lint_kind"
implement
the_llint_kind = s2cstref_make "llint_kind"
implement
the_size_kind = s2cstref_make "size_kind"
implement
the_g0int_t0ype = s2cstref_make "g0int_t0ype"
implement
the_g1int_int_t0ype = s2cstref_make "g1int_int_t0ype"
implement
the_g0uint_t0ype = s2cstref_make "g0uint_t0ype"
implement
the_g1uint_int_t0ype = s2cstref_make "g1uint_int_t0ype"

local

fun auxg0i
  (knd: s2cst): s2exp = let
  val knd = s2exp_cst (knd)
  val g0i = s2cstref_get_cst (the_g0int_t0ype)
in
  s2exp_cstapp (g0i, list_sing (knd))
end // end of [auxg0i]

fun auxg0u
  (knd: s2cst): s2exp = let
  val knd = s2exp_cst (knd)
  val g0u = s2cstref_get_cst (the_g0uint_t0ype)
in
  s2exp_cstapp (g0u, list_sing (knd))
end // end of [auxg0u]

fun auxg1i (
  knd: s2cst, ind: s2exp
) : s2exp = let
  val knd = s2exp_cst (knd)
  val g1i = s2cstref_get_cst (the_g1int_int_t0ype)
in
  s2exp_cstapp (g1i, list_pair (knd, ind))
end // end of [auxg1i]

fun auxg1u (
  knd: s2cst, ind: s2exp
) : s2exp = let
  val knd = s2exp_cst (knd)
  val g1u = s2cstref_get_cst (the_g1uint_int_t0ype)
in
  s2exp_cstapp (g1u, list_pair (knd, ind))
end // end of [auxg1u]

in // in of [local]

implement
s2exp_int_t0ype () =
  auxg0i (s2cstref_get_cst (the_int_kind))
// end of [s2exp_int_t0ype]

implement
s2exp_uint_t0ype () =
  auxg0u (s2cstref_get_cst (the_int_kind))
// end of [s2exp_uint_t0ype]

implement
s2exp_lint_t0ype () =
  auxg0u (s2cstref_get_cst (the_lint_kind))
// end of [s2exp_lint_t0ype]

implement
s2exp_ulint_t0ype () =
  auxg0u (s2cstref_get_cst (the_lint_kind))
// end of [s2exp_ulint_t0ype]

implement
s2exp_llint_t0ype () =
  auxg0u (s2cstref_get_cst (the_llint_kind))
// end of [s2exp_llint_t0ype]

implement
s2exp_ullint_t0ype () =
  auxg0u (s2cstref_get_cst (the_llint_kind))
// end of [s2exp_ullint_t0ype]

(* ****** ****** *)

implement
s2exp_int_int_t0ype (i) = let
  val knd = s2cstref_get_cst (the_int_kind)
  val ind = s2exp_int (i)
in
  auxg1i (knd, ind)
end // end of [s2exp_int_int_t0ype]

implement
s2exp_int_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_int_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1i (knd, ind)
end // end of [s2exp_int_intinf_t0ype]

(* ****** ****** *)

implement
s2exp_uint_int_t0ype (i) = let
  val knd = s2cstref_get_cst (the_int_kind)
  val ind = s2exp_int (i)
in
  auxg1u (knd, ind)
end // end of [s2exp_uint_intinf_t0ype]

implement
s2exp_uint_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_int_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1u (knd, ind)
end // end of [s2exp_uint_intinf_t0ype]

(* ****** ****** *)

implement
s2exp_lint_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_lint_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1i (knd, ind)
end // end of [s2exp_lint_intinf_t0ype]

implement
s2exp_ulint_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_lint_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1u (knd, ind)
end // end of [s2exp_ulint_intinf_t0ype]

implement
s2exp_llint_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_llint_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1i (knd, ind)
end // end of [s2exp_llint_intinf_t0ype]

implement
s2exp_ullint_intinf_t0ype (inf) = let
  val knd = s2cstref_get_cst (the_llint_kind)
  val ind = s2exp_intinf (inf)
in
  auxg1u (knd, ind)
end // end of [s2exp_ullint_intinf_t0ype]

end // end of [local]

(* ****** ****** *)

implement
s2exp_g0int_kind_t0ype (knd) = let
  val g0i = s2cstref_get_cst (the_g0int_t0ype)
in
  s2exp_cstapp (g0i, list_sing (knd))
end // end of [s2exp_g0int_kind_t0ype]

implement
s2exp_g1int_kind_index_t0ype
  (knd, ind) = let
  val g1i = s2cstref_get_cst (the_g1int_int_t0ype)
in
  s2exp_cstapp (g1i, list_pair (knd, ind))
end // end of [s2exp_g1int_kind_index_t0ype]

(* ****** ****** *)

implement
s2exp_g0uint_kind_t0ype (knd) = let
  val g0u = s2cstref_get_cst (the_g0uint_t0ype)
in
  s2exp_cstapp (g0u, list_sing (knd))
end // end of [s2exp_g0uint_kind_t0ype]

implement
s2exp_g1uint_kind_index_t0ype
  (knd, ind) = let
  val g1u = s2cstref_get_cst (the_g1uint_int_t0ype)
in
  s2exp_cstapp (g1u, list_pair (knd, ind))
end // end of [s2exp_g1uint_kind_index_t0ype]

(* ****** ****** *)

implement
s2exp_int_index_t0ype (ind) = let
  val knd = s2cstref_get_cst (the_int_kind) in
  s2exp_g1int_kind_index_t0ype (s2exp_cst (knd), ind)
end // end of [s2exp_int_index_t0ype]

implement
s2exp_uint_index_t0ype (ind) = let
  val knd = s2cstref_get_cst (the_int_kind) in
  s2exp_g1uint_kind_index_t0ype (s2exp_cst (knd), ind)
end // end of [s2exp_uint_index_t0ype]

(* ****** ****** *)

implement
the_char_t0ype = s2cstref_make "char_t0ype"
implement
the_char_char_t0ype = s2cstref_make "char_char_t0ype"

implement
s2exp_char_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_char_t0ype))
// end of [s2exp_char_t0ype]

implement
s2exp_char_char_t0ype (c) = let
  val s2c = s2cstref_get_cst (the_char_char_t0ype)
  val ind = s2exp_char (c)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_char_char_t0ype]

implement
s2exp_char_index_t0ype (ind) = let
  val s2c = s2cstref_get_cst (the_char_char_t0ype)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_char_index_t0ype]

(* ****** ****** *)

implement
the_schar_t0ype = s2cstref_make "schar_t0ype"
implement
the_schar_char_t0ype = s2cstref_make "schar_char_t0ype"

implement
s2exp_schar_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_schar_t0ype))
// end of [s2exp_schar_t0ype]

implement
s2exp_schar_char_t0ype (c) = let
  val s2c = s2cstref_get_cst (the_schar_char_t0ype)
  val ind = s2exp_char (c)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_schar_char_t0ype]

implement
the_uchar_t0ype = s2cstref_make "uchar_t0ype"
implement
the_uchar_char_t0ype = s2cstref_make "uchar_char_t0ype"

implement
s2exp_uchar_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_uchar_t0ype))
// end of [s2exp_uchar_t0ype]

implement
s2exp_uchar_char_t0ype (c) = let
  val s2c = s2cstref_get_cst (the_uchar_char_t0ype)
  val ind = s2exp_char (c)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_uchar_char_t0ype]

(* ****** ****** *)

implement
the_string_type = s2cstref_make "string_type"
implement
the_string_int_type = s2cstref_make "string_int_type"

implement
s2exp_string_type () =
  s2exp_cst (s2cstref_get_cst (the_string_type))
// end of [s2exp_string_type]

implement
s2exp_string_int_type (n) = let
//
// HX: the cast is okay as we do not attempt
// to handle string of extremely long length
//
  val ind = s2exp_int ((int_of_size)n)
  val s2c = s2cstref_get_cst (the_string_int_type)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_string_type]

implement
s2exp_string_index_type (ind) = let
  val s2c = s2cstref_get_cst (the_string_int_type)
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_string_index_type]

(* ****** ****** *)
//
implement
the_float_kind = s2cstref_make "float_kind"
implement
the_double_kind = s2cstref_make "double_kind"
implement
the_ldouble_kind = s2cstref_make "ldouble_kind"
implement
the_g0float_t0ype = s2cstref_make "g0float_t0ype"
//
local

fun auxmain
  (knd: s2cst): s2exp = let
  val knd = s2exp_cst (knd)
  val g0f = s2cstref_get_cst (the_g0float_t0ype)
in
  s2exp_cstapp (g0f, list_sing (knd))
end // end of [auxmain]

in // in of [local]

implement
s2exp_float_t0ype () =
  auxmain (s2cstref_get_cst (the_float_kind))
// end of [s2exp_float_t0ype]

implement
s2exp_double_t0ype () =
  auxmain (s2cstref_get_cst (the_double_kind))
// end of [s2exp_double_t0ype]

implement
s2exp_ldouble_t0ype () =
  auxmain (s2cstref_get_cst (the_ldouble_kind))
// end of [s2exp_ldouble_t0ype]

end // end of [local]

(* ****** ****** *)

implement
the_void_t0ype = s2cstref_make "void_t0ype"
implement
s2exp_void_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_void_t0ype))
// end of [s2exp_void_t0ype]

(* ****** ****** *)

implement
the_exception_viewtype = s2cstref_make "exception_viewtype"

(* ****** ****** *)

implement
the_arrsz_viewt0ype_int_viewt0ype =
  s2cstref_make "arrsz_viewt0ype_int_viewt0ype"
implement
s2exp_arrsz_viewt0ype_int_viewt0ype (s2e, s2i) = let
  val ind = s2exp_int (s2i)
  val s2c = s2cstref_get_cst (the_arrsz_viewt0ype_int_viewt0ype)
in
  s2exp_cstapp (s2c, list_pair (s2e, ind))
end // end of [s2exp_list_viewt0ype_int_viewtype]

(* ****** ****** *)

implement
the_list0_t0ype_type =
  s2cstref_make "list0_t0ype_type"
implement
s2exp_list0_t0ype_type (s2e) = let
  val s2c = s2cstref_get_cst (the_list0_t0ype_type)
in
  s2exp_cstapp (s2c, list_sing (s2e))
end // end of [s2exp_list0_t0ype_type]

implement
the_list_t0ype_int_type =
  s2cstref_make "list_t0ype_int_type"
implement
s2exp_list_t0ype_int_type (s2e, s2i) = let
  val ind = s2exp_int (s2i)
  val s2c = s2cstref_get_cst (the_list_t0ype_int_type)
in
  s2exp_cstapp (s2c, list_pair (s2e,  ind))
end // end of [s2exp_list_t0ype_int_type]

implement
the_list_viewt0ype_int_viewtype =
  s2cstref_make "list_viewt0ype_int_viewtype"
implement
s2exp_list_viewt0ype_int_viewtype (s2e, s2i) = let
  val ind = s2exp_int (s2i)
  val s2c = s2cstref_get_cst (the_list_viewt0ype_int_viewtype)
in
  s2exp_cstapp (s2c, list_pair (s2e, ind))
end // end of [s2exp_list_viewt0ype_int_viewtype]

(* ****** ****** *)

extern
fun at_viewt0ype_addr_view_assume (): void
extern
fun sizeof_viewt0ype_int_assume (): void
extern
fun invar_t0ype_t0ype_assume (): void
extern
fun invar_viewt0ype_viewt0ype_assume (): void

implement
stacst2_initialize () = () where {
//
  val () = at_viewt0ype_addr_view_assume ()
//
  val () = sizeof_viewt0ype_int_assume () // sizeof(VT)
//
  val () = invar_t0ype_t0ype_assume ()
  val () = invar_viewt0ype_viewt0ype_assume ()
//
} // end of [stacst2_initialize]

(* ****** ****** *)

implement
the_at_viewt0ype_addr_view =
  s2cstref_make "at_viewt0ype_addr_view" // in prelude/basics_pre.sats
// end of [the_at_viewt0ype_addr_view]

implement
at_viewt0ype_addr_view_assume () = let
  val s2c = s2cstref_get_cst (the_at_viewt0ype_addr_view)
  val s2t_def = s2cst_get_srt (s2c)
  val s2v1 = s2var_make_srt s2rt_viewt0ype and s2v2 = s2var_make_srt s2rt_addr
  val arg1 = s2exp_var (s2v1)
  val arg2 = s2exp_var (s2v2)
  val s2f_body = s2exp_at (arg1, arg2)
  val s2e_def = s2exp_lam_srt (s2t_def, '[s2v1, s2v2], s2f_body)
in
  s2cst_set_def (s2c, Some s2e_def)
end // end of [at_viewt0ype_addr_view_assume]

(* ****** ****** *)

implement
the_sizeof_viewt0ype_int =
  s2cstref_make "sizeof_viewt0ype_int" // in prelude/basics_pre.sats
// end of [the_sizeof_viewt0ype_int]

implement
sizeof_viewt0ype_int_assume () = let
  val s2c = s2cstref_get_cst (the_sizeof_viewt0ype_int)
  val s2t_def = s2cst_get_srt s2c
  val s2v = s2var_make_srt s2rt_t0ype
  val arg = s2exp_var (s2v)
  val s2e_body = s2exp_sizeof (arg)
  val s2e_def = s2exp_lam_srt (s2t_def, '[s2v], s2e_body)
in
  s2cst_set_def (s2c, Some s2e_def)
end // end of [sizeof_viewt0ype_int_assume]

(* ****** ****** *)

implement
the_invar_t0ype_t0ype =
  s2cstref_make "invar_t0ype_t0ype" // in prelude/basics_pre.sats
// end of [the_invar_t0ype_t0ype]

implement
invar_t0ype_t0ype_assume () = let
  val s2c = s2cstref_get_cst (the_invar_t0ype_t0ype)
  val s2t_def = s2cst_get_srt s2c
  val s2v = s2var_make_srt s2rt_t0ype
  val arg = s2exp_var (s2v)
  val s2e_body = s2exp_invar (arg)
  val s2e_def = s2exp_lam_srt (s2t_def, '[s2v], s2e_body)
in
  s2cst_set_def (s2c, Some s2e_def)
end // end of [invar_t0ype_t0ype_assume]

implement
the_invar_viewt0ype_viewt0ype =
  s2cstref_make "invar_viewt0ype_viewt0ype" // in prelude/basics_pre.sats
// end of [the_invar_viewt0ype_viewt0ype]

implement
invar_viewt0ype_viewt0ype_assume () = let
  val s2c = s2cstref_get_cst (the_invar_viewt0ype_viewt0ype)
  val s2t_def = s2cst_get_srt s2c
  val s2v = s2var_make_srt s2rt_viewt0ype
  val arg = s2exp_var (s2v)
  val s2e_body = s2exp_invar (arg)
  val s2e_def = s2exp_lam_srt (s2t_def, '[s2v], s2e_body)
in
  s2cst_set_def (s2c, Some s2e_def)
end // end of [invar_viewt0ype_viewt0ype_assume]

(* ****** ****** *)

(* end of [pats_stacst2.dats] *)
