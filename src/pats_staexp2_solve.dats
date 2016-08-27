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
// Start Time: October, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload compare with $LAB.compare_label_label
staload STMP = "./pats_stamp.sats"
overload compare with $STMP.compare_stamp_stamp

(* ****** ****** *)

staload EFF = "./pats_effect.sats"
//
macdef effset_isnil = $EFF.effset_isnil
macdef effset_isall = $EFF.effset_isall
macdef effset_subset = $EFF.effset_subset
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

staload "./pats_staexp2_solve.sats"

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
funclo_equal_solve
  (loc0, fc1, fc2) = err where {
  var err: int = 0
  val () = funclo_equal_solve_err (loc0, fc1, fc2, err)
} // end of [funclo_equal_solve]

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
linearity_equal_solve
  (loc0, lin1, lin2) = err where {
  var err: int = 0
  val () = linearity_equal_solve_err (loc0, lin1, lin2, err)
} // end of [linearity_equal_solve]

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
boxity_equal_solve_err
  (loc0, knd1, knd2, err) = let
  val i = (
    if tyreckind_is_boxed (knd2) then 1-knd1 else knd1
  ) : int // end of [val]
in
  if (i = 0) then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_boxity_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
end // end of [boxity_equal_solve_err]

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
fun s2Var_merge_szexp_err (
  loc: location, s2V1: s2Var, s2ze2: s2zexp, err: &int
) : void // end of [s2Var_merge_szexp_err]
implement
s2Var_merge_szexp_err
  (loc0, s2V1, s2ze2, err) = let
  val s2ze1 = s2Var_get_szexp (s2V1)
  val s2ze12 = s2zexp_merge (s2ze1, s2ze2)
  val () = if s2zexp_is_bot (s2ze12) then {
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_s2zexp_merge (loc0, s2ze1, s2ze2))
  } // end of [val]
in
  s2Var_set_szexp (s2V1, s2ze12)
end // end of [s2Var_merge_szexp_err]

(* ****** ****** *)

extern
fun s2Var_s2exp_srtck_err (
  loc0: location, s2V1: s2Var, s2e2: s2exp, err: &int
) : void // end of [s2Var_s2exp_srtck_err]

implement
s2Var_s2exp_srtck_err
  (loc0, s2V1, s2e2, err) = let
//
val s2t1 =
  s2Var_get_srt (s2V1)
val s2t2 = s2e2.s2exp_srt
val ltmat = s2rt_ltmat1 (s2t2, s2t1) // HX: real-run
val () = if ~(ltmat) then {
  val () = err := err + 1
  val () = the_staerrlst_add (STAERR_s2Var_s2exp_solve (loc0, s2V1, s2e2))
} // end of [if] // end of [val]
//
in
  // nothing
end // end of [s2Var_s2exp_srtck_err]

(* ****** ****** *)

extern
fun
s2hnf_tyleq_solve_lbs_err (
  loc0: location, lbs: s2VarBoundlst, s2f: s2hnf, err: &int
) : void // end of [s2hnf_tyleq_solve_lbs_err]
extern
fun
s2hnf_tyleq_solve_ubs_err (
  loc0: location, s2f: s2hnf, ubs: s2VarBoundlst, err: &int
) : void // end of [s2hnf_tyleq_solve_ubs_err]

(* ****** ****** *)

extern
fun
s2hnf_equal_solve_lVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_lVar_err]
extern
fun
s2hnf_equal_solve_lVar_err_nck (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_lVar_err_nck]

implement
s2hnf_equal_solve_lVar_err
  (loc0, s2f1, s2f2, s2V1, err) = let
(*
  val () = (
    println! ("s2hnf_equal_solve_lVar_err: s2f1 = ", s2f1);
    println! ("s2hnf_equal_solve_lVar_err: s2f2 = ", s2f2);
  ) // end of [val]
*)
  val s2e1 = s2hnf2exp (s2f1)
  val s2e2 = s2hnf2exp (s2f2)
  val (ans, s2cs, s2vs, s2Vs) = s2Var_occurcheck_s2exp (s2V1, s2e2)
in
//
if ans = 0 then let
  val () = s2Varlst_add_sVarlst (s2Vs, s2V1)
in
  s2hnf_equal_solve_lVar_err_nck (loc0, s2f1, s2f2, s2V1, err)
end else let // ans > 0
(*
  val () = (
    println! ("s2exp_equal_solve_lVar_err: s2f1 = ", s2f1);
    println! ("s2exp_equal_solve_lVar_err: s2f2 = ", s2f2);
    println! ("s2exp_equal_solve_lVar_err: s2cs = ", s2cs);
    println! ("s2exp_equal_solve_lVar_err: s2vs = ", s2vs);
  ) // end of [val]
*)
in
  trans3_env_add_eqeq (loc0, s2e1, s2e2)
end // end of [if]
//
end // end of [s2hnf_equal_solve_lVar_err]

implement
s2hnf_equal_solve_lVar_err_nck
  (loc0, s2f1, s2f2, s2V1, err) = let
//
val s2e2 = s2hnf2exp (s2f2)
val () = s2Var_s2exp_srtck_err (loc0, s2V1, s2e2, err)
//
val isimp =
  s2exp_is_impred (s2e2)
val () = if isimp then {
  val s2ze2 = s2zexp_make_s2exp (s2e2)
  val () = s2Var_merge_szexp_err (loc0, s2V1, s2ze2, err)
} // end of [if] // end of [val]
//
val () = s2Var_set_link (s2V1, Some s2e2)
val () = if isimp then {
  val lbs = s2Var_get_lbs (s2V1)
  val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f2, err)
  val ubs = s2Var_get_ubs (s2V1)
  val () = s2hnf_tyleq_solve_ubs_err (loc0, s2f2, ubs, err)
} // end of [if] // end of [val]
//
in
  // nothing  
end // end of [s2hnf_equal_solve_lVar_err_nck]

