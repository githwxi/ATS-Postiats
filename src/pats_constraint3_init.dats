(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
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
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: February, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

local
//
fun
f_identity (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val-list_cons (s2e1, s2es) = s2es
in
  s3exp_make (env, s2e1)
end // end of [identity]
//
// HX: functions on static booleans
//
fun
f_neg_bool (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val-list_cons (s2e, s2es) = s2es
  val s3be = s3exp_make (env, s2e)
in
  s3exp_bneg (s3be)
end // end of [f_neg_bool]
//
fun
f_add_bool_bool (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3be1 = s3exp_make (env, s2e1)
  val s3be2 = s3exp_make (env, s2e2)
in
  s3exp_badd (s3be1, s3be2)
end // end of [f_add_bool_bool]
//
fun
f_mul_bool_bool (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3be1 = s3exp_make (env, s2e1)
  val s3be2 = s3exp_make (env, s2e2)
in
  s3exp_bmul (s3be1, s3be2)
end // end of [f_mul_bool_bool]
//
fun
f_eq_bool_bool (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3be1 = s3exp_make (env, s2e1)
  val s3be2 = s3exp_make (env, s2e2)
in
  s3exp_beq (s3be1, s3be2)
end // end of [f_eq_bool_bool]
//
fun
f_neq_bool_bool (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3be1 = s3exp_make (env, s2e1)
  val s3be2 = s3exp_make (env, s2e2)
in
  s3exp_bneq (s3be1, s3be2)
end // end of [f_neq_bool_bool]
//
// HX: functions on static integers
//
fun
f_neg_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
in
  s3exp_ineg (s3ie1)
end // end of [f_neg_int]
//
fun
f_add_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_iadd (s3ie1, s3ie2)
end // end of [f_add_int_int]
//
fun
f_sub_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_isub (s3ie1, s3ie2)
end // end of [f_sub_int_int]
//
fun
f_mul_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_imul (s3ie1, s3ie2)
end // end of [f_mul_int_int]
//
fun
f_ndiv_int_int
(
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_ndivrel_int_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_ndiv_int_int]
fun
f_idiv_int_int
(
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2es0 = s2es
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val sgn = (
    case+ s2e2.s2exp_node of
    | S2Eint (i) => compare_int_int (i, 0)
    | S2Eintinf (i) => $INTINF.compare_intinf_int (i, 0)
    | _ => 0 (* HX: no integer constant *)
  ) : int // end of [val]
  val s2c = (
    if sgn != 0 then
      s2cstref_get_cst (the_ndivrel_int_int_int)
    else 
      s2cstref_get_cst (the_idivrel_int_int_int)
  ) : s2cst // end of [val]
//
// HX: note that x/y = ~(x/(~y)) if y < 0
//
  val s2es = (
    if sgn >= 0 then
      s2es0 else list_pair (s2e1, s2exp_ineg (s2e2))
    // end of [if]
  ) : s2explst // end of [val]
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
  val s3e = s3exp_var (s2v)
in
  if sgn >= 0 then s3e else s3exp_ineg (s3e)
end // end of [f_idiv_int_int]
//
fun
f_lt_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_ilt (s3ie1, s3ie2)
end // end of [f_lt_int_int]
//
fun
f_lte_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_ilte (s3ie1, s3ie2)
end // end of [f_lte_int_int]
//
fun
f_gt_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_igt (s3ie1, s3ie2)
end // end of [f_gt_int_int]
//
fun
f_gte_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_igte (s3ie1, s3ie2)
end // end of [f_gte_int_int]
//
fun
f_eq_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_ieq (s3ie1, s3ie2)
end // end of [f_eq_int_int]
//
fun
f_neq_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let 
  val-list_cons (s2e1, s2es) = s2es
  val-list_cons (s2e2, s2es) = s2es
  val s3ie1 = s3exp_make (env, s2e1)
  val s3ie2 = s3exp_make (env, s2e2)
in
  s3exp_ineq (s3ie1, s3ie2)
end // end of [f_neq_int_int]
//
fun f_abs_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_absrel_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_abs_int]
//
fun f_sgn_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_sgnrel_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_sgn_int]
//
fun
f_max_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_maxrel_int_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_max_int_int]
//
fun
f_min_int_int (
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_minrel_int_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_min_int_int]
//
fun
f_ifint_bool_int_int
(
  env: &s2vbcfenv, s2es: s2explst
) : s3exp = let
  val s2c = s2cstref_get_cst (the_ifintrel_bool_int_int_int)
  val s2v = s2vbcfenv_replace_cstapp (env, s2rt_int, s2c, s2es)
in
  s3exp_var (s2v)
end // end of [f_ifint_bool_int_int]
//
// HX: functions on static addresses
//
(*
//
fun f_add_addr_int = f_add_int_int
fun f_sub_addr_int = f_sub_int_int
fun f_sub_addr_addr = f_sub_int_int
//
fun f_lt_addr_addr = f_lt_int_int
fun f_lte_addr_addr = f_lte_int_int
fun f_gt_addr_addr = f_gt_int_int
fun f_gte_addr_addr = f_gte_int_int
fun f_eq_addr_addr = f_eq_int_int
fun f_neq_addr_addr = f_neq_int_int
//
*)
//
// HX: functions on static classes
//
fun
f_lte_cls_cls (
  env: &s2vbcfenv, s2es0: s2explst
) : s3exp = let 
//
(*
val () =
println! ("f_lte_cls_cls: s2es = ", s2es0)
*)
//
val s2c = s2cstref_get_cst (the_lte_cls_cls)
//
val-list_cons (s2e1, s2es1) = s2es0
val-list_cons (s2e2, s2es2) = s2es1
//
val s2e1 = s2exp_hnfize (s2e1) and s2e2 = s2exp_hnfize (s2e2)
//
in
//
case+
(
  s2e1.s2exp_node
, s2e2.s2exp_node
) of (* caseof *)
| (S2Ecst (s2c1),
   S2Ecst (s2c2)) =>
  (
    s3exp_bool (s2cst_lte_cls_cls (s2c1, s2c2))
  )
| (_, _) => let
    val s2c_rel = s2cstref_get_cst (the_lterel_cls_cls)
    val s2v_res =
      s2vbcfenv_replace_cstapp (env, s2rt_bool, s2c_rel, s2es0)
    // end of [val]
(*
    val ((*void*)) = println! ("f_lte_cls_cls: s2v_res = ", s2v_res)
*)
  in
    s3exp_bvar (s2v_res)
  end // end of [_, _]
end // end of [f_lte_cls_cls]
//
(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
constraint3_initialize_map (map) = let
//
typedef tfun = (&s2vbcfenv, s2explst) -<fun1> s3exp
//
fun ins (
  map: &s2cfunmap, r: s2cstref, f: tfun
) : void = let
  val s2c = s2cstref_get_cst (r)
  val map1 = $UN.cast {s2cstmap(tfun)} (map)
  val map2 = s2cstmap_add (map1, s2c, f)
  val () = map := $UN.cast {s2cfunmap} (map2)
in
  (*nothing*)
end // end of [ins]
//
val () = ins (map, the_neg_bool, f_neg_bool)
val () = ins (map, the_add_bool_bool, f_add_bool_bool)
val () = ins (map, the_mul_bool_bool, f_mul_bool_bool)
val () = ins (map, the_eq_bool_bool, f_eq_bool_bool)
val () = ins (map, the_neq_bool_bool, f_neq_bool_bool)
//
val () = ins (map, the_neg_int, f_neg_int)
val () = ins (map, the_add_int_int, f_add_int_int)
val () = ins (map, the_sub_int_int, f_sub_int_int)
val () = ins (map, the_mul_int_int, f_mul_int_int)
val () = ins (map, the_div_int_int, f_idiv_int_int)
val () = ins (map, the_ndiv_int_int, f_ndiv_int_int)
val () = ins (map, the_idiv_int_int, f_idiv_int_int)
//
val () = ins (map, the_lt_int_int, f_lt_int_int)
val () = ins (map, the_lte_int_int, f_lte_int_int)
val () = ins (map, the_gt_int_int, f_gt_int_int)
val () = ins (map, the_gte_int_int, f_gte_int_int)
val () = ins (map, the_eq_int_int, f_eq_int_int)
val () = ins (map, the_neq_int_int, f_neq_int_int)
//
val () = ins (map, the_abs_int, f_abs_int)
val () = ins (map, the_sgn_int, f_sgn_int)
val () = ins (map, the_max_int_int, f_max_int_int)
val () = ins (map, the_min_int_int, f_min_int_int)
//
val () = ins (map, the_ifint_bool_int_int, f_ifint_bool_int_int)
//
(*
val () = ins (map, the_int_of_bool, f_int_of_bool)
val () = ins (map, the_bool_of_int, f_bool_of_int)
*)
(*
val () = ins (map, the_int_of_char, f_identity) // HX: removed
val () = ins (map, the_char_of_int, f_identity) // HX: removed
*)
val () = ins (map, the_int_of_addr, f_identity)
val () = ins (map, the_addr_of_int, f_identity)
//
val () = ins (map, the_add_addr_int, f_add_int_int)
val () = ins (map, the_sub_addr_int, f_sub_int_int)
val () = ins (map, the_sub_addr_addr, f_sub_int_int)
//
val () = ins (map, the_lt_addr_addr, f_lt_int_int)
val () = ins (map, the_lte_addr_addr, f_lte_int_int)
val () = ins (map, the_gt_addr_addr, f_gt_int_int)
val () = ins (map, the_gte_addr_addr, f_gte_int_int)
val () = ins (map, the_eq_addr_addr, f_eq_int_int)
val () = ins (map, the_neq_addr_addr, f_neq_int_int)
//
val () = ins (map, the_lte_cls_cls, f_lte_cls_cls)
(*
val () = ins (map, the_gte_cls_cls, f_gte_cls_cls)
*)
//
in
  (*nothing*)
end // end of [constraint3_initialize_map]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3_init.dats] *)
