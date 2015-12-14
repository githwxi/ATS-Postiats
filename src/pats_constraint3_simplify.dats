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
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_constraint3.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
s3exp_bneg (s3e0) = (
  case+ s3e0 of
  | S3Ebool b => S3Ebool (not b)
  | S3Ebneg (s3e) => s3e
  | S3Ebadd (s3e1, s3e2) => S3Ebmul (S3Ebneg s3e1, S3Ebneg s3e2)
  | S3Ebmul (s3e1, s3e2) => S3Ebadd (S3Ebneg s3e1, S3Ebneg s3e2)
  | S3Ebeq (s3e1, s3e2) => S3Ebneq (s3e1, s3e2)
  | S3Ebneq (s3e1, s3e2) => S3Ebeq (s3e1, s3e2)
  | S3Ebineq (knd, s3e) => S3Ebineq (~knd, s3e)
  | _ => S3Ebneg (s3e0)
) // end of [s3exp_bneg]

(* ****** ****** *)

implement
s3exp_badd
  (s3e1, s3e2) = let
in
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3exp_true else s3e2
  | _ (*non-bool*) => (
    case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3exp_true else s3e1
    | _(*non-bool*) => S3Ebadd (s3e1, s3e2)
    ) (* end of [_] *)
end // end of [s3exp_badd]

implement
s3exp_bmul
  (s3e1, s3e2) = let
in
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3e2 else s3exp_false
  | _(*non-bool*) =>
    (
    case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3e1 else s3exp_false
    | _ (*non-bool*) => S3Ebmul (s3e1, s3e2)
    ) (* end of [_] *)
end // end of [s3exp_bmul]

(* ****** ****** *)

implement
s3exp_beq
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3e2 else s3exp_bneg (s3e2)
  | _ => (case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3e1 else s3exp_bneg (s3e1)
    | _ => S3Ebeq (s3e1, s3e2)
    ) // end of [_]
) // end of [s3exp_beq]

implement
s3exp_bneq
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3exp_bneg (s3e2) else s3e2
  | _ => (case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3exp_bneg (s3e1) else s3e1
    | _ => S3Ebneq (s3e1, s3e2)
    ) // end of [_]
) // end of [s3exp_bneq]

(* ****** ****** *)

fun
uns3exp_intinf
  (s3e: s3exp): Option_vt (intinf) =
  case+ s3e of
  | S3Enull () => Some_vt (intinf_0)
  | S3Eunit () => Some_vt (intinf_1)
  | S3Eicff (c, s3e) => let
      val opt = uns3exp_intinf (s3e)
    in
      case+ opt of
      | ~Some_vt (i) => Some_vt (c * i)
      | ~None_vt () => None_vt ()
    end // end of [S3Eicff]
  | _ => None_vt ()
// end of [uns3exp_intinf]

implement
s3exp_bineq (knd, s3e) = let
  val opt = uns3exp_intinf (s3e)
in
  case+ opt of
  | ~Some_vt (i) => (case+ 0 of
    | _ when knd =  2 => s3exp_bool (i >= 0)
    | _ when knd = ~2 => s3exp_bool (i < 0)
    | _ when knd =  1 => s3exp_bool (i = 0)
    | _ when knd = ~1 => s3exp_bool (i != 0)
    | _ => let
        val () = assertloc (false) in s3exp_false
      end // end of [_]
    ) // end of [Some_vt]
  | ~None_vt () => S3Ebineq (knd, s3e)
end // end of [s3exp_bineq]

(* ****** ****** *)

implement
s3exp_ilt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ilt]

implement
s3exp_ilte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_isub (s3e2, s3e1))
// end of [s3exp_ilte]

implement
s3exp_igt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_isub (s3e2, s3e1))
// end of [s3exp_igt]

implement
s3exp_igte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_igte]