(* ****** ****** *)

extern
fun s2hnf_equal_solve_rVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V2: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_rVar_err]
extern
fun s2hnf_equal_solve_rVar_err_nck (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V2: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_rVar_err_nck]

implement
s2hnf_equal_solve_rVar_err
  (loc0, s2f1, s2f2, s2V2, err) = let
//
val s2e1 = s2hnf2exp (s2f1)
val s2e2 = s2hnf2exp (s2f2)
(*
val () = (
  println! ("s2hnf_equal_solve_rVar_err: s2e1 = ", s2e1);
  println! ("s2hnf_equal_solve_rVar_err: s2t1 = ", s2e1.s2exp_srt);
  println! ("s2hnf_equal_solve_rVar_err: s2e2 = ", s2e2);
  println! ("s2hnf_equal_solve_rVar_err: s2t2 = ", s2e2.s2exp_srt);
) // end of [val]
*)
val (ans, s2cs, s2vs, s2Vs) = s2Var_occurcheck_s2exp (s2V2, s2e1)
//
in
//
if ans = 0 then let
  val () = s2Varlst_add_sVarlst (s2Vs, s2V2)
in
  s2hnf_equal_solve_rVar_err_nck (loc0, s2f1, s2f2, s2V2, err)
end else let // ans > 0
(*
  val () = (
    println! ("s2exp_equal_solve_rVar_err: s2f1 = ", s2f1);
    println! ("s2exp_equal_solve_rVar_err: s2f2 = ", s2f2);
    println! ("s2exp_equal_solve_rVar_err: s2cs = ", s2cs);
    println! ("s2exp_equal_solve_rVar_err: s2vs = ", s2vs);
  ) // end of [val]
*)
in
  trans3_env_add_eqeq (loc0, s2e1, s2e2)
end // end of [if]
//
end // end of [s2hnf_equal_solve_rVar_err]

implement
s2hnf_equal_solve_rVar_err_nck
  (loc0, s2f1, s2f2, s2V2, err) = let
//
val s2e1 = s2hnf2exp (s2f1)
val () = s2Var_s2exp_srtck_err (loc0, s2V2, s2e1, err)
//
val isimp =
  s2exp_is_impred (s2e1)
val () = if isimp then {
  val s2ze1 = s2zexp_make_s2exp (s2e1)
  val () = s2Var_merge_szexp_err (loc0, s2V2, s2ze1, err)
} // end of [if] // end of [val]
//
val () = s2Var_set_link (s2V2, Some s2e1)
val () = if isimp then {
  val lbs = s2Var_get_lbs (s2V2)
  val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f1, err)
  val ubs = s2Var_get_ubs (s2V2)
  val () = s2hnf_tyleq_solve_ubs_err (loc0, s2f1, ubs, err)
} // end of [if] // end of [val]
//
in
  // nothing
end // end of [s2hnf_equal_solve_rVar_err_nck]

(* ****** ****** *)

implement
s2eff_subeq_solve
  (loc0, s2fe1, s2fe2) = err where {
  var err: int = 0
  val () = s2eff_subeq_solve_err (loc0, s2fe1, s2fe2, err)
} // end of [s2eff_subeq_solve]

implement
s2eff_subeq_solve_err
  (loc0, s2fe1, s2fe2, err) = let
//
val s2fe1 = s2eff_hnfize (s2fe1)
val s2fe2 = s2eff_hnfize (s2fe2)
//
in
//
case+ (s2fe1, s2fe2) of
| (S2EFFset (efs1), _)
    when effset_isnil efs1 => ()
| (_, S2EFFset (efs2))
    when effset_isall efs2 => ()
| (S2EFFset (efs1),
   S2EFFset (efs2))
    when effset_subset (efs1, efs2) => ()
| (S2EFFexp (s2e1),
   S2EFFexp (s2e2))
    when s2exp_syneq (s2e1, s2e2) => ()
| (_, S2EFFexp (s2e2)) => (
  case+ s2e2.s2exp_node of
  | S2EVar s2V2 => let
      val s2e1 = s2exp_eff (s2fe1)
      val s2f1 = s2exp2hnf_cast (s2e1)
      val s2f2 = s2exp2hnf_cast (s2e2)
    in
      s2hnf_equal_solve_rVar_err (loc0, s2f1, s2f2, s2V2, err)
    end // end of [S2EVar]
  | _ => let
      val () = err := err + 1 in
      the_staerrlst_add (STAERR_s2eff_subeq (loc0, s2fe1, s2fe2))
    end // end of [_]
  ) // end of [S2EFFexp]
| (_, _) => let
    val () = err := err + 1 in
    the_staerrlst_add (STAERR_s2eff_subeq (loc0, s2fe1, s2fe2))
  end // end of [_]
//
end // end of [s2eff_subeq_solve_err]

(* ****** ****** *)

implement
s2hnf_equal_solve
(
  loc0, s2f10, s2f20
) = err where {
  var err: int = 0
  val () = s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
} (* end of [s2hnf_equal_solve] *)

implement
s2exp_equal_solve
(
  loc0, s2e10, s2e20
) = err where {
  var err: int = 0
  val () = s2exp_equal_solve_err (loc0, s2e10, s2e20, err)
} (* end of [s2exp_equal_solve] *)

(* ****** ****** *)

fun
s2hnf_equal_solve_abscon_err
(
  loc0: location, s2f1: s2hnf, s2f2: s2hnf, err: &int
) : void = let
//
val s2e1 = s2hnf2exp (s2f1)
and s2e2 = s2hnf2exp (s2f2)
//
fun aux_solve ( // nontailrec
  loc0: location, s2e1: s2exp, s2e2: s2exp, err: &int
) : void = let
in
//
case+ (
  s2e1.s2exp_node
, s2e2.s2exp_node
) of
| (S2Eapp (s2e11, s2es12), S2Eapp (s2e21, s2es22)) => let
    val () = aux_solve (loc0, s2e11, s2e21, err)
    val () = s2explst_equal_solve_err (loc0, s2es12, s2es22, err)
  in
    // nothing
  end // end of [S2Eapp, S2Eapp]
