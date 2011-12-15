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
// Start Time: October, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
overload compare with $LAB.compare_label_label
staload STAMP = "pats_stamp.sats"
overload compare with $STAMP.compare_stamp_stamp

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_solve.sats"

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

implement
label_equal_solve_err
  (loc0, l1, l2, err) =
  if compare (l1, l2) = 0 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_label_equal (loc0, l1, l2))
  in
    // nothing
  end // end of [if]
// end of [label_equal_solve_err]

implement
stamp_equal_solve_err
  (loc0, s1, s2, err) =
  if compare (s1, s2) = 0 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_stamp_equal (loc0, s1, s2))
  in
    // nothing
  end // end of [if]
// end of [stamp_equal_solve_err]

(* ****** ****** *)

implement
funclo_equal_solve_err
  (loc0, fc1, fc2, err) =
  if fc1 = fc2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_funclo_equal (loc0, fc1, fc2))
  in
    // nothing
  end // end of [if]
// end of [funclo_equal_solve_err]

(* ****** ****** *)

implement
clokind_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_clokind_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [clokind_equal_solve_err]

(* ****** ****** *)

implement
linearity_equal_solve_err
  (loc0, lin1, lin2, err) =
  if lin1 = lin2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_linearity_equal (loc0, lin1, lin2))
  in
    // nothing
  end // end of [if]
// end of [linearity_equal_solve_err]

(* ****** ****** *)

implement
pfarity_equal_solve
  (loc0, npf1, npf2) = err where {
  var err: int = 0
  val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
} // end of [pfarity_equal_solve]

implement
pfarity_equal_solve_err
  (loc0, npf1, npf2, err) =
  if npf1 = npf2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_pfarity_equal (loc0, npf1, npf2))
  in
    // nothing
  end // end of [if]
// end of [pfarity_equal_solve_err]

(* ****** ****** *)

implement
tyreckind_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_tyreckind_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [tyreckind_equal_solve_err]

(* ****** ****** *)

implement
refval_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_refval_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [refval_equal_solve_err]

(* ****** ****** *)

extern
fun s2hnf_equal_solve_Var_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_Var_err]

implement
s2hnf_equal_solve_Var_err
  (loc0, s2f1, s2f2, s2V1, err) = let
in
  s2Var_set_link (s2V1, Some s2f2)
end // end of [s2hnf_equal_solve_Var_err]

(* ****** ****** *)

implement
s2hnf_equal_solve
  (loc0, s2f10, s2f20) = err where {
  var err: int = 0
  val () = s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
} // end of [s2hnf_equal_solve]

implement
s2hnf_equal_solve_err
  (loc0, s2f10, s2f20, err) = let
val err0 = err
// (*
val () = (
  print "s2hnf_equal_solve_err: s2f10 = "; print_s2hnf s2f10; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_equal_solve_err: s2f20 = "; print_s2hnf s2f20; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_equal_solve_err: err0 = "; print err0; print_newline ()
) // end of [val]
// *)
val s2e10 = unhnf (s2f10) and s2e20 = unhnf (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
//
val () = case+
  (s2en10, s2en20) of
  | (S2EVar s2V1, _) => (
    case+ s2en20 of
    | S2EVar s2V2 when s2V1 = s2V2 => ()
    | _ => s2hnf_equal_solve_Var_err (loc0, s2f10, s2f20, s2V1, err)
    )
  | (_, S2EVar s2V2) =>
      s2hnf_equal_solve_Var_err (loc0, s2f20, s2f10, s2V2, err)
  | (_, _) when s2hnf_syneq (s2f10, s2f20) => ()
  | (_, _) => (err := err + 1)
// end of [val]
//
val () = if err > err0 then
  the_staerrlst_add (STAERR_s2exp_equal (loc0, s2e10, s2e20))
// end of [val]
in
  // nothing
end // end of [s2hnf_equal_solve_err]

implement
s2exp_equal_solve_err
  (loc0, s2e10, s2e20, err) = let
//
val err0 = err
val s2f10 = s2exp_hnfize (s2e10)
and s2f20 = s2exp_hnfize (s2e20)
//
in
  s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_equal_solve_err]

(* ****** ****** *)

implement
s2explst_equal_solve_err
  (loc0, s2es1, s2es2, err) = let
in
//
case+ s2es1 of
| list_cons (s2e1, s2es1) => (
  case+ s2es2 of
  | list_cons (s2e2, s2es2) => let
      val () = s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
    in
      s2explst_equal_solve_err (loc0, s2es1, s2es2, err)
    end // end of [list_cons]
  | list_nil () => 1
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es2 of
  | list_cons _ => ~1 | list_nil () => 0
  ) // end of [list_nil]
//
end // end of [s2explst_equal_solve_err]

(* ****** ****** *)

implement
s2hnf_tyleq_solve
  (loc0, s2f10, s2f20) = err where {
  var err: int = 0
  val () = s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
} // end of [s2hnf_tyleq_solve]

implement
s2hnf_tyleq_solve_err
  (loc0, s2f10, s2f20, err) = let
val err0 = err
// (*
val () = (
  print "s2hnf_tyleq_solve_err: s2f10 = "; print_s2hnf s2f10; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_tyleq_solve_err: s2f20 = "; print_s2hnf s2f20; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_tyleq_solve_err: err0 = "; print err0; print_newline ()
) // end of [val]
// *)
val s2e10 = unhnf (s2f10) and s2e20 = unhnf (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
//
val () = case+
  (s2en10, s2en20) of
| (S2Einvar s2e11, _) => let
    val s2f11 = s2exp_hnfize (s2e11) in
    s2hnf_tyleq_solve_err (loc0, s2f11, s2f20, err)
  end // end of [S2Einvar, _]
| (_, S2Einvar s2e21) => let
    val s2f21 = s2exp_hnfize (s2e21)
    val s2e21 = (unhnf)s2f21
  in
    case+ s2e21.s2exp_node of
    | S2EVar s2V2 =>
        s2hnf_equal_solve_Var_err (loc0, s2f21, s2f10, s2V2, err)
      // end of [S2EVar]
    | _ => s2hnf_tyleq_solve_err (loc0, s2f10, s2f21, err)
  end // end of [_, S2Einvar]
| (S2Eapp (s2e1_fun, s2es1_arg), _) => (
  case+ s2en20 of
  | S2Eapp (s2e2_fun, s2es2_arg) => (
    case+ (
      s2e1_fun.s2exp_node, s2e2_fun.s2exp_node
    ) of
    | (_, _) => let // HX: sound but incomplete!
        val () = s2exp_equal_solve_err (loc0, s2e1_fun, s2e2_fun, err)
        val errlen = s2explst_equal_solve_err (loc0, s2es1_arg, s2es2_arg, err)
      in
        // nothing
      end // end of [_, _]
    ) // end of [S2Eapp]
  | _ => (err := err + 1)
  ) // end of [S2Eapp, _]
| (_, _) when s2hnf_syneq (s2f10, s2f20) => ()
| (_, _) => (err := err + 1)
// end of [val]
//
val () = if err > err0 then
  the_staerrlst_add (STAERR_s2exp_tyleq (loc0, s2e10, s2e20))
// end of [val]
in
  // nothing
end // end of [s2hnf_tyleq_solve_err]

implement
s2exp_tyleq_solve_err
  (loc0, s2e10, s2e20, err) = let
  val err0 = err
  val s2f10 = s2exp_hnfize s2e10
  and s2f20 = s2exp_hnfize s2e20
in
  s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_tyleq_solve_err]

(* ****** ****** *)

(* end of [pats_staexp2_solve.dats] *)