implement
s3exp_ieq (s3e1, s3e2) =
  s3exp_bineq (1(*eq*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ieq]

implement
s3exp_ineq (s3e1, s3e2) =
  s3exp_bineq (~1(*neq*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ineq]

(* ****** ****** *)

implement
s3exp_int (i) = let
  val int = intinf_make_int (i) in s3exp_intinf (int)
end // end of [s3exp_int]

implement s3exp_intinf (int) = s3exp_icff (int, s3exp_1)

(* ****** ****** *)

implement
s3exp_icff (c, x) = let
(*
  val () = print "s3exp_icff"
*)
in
case+ 0 of
| _ when c = 1 => x
| _ when c = 0 => s3exp_0
| _ => (
  case+ x of
  | S3Enull () => s3exp_0
  | S3Eicff
      (c1, x1) => s3exp_icff (c * c1, x1)
  | S3Eisum (xs) => let
      val cxs = s3explst_icff (c, xs) in S3Eisum ((l2l)cxs)
    end // end of [S3Eisum]
  | _ => S3Eicff (c, x)
  ) // end of [_]
end // end of [s3exp_icff]

implement
s3explst_icff (c, xs) = (
  list_map_cloptr (xs, lam x =<1> s3exp_icff (c, x))
) // end of [s3explst_icff]

implement
s3exp_ineg (x) = s3exp_icff (intinf_neg_1, x)

(* ****** ****** *)

implement
s3exp_isum (xs) = (
  case+ xs of
  | list_cons (x, xs1) => (
    case+ xs1 of
    | list_cons _ => S3Eisum (xs) | list_nil () => x
    ) // end of [list_cons]
  | list_nil () => s3exp_0
) // end of [s3exp_isum]

(* ****** ****** *)

implement
s3exp_isucc (s3e) = s3exp_iadd (s3e, s3exp_1)
implement
s3exp_ipred (s3e) = s3exp_iadd (s3e, s3exp_neg_1)

(* ****** ****** *)

implement
s3exp_isgte (x1, x2) = let
(*
// HX: for supporting S3Eisum
*)
in
//
case+ x1 of
// nonlinear terms go first
| S3Eiatm
    (s2vs1) => (
  case+ x2 of
  | S3Eiatm(s2vs2) =>
      s2varmset_gte (s2vs1, s2vs2)
    // end of [S3Eiatm]
  | _ => true
  ) (* end of [S3Eiatm] *)
| S3Evar(s2v1) => (
  case+ x2 of
  | S3Eiatm _ => false
  | S3Evar s2v2 =>
      compare_s2var_s2var (s2v1, s2v2) <= 0 // HX: not [>=]!
    // end of [S3Ecst]
  | _ => true
  ) (* end of [S3Evar] *)
| S3Ecst(s2c1) => (
  case+ x2 of
  | S3Eiatm _ => false
  | S3Evar s2v2 => false
  | S3Ecst s2c2 =>
      compare_s2cst_s2cst (s2c1, s2c2) <= 0 // HX: not [>=]!
    // end of [S3Ecst]
  | _ => true
  ) (* end of [S3Evar] *)
| S3Eunit((*void*)) => (
  case+ x2 of
  | S3Eiatm _ => false
  | S3Evar s2v2 => false
  | S3Ecst s2c2 => false
  | S3Eunit () => true
  | _ => true
  ) (* end of [S3Eunit] *)
//
| _(*unrecognized*) => false
//
end // end of [s3exp_isgte]

(* ****** ****** *)

local

fun uns3exp_icff
  (x: s3exp): s3exp =
  case+ x of S3Eicff (c, x) => x | _ => x
// end of [uns3exp_icff]

(*
** HX: x1 and x2 are the same kind of term
*)
fun s3exp_icff_add
  (x1: s3exp, x2: s3exp): s3exp =
  case+ (x1, x2) of
  | (S3Eicff (c1, y1),
     S3Eicff (c2, _)) => s3exp_icff (c1+c2, y1)
  | (S3Eicff (c1, y1), _) => s3exp_icff (c1+1, y1)
  | (_, S3Eicff (c2, y2)) => s3exp_icff (c2+1, y2)
  | (_, _) => s3exp_icff (intinf_2, x1)
// end of [s3exp_icff_add]

fun
s3exp_isum_pair (
  x1: s3exp, x2: s3exp
) : s3exp = let
  val y1 = uns3exp_icff (x1)
  and y2 = uns3exp_icff (x2)
  val gte12 = s3exp_isgte (y1, y2)
in
//
if gte12 then let
  val gte21 = s3exp_isgte (y2, y1)
in
  if gte21 then
    s3exp_icff_add (x1, x2) else S3Eisum (list_pair (x1, x2))
  // end of [if]
end else (
  S3Eisum (list_pair (x2, x1))
) (* end of [if] *)
//
end // end of [s3exp_isum_pair]

fun
s3exp_isum_list (
  xs1: s3explst, xs2: s3explst
) : s3explst_vt = let
//
fun aux (
  xs1: s3explst, xs2: s3explst
) : s3explst_vt =
  case+ xs1 of
  | list_cons (x1, xs11) => (
    case+ xs2 of
    | list_cons (x2, xs21) => let
        val y1 = uns3exp_icff (x1)
        val y2 = uns3exp_icff (x2)
        val gte12 = s3exp_isgte (y1, y2)
      in
        if gte12 then let
          val gte21 = s3exp_isgte (y2, y1)
        in
          if gte21 then let
            val x12 = s3exp_icff_add (x1, x2)
          in
            case+ x12 of
            | S3Enull () => aux (xs11, xs21)
            | _ =>
                list_vt_cons (x12, aux (xs11, xs21))
              // end of [_]
          end else
            list_vt_cons (x1, aux (xs11, xs2))
          // end of [if]
        end else
          list_vt_cons (x2, aux (xs1, xs21))
        // end of [if]
      end // end of [list_cons]
    | list_nil () => list_copy (xs1)
    ) // end of [list_cons]
  | list_nil () => list_copy (xs2)
 // end of [aux]
in
  aux (xs1, xs2)
end // end of [s3exp_isum_list]

fun
s3exp_imul_list (
  xs1: s3explst, xs2: s3explst
) : s3explst_vt = let
in
//
case+ xs1 of
| list_cons (x1, xs1) => let
    val x1xs2 = list_map_cloptr
      (xs2, lam x2 =<1> s3exp_imul (x1, x2))
    val xs1xs2 = s3exp_imul_list (xs1, xs2)
    val res = s3exp_isum_list (
      $UN.castvwtp1{s3explst} (x1xs2), $UN.castvwtp1{s3explst} (xs1xs2)
    ) // end of [val]
    val () = list_vt_free (x1xs2)
    val () = list_vt_free (xs1xs2)
  in
    res
  end // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end // end of [s3exp_imul_list]

in (* in of [local] *)

implement
s3exp_iadd
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3Enull (), _) => x2
  | (_, S3Enull ()) => x1
  | (S3Eisum xs1, S3Eisum xs2) => let
      val xs = s3exp_isum_list (xs1, xs2)
    in
      s3exp_isum ((l2l)xs)
    end // end of [S3Eisum, S3Eisum]
  | (S3Eisum xs1, _) => let
      val xs2 = list_vt_sing (x2)
      val xs = s3exp_isum_list (xs1, $UN.castvwtp1{s3explst} (xs2))
      val () = list_vt_free (xs2)
    in
      s3exp_isum ((l2l)xs)
    end // end of [S3Eisum, _]
  | (_, S3Eisum xs2) => let
      val xs1 = list_vt_sing (x1)
      val xs = s3exp_isum_list ($UN.castvwtp1{s3explst} (xs1), xs2)
      val () = list_vt_free (xs1)
    in
      s3exp_isum ((l2l)xs)
    end // end of [_, S3Eisum]
  | (_, _) => s3exp_isum_pair (x1, x2)
) // end of [s3exp_iadd]