| (_, _) => ()
//
end // end of [aux_solve]
//
fun aux_check ( // tailrec
  s2e1: s2exp, s2e2: s2exp
) : bool = let
in
//
case+ (
  s2e1.s2exp_node
, s2e2.s2exp_node
) of
| (S2Ecst s2c1,
   S2Ecst s2c2) => eq_s2cst_s2cst (s2c1, s2c2)
| (S2Eapp (s2e1, _),
   S2Eapp (s2e2, _)) => aux_check (s2e1, s2e2)
| (_, _ ) => false
//
end // end of [aux_check]
//
val absconeq = aux_check (s2e1, s2e2)
//
in
  if absconeq then aux_solve (loc0, s2e1, s2e2, err) else (err := err + 1)
end // end of [s2hnf_equal_solve_abscon_err]

(* ****** ****** *)

implement
s2hnf_equal_solve_err
  (loc0, s2f10, s2f20, err) = let
//
val err0 = err
val s2e10 = s2hnf2exp (s2f10)
and s2e20 = s2hnf2exp (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
(*
val () = (
  println! ("s2hnf_equal_solve_err: err0 = ", err0);
  print ("s2hnf_equal_solve_err: s2e10 = "); pprint_s2exp (s2e10); print_newline ();
  print ("s2hnf_equal_solve_err: s2e20 = "); pprint_s2exp (s2e20); print_newline ();
) // end of [val]
*)
val () = case+
  (s2en10, s2en20) of
//
| (S2Einvar s2e11, _) => let
    val s2f11 = s2exp2hnf (s2e11) in
    s2hnf_equal_solve_err (loc0, s2f11, s2f20, err)
  end // end of [S2Einvar, _]
| (_, S2Einvar s2e21) => let
    val s2f21 = s2exp2hnf (s2e21) in
    s2hnf_equal_solve_err (loc0, s2f10, s2f21, err)
  end // end of [_, S2Einvar]
//
| (S2EVar s2V1, _) => (
  case+ s2en20 of
  | S2EVar s2V2 when s2V1 = s2V2 => ()
  | _ => s2hnf_equal_solve_lVar_err (loc0, s2f10, s2f20, s2V1, err)
  ) // end of [S2EVar, _]
| (_, S2EVar s2V2) =>
    s2hnf_equal_solve_rVar_err (loc0, s2f10, s2f20, s2V2, err)
  // end of [_, S2EVar]
//
| (S2Ecst s2c1, s2en20) => (case+ s2en20 of
  | S2Ecst s2c2 =>
      if eq_s2cst_s2cst (s2c1, s2c2) then () else (err := err + 1)
    // end of [S2Ecst]
  | _ => begin
      trans3_env_add_eqeq (loc0, s2e10, s2e20)
    end // end of [_]
  ) // end of [S2Ecst, _]
//
| (S2Etop (knd1, s2e1), _) =>
  (
  case+ s2en20 of
  | S2Etop (knd2, s2e2) => (
      if knd1 >= knd2 then let
        val () = s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
      in
        // nothing
      end else (err := err + 1) // end of [if]
    ) // end of [S2Etop]
  | _ => (err := err + 1)
  )
//
| (S2Eat (s2e11, s2e12), _) =>
  (
  case+ s2en20 of
  | S2Eat (s2e21, s2e22) => let
      val () = s2exp_equal_solve_err (loc0, s2e11, s2e21, err)
      val () = s2exp_equal_solve_err (loc0, s2e12, s2e22, err)
    in
      // nothing
    end // end of [S2Eat]
  | _ => (err := err + 1)
  )
//
| (S2Etyarr (s2e11, s2es12), _) =>
  (
  case+ s2en20 of
  | S2Etyarr (s2e21, s2es22) => let
      val () = s2exp_equal_solve_err (loc0, s2e11, s2e21, err)
      val () = s2explst_equal_solve_err (loc0, s2es12, s2es22, err)
    in
      // nothing
    end // end of [S2Etyarr]
  | _ => (err := err + 1)
  )
| (S2Etyrec (knd1, npf1, ls2es1), _) =>
  (
  case+ s2en20 of
  | S2Etyrec (knd2, npf2, ls2es2) => let
      val (
      ) = tyreckind_equal_solve_err (loc0, knd1, knd2, err)
      val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
      val isless = tyreckind_is_nameless (knd1)
    in
      if isless then
        labs2explst_equal_solve_err (loc0, ls2es1, ls2es2, err)
      // end of [if]
    end // end of [S2Etyrec]
  | _ => (err := err + 1)
  ) (* end of [S2Etyrec, _] *)
//
| (S2Ewthtype (s2e1, ws2es1), _) =>
  (
  case+ s2en20 of
  | S2Ewthtype (s2e2, ws2es2) => let
      val () =
        s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
      // end of [val]
    in
      wths2explst_equal_solve_err (loc0, ws2es1, ws2es2, err)
    end // end of [S2Ewth]
  | _ => (err := err + 1)
  ) (* end of [S2Ewth, _] *)
//
| (_, _) when (
    s2hnf_is_abscon s2f10 && s2hnf_is_abscon s2f20
  ) =>
    s2hnf_equal_solve_abscon_err (loc0, s2f10, s2f20, err)
  // end of [abscon, abscon]
//
| (_, _) when s2hnf_syneq2 (s2f10, s2f20) => ()
//
| (_, _) => trans3_env_add_eqeq (loc0, s2e10, s2e20)
//
(*
| (_, _) => (err := err + 1)
*)
// end of [val]
//
val () =
if err > err0 then
  the_staerrlst_add (STAERR_s2exp_equal (loc0, s2e10, s2e20))
// end of [if] // end of [val]
in
  // nothing
end // end of [s2hnf_equal_solve_err]

implement
s2exp_equal_solve_err (
  loc0, s2e10, s2e20, err
) = let
//
val s2f10 = s2exp2hnf (s2e10)
and s2f20 = s2exp2hnf (s2e20)
//
in
  s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_equal_solve_err]

(* ****** ****** *)

implement
s2explst_equal_solve_err
  (loc0, s2es1, s2es2, err) = let
//
fun loop (
  loc0: location
, s2es1: s2explst, s2es2: s2explst
, err: &int
) : int = case+ s2es1 of
  | list_cons (s2e1, s2es1) => (
    case+ s2es2 of
    | list_cons (s2e2, s2es2) => let
        val () =
          s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
        // end of [val]
      in
        loop (loc0, s2es1, s2es2, err)
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil () => (
    case+ s2es2 of
    | list_cons _ => ~1 | list_nil () => 0
    ) // end of [list_nil]
// end of [loop]
//
val sgn = loop (
  loc0, s2es1, s2es2, err
) // end of [val]
val () = if (sgn != 0) then {
  val () = err := err + 1
  val () = the_staerrlst_add (STAERR_s2explst_length (loc0, sgn))
} // end of [val]
in
  // nothing
end // end of [s2explst_equal_solve_err]

(* ****** ****** *)

implement
labs2explst_equal_solve_err
  (loc0, ls2es1, ls2es2, err) = let
//
fun loop (
  loc0: location
, ls2es1: labs2explst, ls2es2: labs2explst
, err: &int
) : int = case+ ls2es1 of
  | list_cons (ls2e1, ls2es1) => (
    case+ ls2es2 of
    | list_cons (ls2e2, ls2es2) => let
        val SLABELED (l1, _, s2e1) = ls2e1
        val SLABELED (l2, _, s2e2) = ls2e2
        val () = label_equal_solve_err (loc0, l1, l2, err)
        val () = s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
      in
        loop (loc0, ls2es1, ls2es2, err)
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil () => (
    case+ ls2es2 of list_cons _ => ~1 | list_nil () => 0
    ) // end of [list_nil]
// end of [loop]
//
val sgn = loop (
  loc0, ls2es1, ls2es2, err
) // end of [val]
val () = if (sgn != 0) then {
  val () = err := err + 1
  val () = the_staerrlst_add (STAERR_labs2explst_length (loc0, sgn))
} // end of [if] // end of [val]
in
  // nothing
end // end of [labs2explst_equal_solve_err]

(* ****** ****** *)

implement
wths2explst_equal_solve_err
  (loc0, xs1, xs2, err) = let
//
fun loop (
  loc0: location
, xs1: wths2explst, xs2: wths2explst
, err: &int
) : int = let
in
//
case (xs1, xs2) of
| (WTHS2EXPLSTcons_invar (k1, x1, xs1),
   WTHS2EXPLSTcons_invar (k2, x2, xs2)) => let
    val () =
      refval_equal_solve_err (loc0, k1, k2, err)
    val () = s2exp_equal_solve_err (loc0, x1, x2, err)
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTcons_trans (k1, x1, xs1),
   WTHS2EXPLSTcons_trans (k2, x2, xs2)) => let
    val () =
      refval_equal_solve_err (loc0, k1, k2, err)
    val () = s2exp_equal_solve_err (loc0, x1, x2, err)
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTcons_none (xs1),
   WTHS2EXPLSTcons_none (xs2)) => let
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTnil (), WTHS2EXPLSTnil ()) => 0
| (_, _) => let
    val () = err := err + 1 in 1 // shape mismatch
  end // end of [_, _]
//
end // end of [loop]
//
val mis = loop (loc0, xs1, xs2, err)
val () = if mis > 0 then
  the_staerrlst_add (STAERR_wths2explst_shape (loc0, xs1, xs2))
// end of [val]
in
  // nothing
end // end of [wths2explst_equal_solve_err]

(* ****** ****** *)

extern
fun
s2hnf_tyleq_solve_lVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_tyleq_solve_lVar_err]
implement
s2hnf_tyleq_solve_lVar_err
  (loc0, s2f1, s2f2, s2V1, err) = let
//
val s2e2 = s2hnf2exp (s2f2)
//
val () = s2Var_s2exp_srtck_err (loc0, s2V1, s2e2, err)
//
val s2ze2 = s2zexp_make_s2exp (s2e2)
val () = s2Var_merge_szexp_err (loc0, s2V1, s2ze2, err)
//
val lbs = s2Var_get_lbs (s2V1)
val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f2, err)
//
val ub = s2VarBound_make (loc0, s2e2)
val ubs = s2Var_get_ubs (s2V1)
val () = s2Var_set_ubs (s2V1, list_cons (ub, ubs))
//
in
  // nothing
end // end of [s2hnf_tyleq_solve_lVar_err]

extern
fun
s2hnf_tyleq_solve_rVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V2: s2Var, err: &int
) : void // end of [s2hnf_tyleq_solve_rVar_err]
implement
s2hnf_tyleq_solve_rVar_err
  (loc0, s2f1, s2f2, s2V2, err) = let
//
val s2e1 = s2hnf2exp (s2f1)
//
(*
val () = (
  println! ("s2hnf_tyleq_solve_rVar_err: s2e1 = ", s2e1);
  println! ("s2hnf_equal_solve_rVar_err: s2V2 = ", s2V2);
) // end of [val]
*)
//
val () = s2Var_s2exp_srtck_err (loc0, s2V2, s2e1, err)
//
val () = let
  val s2ze1 = s2zexp_make_s2exp (s2e1)
in
  s2Var_merge_szexp_err (loc0, s2V2, s2ze1, err)
end // end of [val]
//
val () = let
  val ubs = s2Var_get_ubs (s2V2)
in
  s2hnf_tyleq_solve_ubs_err (loc0, s2f1, ubs, err)