implement
s3exp_isub
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3Enull (), _) => s3exp_ineg (x2)
  | (_, S3Enull ()) => x1
  | (S3Eisum xs1, S3Eisum xs2) => let
      val xs2 =
        s3explst_icff (intinf_neg_1, xs2)
      val xs = s3exp_isum_list (xs1, $UN.castvwtp1{s3explst} (xs2))
      val () = list_vt_free (xs2)
    in
      s3exp_isum ((l2l)xs)
    end // end of [S3Eisum, S3Eisum]
  | (S3Eisum xs1, _) => let
      val xs2 = list_vt_sing (s3exp_ineg (x2))
      val xs = s3exp_isum_list (xs1, $UN.castvwtp1{s3explst} (xs2))
      val () = list_vt_free (xs2)
    in
      s3exp_isum ((l2l)xs)
    end // end of [S3Eisum, _]
  | (_, S3Eisum xs2) => let
      val xs1 = list_vt_sing (x1)
      val xs2 =
        s3explst_icff (intinf_neg_1, xs2)
      val xs = s3exp_isum_list (
        $UN.castvwtp1{s3explst} (xs1), $UN.castvwtp1{s3explst} (xs2)
      ) // end of [val]
      val () = list_vt_free (xs1)
      val () = list_vt_free (xs2)
    in
      s3exp_isum ((l2l)xs)
    end // end of [_, S3Eisum]
  | (_, _) => s3exp_isum_pair (x1, s3exp_ineg (x2))
) // end of [s3exp_isub]