end // end of [val]
//
val () = let
  val lb =
    s2VarBound_make (loc0, s2e1)
  val lbs = s2Var_get_lbs (s2V2)
in
  s2Var_set_lbs (s2V2, list_cons (lb, lbs))
end // end of [val]
//
in
  // nothing
end // end of [s2hnf_tyleq_solve_rVar_err]

(* ****** ****** *)

implement
s2hnf_tyleq_solve
  (loc0, s2f10, s2f20) = err where {
  var err: int = 0
  val () = s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
} // end of [s2hnf_tyleq_solve]

implement
s2exp_tyleq_solve
  (loc0, s2e10, s2e20) = err where {
  var err: int = 0
  val () = s2exp_tyleq_solve_err (loc0, s2e10, s2e20, err)
} // end of [s2exp_tyleq_solve]

(* ****** ****** *)

implement
s2hnf_tyleq_solve_err
  (loc0, s2f10, s2f20, err) = let
//
val err0 = err
val s2e10 = s2hnf2exp (s2f10)
and s2e20 = s2hnf2exp (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
//
(*
val () = (
  println! ("s2hnf_tyleq_solve_err: err0 = ", err0);
  print ("s2hnf_tyleq_solve_err: s2e10 = "); pprint_s2exp (s2e10); print_newline ();
  print ("s2hnf_tyleq_solve_err: s2e20 = "); pprint_s2exp (s2e20); print_newline ();
) // end of [val]
*)
//
val () =
(
case+ (s2en10, s2en20) of
//
| (S2Einvar s2e11, _) => let
    val s2f11 = s2exp2hnf (s2e11) in
    s2hnf_tyleq_solve_err (loc0, s2f11, s2f20, err)
  end // end of [S2Einvar, _]
| (_, S2Einvar s2e21) => let
    val s2f21 = s2exp2hnf (s2e21)
    val s2e21 = s2hnf2exp (s2f21)
  in
    case+ s2e21.s2exp_node of
    | S2EVar s2V2 =>
        s2hnf_equal_solve_rVar_err (loc0, s2f10, s2f21, s2V2, err)
    | _ => s2hnf_tyleq_solve_err (loc0, s2f10, s2f21, err)
  end // end of [_, S2Einvar]
//
| (_, S2EVar s2V2) =>
    s2hnf_tyleq_solve_rVar_err (loc0, s2f10, s2f20, s2V2, err)
  // end of [_, S2EVar]
| (S2EVar s2V1, _) =>
    s2hnf_tyleq_solve_lVar_err (loc0, s2f10, s2f20, s2V1, err)
  // end of [S2EVar, _]
//
| (S2Etop(knd1, s2e1), _) => (
  case+ s2en20 of
  | S2Etop (knd2, s2e2) => (
      if knd1 >= knd2 then let
        val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
      in
        // nothing
      end else (err := err + 1) // end of [if]
    ) // end of [S2Etop]
  | _ => (err := err + 1)
  ) // end of [S2Etop, _]
| (_, S2Etop(knd2, s2e2)) => (
  case+ 0 of
  | _ when knd2 = 0 => let
      // [s2e0] is topized version of some type
    in
      if (
        s2exp_is_nonlin(s2e10)
      ) then (
        if s2exp_tszeq(s2e10, s2e20) then () else (err := err + 1)
      ) else (err := err + 1) // end of [if]
    end // end of [knd2 = 0]
  | _ (* knd2 > 0 *) => (err := err + 1)
  ) // end of [_, S2Etop]
//
| (S2Euni _, _) => let
//
    val (pfpush | ()) = trans3_env_push ()
//
    // this order is mandatary!
    val s2e2 = s2hnf_absuni_and_add (loc0, s2f20)
    val (s2e1, s2ps) = s2exp_uni_instantiate_all (s2e10, loc0, err)
//
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
//
  in
    trans3_env_pop_and_add_main (pfpush | loc0)
  end // end of [S2Euni, _]
| (_, S2Eexi _) => let
//
    val (pfpush | ()) = trans3_env_push ()
//
    // this order is mandatary!
    val s2e1 = s2hnf_opnexi_and_add (loc0, s2f10)
    val (s2e2, s2ps) = s2exp_exi_instantiate_all (s2e20, loc0, err)
//
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
//
  in
    trans3_env_pop_and_add_main (pfpush | loc0)
  end // end of [_, S2Eexi]
//
| (_, S2Euni _) => let
    val (pfpush | ()) = trans3_env_push ()
    val s2e2 = s2hnf_absuni_and_add (loc0, s2f20)
    val () = s2exp_tyleq_solve_err (loc0, s2e10, s2e2, err)
  in
    trans3_env_pop_and_add_main (pfpush | loc0)
  end // end of [_, S2Euni]
| (S2Eexi _, _) => let
    val (pfpush | ()) = trans3_env_push ()
    val s2e1 = s2hnf_opnexi_and_add (loc0, s2f10)
    val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e20, err)
  in
    trans3_env_pop_and_add_main (pfpush | loc0)
  end // end of [S2Eexi, _]
//
| (S2Ecst s2c1, _) => (case+ s2en20 of
  | S2Ecst s2c2 =>
      if s2cst_subeq (s2c1, s2c2) then () else (err := err + 1)
    // end of [S2Ecst]
  | _ => (err := err + 1)
  ) // end of [S2Ecst, _]
//
| (S2Eapp (s2e1_fun, s2es1_arg), _) => (
  case+ s2en20 of
  | S2Ecst s2c2 => (
    case+ (
      s2e1_fun.s2exp_node
    ) of // [case]
    | S2Ecst s2c1 =>
        if s2cst_subeq (s2c1, s2c2) then () else (err := err + 1)
      // end of [S2Ecst]
    | _ => (err := err + 1)
    ) // end of [S2Ecst]
  | S2Eapp (s2e2_fun, s2es2_arg) => (
    case+ (
      s2e1_fun.s2exp_node
    , s2e2_fun.s2exp_node
    ) of // [case]
    | (S2Ecst s2c1, S2Ecst s2c2) => let
        val subeq = s2cst_subeq (s2c1, s2c2)
      in
        if subeq then let
          val-list_cons (argsrts, _) = s2cst_get_argsrtss (s2c1) in
          s2explst_tyleq_solve_argsrtlst_err (loc0, argsrts, s2es1_arg, s2es2_arg, err)
        end else (err := err + 1)
      end // end of [S2Ecst, S2Ecst]
    | (_, _) => let // HX: sound but incomplete!
        val () = s2exp_equal_solve_err (loc0, s2e1_fun, s2e2_fun, err)
        val errlen = s2explst_equal_solve_err (loc0, s2es1_arg, s2es2_arg, err)
      in
        // nothing
      end // end of [_, _]
    ) // end of [S2Eapp]
  | _ => (err := err + 1)
  ) (* end of [S2Eapp, _] *)
| (S2Efun (fc1, lin1, s2fe1, npf1, s2es1_arg, s2e1_res), _) => (
  case+ s2en20 of
  | S2Efun (fc2, lin2, s2fe2, npf2, s2es2_arg, s2e2_res) => let
      val () = funclo_equal_solve_err (loc0, fc1, fc2, err)
      val () = linearity_equal_solve_err (loc0, lin1, lin2, err)
      val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
      val () = s2eff_subeq_solve_err (loc0, s2fe1, s2fe2, err)
      val () = s2explst_tyleq_solve_err (loc0, s2es2_arg, s2es1_arg, err) // contravariant!
      val () = s2exp_tyleq_solve_err (loc0, s2e1_res, s2e2_res, err)
    in
      // nothing
    end (* end of [S2Efun] *)
  | _ => (err := err + 1)
  ) // end of [S2Efun, _]
//
| (S2Eat (s2e11, s2e12), _) => (
  case+ s2en20 of
  | S2Eat (s2e21, s2e22) => let
      val () = s2exp_tyleq_solve_err (loc0, s2e11, s2e21, err)
      val () = s2exp_equal_solve_err (loc0, s2e12, s2e22, err)
    in
      // nothing
    end // end of [S2Eat]
  | _ => (err := err + 1)
  )
//
| (S2Etyarr (s2e11, s2es12), _) => (
  case+ s2en20 of
  | S2Etyarr (s2e21, s2es22) => let
      val () = s2exp_tyleq_solve_err (loc0, s2e11, s2e21, err)
      val () = s2explst_equal_solve_err (loc0, s2es12, s2es22, err)
    in
      // nothing
    end // end of [S2Etyarr]
  | _ => (err := err + 1)
  )
| (S2Etyrec (knd1, npf1, ls2es1), _) => (
  case+ s2en20 of
  | S2Etyrec (knd2, npf2, ls2es2) => let
      val () =
        tyreckind_equal_solve_err (loc0, knd1, knd2, err)
      // end of [val]
      val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
    in
      labs2explst_tyleq_solve_err (loc0, ls2es1, ls2es2, err)
    end // end of [S2Etyrec]
  | _ => (err := err + 1)
  ) (* end of [S2Etyrec, _] *)
//
| (S2Edatconptr
    (d2c1, s2e1, s2es1), _
  ) => (case+ s2en20 of
  | S2Edatconptr
      (d2c2, s2e2, s2es2) => (
      if d2c1 = d2c2 then let
        val () =
          s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
        // end of [val]
      in
        s2explst_equal_solve_err (loc0, s2es1, s2es2, err)
      end else (err := err + 1)
    ) // end of [S2Edatconptr]
  | _ => (err := err + 1)
  ) // end of [S2Edatconptr, _]
//
| (S2Erefarg (knd1, s2e1), _) =>
  (
  case+ s2en20 of
  | S2Erefarg (knd2, s2e2) => let
      val () =
        refval_equal_solve_err (loc0, knd1, knd2, err)
      // end of [val]
    in
      s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
    end // end of [S2Erefarg]
  | _ => (err := err + 1)
  )
| (S2Ewthtype (s2e1, ws2es1), _) =>
  (
  case+ s2en20 of
  | S2Ewthtype(s2e2, ws2es2) => let
      val () =
        s2exp_tyleq_solve_err(loc0, s2e1, s2e2, err)
      // end of [val]
    in
      wths2explst_tyleq_solve_err(loc0, ws2es1, ws2es2, err)
    end // end of [S2Ewth]
  | _ => (err := err + 1)
  ) (* end of [S2Ewth, _] *)
//
| (S2Ewithout(s2e1), _) => (
  case+ s2en20 of
  | S2Ewithout(s2e2) =>
      if ~s2exp_tszeq(s2e1, s2e2) then (err := err + 1)
    // end of [S2Ewithout]
  | _ (*non-S2Ewithout*) => (err := err + 1)
  )
//
| (_, _) when s2hnf_syneq2(s2f10, s2f20) => ()
//
| (_, _) => (err := err + 1)
//
) (* end of [case] *) // end of [val]
//
val () =
if err > err0 then
  the_staerrlst_add (STAERR_s2exp_tyleq (loc0, s2e10, s2e20))
// end of [if] // end of [val]
//
in
  // nothing
end // end of [s2hnf_tyleq_solve_err]

implement
s2exp_tyleq_solve_err
  (loc0, s2e10, s2e20, err) = let
  val err0 = err
  val s2f10 = s2exp2hnf (s2e10)
  and s2f20 = s2exp2hnf (s2e20)
in
  s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_tyleq_solve_err]

(* ****** ****** *)

implement
s2explst_tyleq_solve_err
  (loc0, s2es1, s2es2, err) = let
//
fun loop (
  loc0: location
, s2es1: s2explst, s2es2: s2explst
, err: &int
) : int = case+ s2es1 of
  | list_cons (s2e1, s2es1) => (
    case+ s2es2 of
    | list_cons (s2e2, s2es2) => let
        val () =
          s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
        // end of [val]
      in
        loop (loc0, s2es1, s2es2, err)
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil () => (
    case+ s2es2 of
    | list_cons _ => ~1 | list_nil () => 0
    ) // end of [list_nil]
// end of [loop]
//
val sgn = loop (
  loc0, s2es1, s2es2, err
) // end of [val]
val () = if (sgn != 0) then {
  val () = err := err + 1
  val () = the_staerrlst_add (STAERR_s2explst_length (loc0, sgn))
} // end of [val] 
in
  // nothing
end // end of [s2explst_tyleq_solve_err]

(* ****** ****** *)

implement
labs2explst_tyleq_solve_err
  (loc0, ls2es1, ls2es2, err) = let
//
fun loop (
  loc0: location
, ls2es1: labs2explst, ls2es2: labs2explst
, err: &int
) : int = case+ ls2es1 of
  | list_cons (ls2e1, ls2es1) => (
    case+ ls2es2 of
    | list_cons (ls2e2, ls2es2) => let
        val SLABELED (l1, _, s2e1) = ls2e1
        val SLABELED (l2, _, s2e2) = ls2e2
        val () = label_equal_solve_err (loc0, l1, l2, err)
        val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
      in
        loop (loc0, ls2es1, ls2es2, err)
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil () => (
    case+ ls2es2 of list_cons _ => ~1 | list_nil () => 0
    ) // end of [list_nil]
// end of [loop]
//
val sgn = loop (
  loc0, ls2es1, ls2es2, err
) // end of [val]
val () = if (sgn != 0) then {
  val () = err := err + 1
  val () = the_staerrlst_add (STAERR_labs2explst_length (loc0, sgn))
} // end of [val]
in
  // nothing
end // end of [labs2explst_tyleq_solve_err]

(* ****** ****** *)

implement
wths2explst_tyleq_solve_err
  (loc0, xs1, xs2, err) = let
//
fun loop (
  loc0: location
, xs1: wths2explst, xs2: wths2explst
, err: &int
) : int = let
in
//
case (xs1, xs2) of
| (WTHS2EXPLSTcons_invar (k1, x1, xs1),
   WTHS2EXPLSTcons_invar (k2, x2, xs2)) => let
    val () =
      refval_equal_solve_err (loc0, k1, k2, err)
    val () = s2exp_tyleq_solve_err (loc0, x1, x2, err)
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTcons_invar (k1, x1, xs1),
   WTHS2EXPLSTcons_trans (k2, x2, xs2)) => let
    val () =
      refval_equal_solve_err (loc0, k1, k2, err)
    val () = s2exp_tyleq_solve_err (loc0, x1, x2, err)
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTcons_trans (k1, x1, xs1),
   WTHS2EXPLSTcons_trans (k2, x2, xs2)) => let
    val () =
      refval_equal_solve_err (loc0, k1, k2, err)
    val () = s2exp_tyleq_solve_err (loc0, x1, x2, err)
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTcons_none (xs1),
   WTHS2EXPLSTcons_none (xs2)) => let
  in
    loop (loc0, xs1, xs2, err)
  end