implement
s3exp_imul
  (x1, x2) = let
(*
val () = (
  print "s3exp_imul: x1 = "; print_s3exp (x1); print_newline ();
  print "s3exp_imul: x2 = "; print_s3exp (x2); print_newline ();
) // end of [val]
*)
in
//
case+ (x1, x2) of
| (S3Enull (), _) => s3exp_0
| (_, S3Enull ()) => s3exp_0
| (S3Eunit (), _) => x2
| (_, S3Eunit ()) => x1
| (S3Eicff (c, x1), x2) => s3exp_icff (c, s3exp_imul (x1, x2))
| (x1, S3Eicff (c, x2)) => s3exp_icff (c, s3exp_imul (x1, x2))
//
| (S3Evar (s2v1), S3Evar (s2v2)) =>
    S3Eiatm (s2varmset_pair (s2v1, s2v2))
| (S3Eiatm (s2vs1), S3Evar (s2v2)) =>
    S3Eiatm (s2varmset_add (s2vs1, s2v2))
| (S3Evar (s2v1), S3Eiatm (s2vs2)) =>
    S3Eiatm (s2varmset_add (s2vs2, s2v1))
| (S3Eiatm (s2vs1), S3Eiatm (s2vs2)) =>
    S3Eiatm (s2varmset_union (s2vs1, s2vs2))
//
| (S3Eisum (xs1), S3Eisum (xs2)) => let
    val xs1xs2 = s3exp_imul_list (xs1, xs2)
  in
    s3exp_isum ((l2l)xs1xs2)
  end // end of [S3Eisum, S3Eisum]
| (S3Eisum (xs1), _) => let
    val ys1 = list_map_cloptr (xs1, lam x1 =<1> s3exp_imul (x1, x2))
  in
    S3Eisum ((l2l)ys1)
  end // end of [S3Eisum, _]
| (_, S3Eisum (xs2)) => let
    val ys2 = list_map_cloptr (xs2, lam x2 =<1> s3exp_imul (x1, x2))
  in
    S3Eisum ((l2l)ys2)
  end // end of [_, S3Eisum]
//
| (_, _) => S3Eimul (x1, x2)
//
end // end of [s3exp_imul]

end // end of [local]

(* ****** ****** *)

extern
fun s3exp_lintize_flag (
  env: &s2vbcfenv, s3e: s3exp, flag: &int
) : s3exp // end of [s3exp_lintize_flag]
extern
fun s3explst_lintize_flag (
  env: &s2vbcfenv, s3es: s3explst, flag: &int
) : s3explst // end of [s3explst_lintize_flag]

(* ****** ****** *)

implement
s3exp_lintize
  (env, s3e) = let
(*
val () = (
  print "s3exp_lintize: s3e = "; print_s3exp (s3e); print_newline ()
) (* end of [val] *)
*)
var flag: int = 0
val s3e_res = s3exp_lintize_flag (env, s3e, flag)
//
in
  s3e_res
end // end of [s3exp_lintize]

(* ****** ****** *)

implement
s3exp_lintize_flag
(
  env, s3e0, flag
) = let
  val flag0 = flag
in
//
case+ s3e0 of
//
| S3Evar _ => s3e0
| S3Ecst _ => let
    val () = flag := flag + 1
    val s2v = s2vbcfenv_replace_nonlin (env, s3e0)
  in
    s3exp_var (s2v)
  end // end of [val]