| (WTHS2EXPLSTnil (), WTHS2EXPLSTnil ()) => 0
| (_, _) => let
    val () = err := err + 1 in 1 // shape mismatch
  end // end of [_, _]
//
end // end of [loop]
//
val mis = loop (loc0, xs1, xs2, err)
val () = if mis > 0 then
  the_staerrlst_add (STAERR_wths2explst_shape (loc0, xs1, xs2))
// end of [val]
in
  // nothing
end // end of [wths2explst_tyleq_solve_err]

(* ****** ****** *)

implement
s2hnf_tyleq_solve_lbs_err
  (loc0, lbs, s2f, err) = let
  macdef loop = s2hnf_tyleq_solve_lbs_err
in
  case+ lbs of
  | list_cons (lb, lbs) => let
      val s2f_lb = s2exp2hnf (s2VarBound_get_val (lb))
      val () = s2hnf_tyleq_solve_err (loc0, s2f_lb, s2f, err)
    in
      loop (loc0, lbs, s2f, err)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [s2hnf_tyleq_solve_lbs_err]

implement
s2hnf_tyleq_solve_ubs_err
  (loc0, s2f, ubs, err) = let
  macdef loop = s2hnf_tyleq_solve_ubs_err
in
  case+ ubs of
  | list_cons (ub, ubs) => let
      val s2f_ub = s2exp2hnf (s2VarBound_get_val (ub))
      val () = s2hnf_tyleq_solve_err (loc0, s2f, s2f_ub, err)
    in
      loop (loc0, s2f, ubs, err)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [s2hnf_tyleq_solve_ubs_err]

(* ****** ****** *)

implement
s2explst_tyleq_solve_argsrtlst_err
  (loc0, argsrts, s2es1, s2es2, err) = let
(*
  val () = (
    println! "s2explst_tyleq_solve_argsrtlst_err: enter"
  ) // end of [val]
*)
in
//
case+ s2es1 of
| list_cons (s2e1, s2es1) => (
  case+ s2es2 of
  | list_cons (s2e2, s2es2) => let
      val-list_cons
        (argsrt, argsrts) = argsrts
      // end of [val]
      val pol = s2rt_get_pol (argsrt.1)
      val () = (
        if pol = 0 then
          s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
        else if pol > 0 then
          s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
        else // pol < 0
          s2exp_tyleq_solve_err (loc0, s2e2, s2e1, err)
        // end of [if]
      ) : void // end of [val]
    in
      s2explst_tyleq_solve_argsrtlst_err (loc0, argsrts, s2es1, s2es2, err)
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_cons]
| list_nil () => ()
//
end // end of [s2explst_tyleq_solve_argsrtlst_err]

(* ****** ****** *)