| S3Enull _ => s3e0
| S3Eunit _ => s3e0
| S3Ebool _ => s3e0
//
| S3Ebvar _ => s3e0
| S3Ebneg (s3e) => let
    val s3e =
      s3exp_lintize_flag (env, s3e, flag)
    // end of [val]
  in
    if flag > flag0 then S3Ebneg (s3e) else s3e0
  end // end of [S3Ebneg]
| S3Ebadd (s3e1, s3e2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3e2 = s3exp_lintize_flag (env, s3e2, flag)
  in
    if flag > flag0 then S3Ebadd (s3e1, s3e2) else s3e0
  end // end of [S3Ebadd]
| S3Ebmul (s3e1, s3e2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3e2 = s3exp_lintize_flag (env, s3e2, flag)
  in
    if flag > flag0 then S3Ebmul (s3e1, s3e2) else s3e0
  end // end of [S3Ebmul]
| S3Ebeq (s3e1, s3e2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3e2 = s3exp_lintize_flag (env, s3e2, flag)
  in
    if flag > flag0 then S3Ebeq (s3e1, s3e2) else s3e0
  end // end of [S3Ebeq]
| S3Ebneq (s3e1, s3e2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3e2 = s3exp_lintize_flag (env, s3e2, flag)
  in
    if flag > flag0 then S3Ebneq (s3e1, s3e2) else s3e0
  end // end of [S3Ebneq]
| S3Ebineq (knd, s3e) => let
    val s3e = s3exp_lintize_flag (env, s3e, flag)
  in
    if flag > flag0 then S3Ebineq (knd, s3e) else s3e0
  end // end of [S3Ebineq]
//
| S3Ebdom _ => s3e0
//
| S3Eiatm _ => let
    val () = flag := flag + 1
    val s2v = s2vbcfenv_replace_nonlin (env, s3e0)
  in
    s3exp_var (s2v)
  end // end of [val]
| S3Eicff
    (cff, s3e) => let
    val s3e = s3exp_lintize_flag (env, s3e, flag)
  in
    if flag > flag0 then S3Eicff (cff, s3e) else s3e0
  end // end of [S3Eicff
//
| S3Eisum (s3es) => let
    val s3es =
      s3explst_lintize_flag (env, s3es, flag)
    // end of [s3es]
  in
    if flag > flag0 then S3Eisum (s3es) else s3e0
  end // end of [S3Eisum]
| S3Eimul
    (s3e1, s3e2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3e2 = s3exp_lintize_flag (env, s3e2, flag)
    val s3e0 = (
      if flag > flag0 then S3Eimul (s3e1, s3e2) else s3e0
    ) : s3exp // end of [val]
    val () = flag := flag + 1
    val s2v = s2vbcfenv_replace_nonlin (env, s3e0)
  in
    s3exp_var (s2v)
  end // end of [S3Eimul]
//
| S3Esizeof _ => let
    val () = flag := flag + 1
    val s2v = s2vbcfenv_replace_nonlin (env, s3e0)
  in
    s3exp_var (s2v)
  end // end of [val]
//
| S3Eapp
    (s3e1, s3es2) => let
    val s3e1 = s3exp_lintize_flag (env, s3e1, flag)
    val s3es2 = s3explst_lintize_flag (env, s3es2, flag)
    val s3e0 = (
      if flag > flag0 then S3Eapp (s3e1, s3es2) else s3e0
    ) : s3exp // end of [val]
    val () = flag := flag + 1
    val s2v = s2vbcfenv_replace_nonlin (env, s3e0)
  in
    s3exp_var (s2v)
  end // end of [S3Eapp]
//
| S3Eerr _(*ERROR*) => s3e0
//
end // end of [s3exp_lintize]

(* ****** ****** *)

implement
s3explst_lintize_flag
(
  env, s3es0, flag
) = let
  val flag0 = flag
in
//
case+ s3es0 of
| list_cons
    (s3e, s3es) => let
    val s3e = s3exp_lintize_flag (env, s3e, flag)
    val s3es = s3explst_lintize_flag (env, s3es, flag)
  in
    if flag > flag0 then list_cons (s3e, s3es) else s3es0
  end // end of [list_cons]
| list_nil ((*void*)) => list_nil ()
//
end // end of [s3explst_lintize_flag]

(* ****** ****** *)

(* end of [pats_constraint3_simplify.dats] *)