fun
s2hnf_hypequal_solve_abscon
(
  loc0: location, s2f1: s2hnf, s2f2: s2hnf
) : void = let
(*
val () = begin
  println! ("s2exp_hypequal_solve_abscon: s2e1 = ", s2f1);
  println! ("s2exp_hypequal_solve_abscon: s2e2 = ", s2f2);
end // end of [val]
*)
val s2e1 = s2hnf2exp (s2f1) and s2e2 = s2hnf2exp (s2f2)
//
fun
auxsolve
(
  loc0: location
, s2e1: s2exp, s2e2: s2exp
) : void =
  case+ (s2e1.s2exp_node, s2e2.s2exp_node) of
  | (S2Eapp (s2e1_fun, s2es1_arg),
     S2Eapp (s2e2_fun, s2es2_arg)) => let
      val () = auxsolve (loc0, s2e1_fun, s2e2_fun)
    in
      s2explst_hypequal_solve (loc0, s2es1_arg, s2es2_arg)
    end
  | (_, _) => ()
// end of [auxsolve]
//
fun
auxcheck
(
  s2e1: s2exp, s2e2: s2exp
) : bool =
(
case+
( s2e1.s2exp_node
, s2e2.s2exp_node
) of // case+
| (S2Ecst s2c1, S2Ecst s2c2) => eq_s2cst_s2cst (s2c1, s2c2)
| (S2Eapp (s2e1, _), S2Eapp (s2e2, _)) => auxcheck (s2e1, s2e2)
| (_, _) => false
)
in
//
if
auxcheck(s2e1, s2e2)
then begin
//
// C1(arg1_1)...(arg1_n) = C2(arg2_1)...(arg2_n)
//
  auxsolve (loc0, s2e1, s2e2)
end // end of [then]
else begin
  trans3_env_hypadd_prop (loc0, s2exp_bool false)
end // end of [else]
//
end // end of [s2exp_hypequal_solve_abscon]

(* ****** ****** *)

implement
s2hnf_hypequal_solve
  (loc0, s2f1, s2f2) = let
(*
val () =
(
  println! ("s2exp_hypequal_solve: s2f1 = ", s2f1);
  println! ("s2exp_hypequal_solve: s2f2 = ", s2f2);
) (* end of [val] *)
*)
//
val s2e1 = s2hnf2exp (s2f1) and s2e2 = s2hnf2exp (s2f2)
//
in
//
case+
( s2e1.s2exp_node
, s2e2.s2exp_node
) of // case+
| (_, _) when
  (
    s2hnf_is_abscon(s2f1) && s2hnf_is_abscon(s2f2)
  ) (* when *) =>
    s2hnf_hypequal_solve_abscon (loc0, s2f1, s2f2)
  // end of [abscon, abscon]
| (S2Ecst s2c1, S2Ecst s2c2) when s2c1 = s2c2 => ()
//
| (S2Evar s2v1,
   S2Evar s2v2) => let
    val sgn = compare_s2var_s2var(s2v1, s2v2)
  in
    case+ sgn of 
    | _ when sgn > 0 =>
        trans3_env_hypadd_bind (loc0, s2v1, s2f2)
    | _ when sgn < 0 =>
        trans3_env_hypadd_bind (loc0, s2v2, s2f1)
    | _ (* sgn = 0: s2v1 = s2v2 *) => ((*void*))
  end // end of [S2Evar _, S2Evar _]
//
| (S2Evar s2v1, _) => let
    val test = s2var_occurcheck_s2exp(s2v1, s2e2)
  in
    if test
      then trans3_env_hypadd_eqeq(loc0, s2f1, s2f2)
      else trans3_env_hypadd_bind(loc0, s2v1, s2f2)
    // end of [if]
  end // end of [(S2Evar, _)]
| (_, S2Evar s2v2) => let
    val test = s2var_occurcheck_s2exp(s2v2, s2e1)
  in
    if test
      then trans3_env_hypadd_eqeq(loc0, s2f1, s2f2)
      else trans3_env_hypadd_bind(loc0, s2v2, s2f1)
    // end of [if]
  end // end of [(_, S2Evar)]
//
| (S2Efun (_, _, _, _, s2es11, s2e12),
   S2Efun (_, _, _, _, s2es21, s2e22)) => let
    val () =
      s2exp_hypequal_solve(loc0, s2e12, s2e22)
    // end of [val]
  in
    s2explst_hypequal_solve(loc0, s2es21, s2es11)
  end // end of [S2Efun _, S2Efun _]
//
| (_, _) => trans3_env_hypadd_eqeq(loc0, s2f1, s2f2)
//
end // end of [s2exp_hypequal_solve]

(* ****** ****** *)

implement
s2exp_hypequal_solve
  (loc0, s2e10, s2e20) = let
  val s2f10 = s2exp2hnf(s2e10)
  and s2f20 = s2exp2hnf(s2e20)
in
  s2hnf_hypequal_solve(loc0, s2f10, s2f20)
end // end of [s2exp_hypequal_solve]

implement
s2explst_hypequal_solve
  (loc0, s2es1, s2es2) = let
in
//
case+ s2es1 of
| list_nil() =>
  (
  case+ s2es2 of
  | list_nil() => ()
  | list_cons _ =>
    trans3_env_hypadd_prop(loc0, s2exp_bool(false))
  ) // end of [list_nil]
| list_cons(s2e1, s2es1) =>
  (
  case+ s2es2 of
  | list_nil() =>
    trans3_env_hypadd_prop(loc0, s2exp_bool(false))
  | list_cons
      (s2e2, s2es2) => let
      val () =
        s2exp_hypequal_solve (loc0, s2e1, s2e2)
      // end of [val]
    in
      s2explst_hypequal_solve (loc0, s2es1, s2es2)
    end // end of [list_cons]
  ) (* end of [list_cons] *)
//
end // end of [s2explst_hypequal_solve]

(* ****** ****** *)

(* end of [pats_staexp2_solve.dats] *)
