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
// Start Time: March, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env_effect"

(* ****** ****** *)

staload "./pats_effect.sats"
overload print with print_effset
overload prerr with prerr_effset

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

datatype
effenvitm =
  (* effenv item *)
  | EFFENVITMeff of effset // disallwed effects
  | EFFENVITMeffmask of s2eff // allowed effects
// end of [effenvitm]

dataviewtype
effenvitmlst =
  | EFILSTcons of (effenvitm, effenvitmlst)
  | EFILSTmark of (int(*knd*), effenvitmlst) // knd=0/1:soft/hard
  | EFILSTnil of ()
// end of [effenvitmlst]

(* ****** ****** *)

fun
efilst_mark (
  xs: effenvitmlst
) :<1,~ref> effenvitmlst = EFILSTmark (0(*soft*), xs)
// end of [efilst_mark]

fun
efilst_unmark (
  xs: effenvitmlst
) :<1,~ref> effenvitmlst =
  case+ xs of
  | ~EFILSTcons
      (_, xs) => efilst_unmark (xs)
  | ~EFILSTmark (_(*knd*), xs) => xs
  | ~EFILSTnil () => EFILSTnil ()
// end of [efilst_unmark]

(* ****** ****** *)

extern
fun effset_diff_s2eff
  (efs0: effset, s2fe: s2eff): effset
implement
effset_diff_s2eff
  (efs0, s2fe) = (
  case+ s2fe of
  | S2EFFset (efs) => effset_diff (efs0, efs)
  | S2EFFexp (exp) => efs0 (* conservative estimation *)
  | S2EFFadd (s2fe1, s2fe2) => (
      effset_diff_s2eff (effset_diff_s2eff (efs0, s2fe1), s2fe2)
    ) // end of [S2EFFadd]
) // end of [effset_diff_s2eff]

extern
fun effset_union_s2eff
  (efs0: effset, s2fe: s2eff): effset
implement
effset_union_s2eff
  (efs0, s2fe) = (
  case+ s2fe of
  | S2EFFset (efs) => effset_union (efs0, efs)
  | S2EFFexp (exp) => efs0 (* conservative estimation *)
  | S2EFFadd (s2fe1, s2fe2) => (
      effset_union_s2eff (effset_union_s2eff (efs0, s2fe1), s2fe2)
    ) // end of [S2EFFadd]
) // end of [effset_union_s2eff]

(* ****** ****** *)

local

assume effenv_push_v = unit_v
val the_efis = ref<effenvitmlst> (EFILSTnil ())

in (* in of [local] *)

implement
the_effenv_add_eff
  (eff) = let
  val (vbox pf | p) = ref_get_view_ptr (the_efis)
  val efs = effset_sing (eff)
  val efi = EFFENVITMeff (efs)
in
  !p := EFILSTcons (efi, !p)
end // end of [the_effenv_add_eff]

(* ****** ****** *)

implement
the_effenv_pop
  (pf | (*none*)) = let
  prval () = unit_v_elim (pf)
  val (vbox pf | p) = ref_get_view_ptr (the_efis)
in
  !p := efilst_unmark (!p)
end // end of [the_effenv_pop]

implement
the_effenv_pop_if
  (pfopt | test) =
  if test then let
    prval Some_v
      (pf) = pfopt in the_effenv_pop (pf | (*void*))
  end else let
    prval None_v () = pfopt in ()
  end // end of [if]
// end of [the_effenv_pop_if]

(* ****** ****** *)

implement
the_effenv_push () = let
  val (vbox pf | p) =
    ref_get_view_ptr (the_efis)
  // end of [val]
  val () = !p := EFILSTmark (0(*soft*), !p)
in
  (unit_v () | ())
end // end of [the_effenv_push]

implement
the_effenv_push_lam
  (s2fe) = let
//
val efi = EFFENVITMeffmask (s2fe)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (1(*hard*), !p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_lam]

(* ****** ****** *)

implement
the_effenv_push_set (efs) = let
//
val efi = EFFENVITMeff (efs)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (0(*soft*), !p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_set]

implement
the_effenv_push_set_if
  (test, efs) = (
  if test then let
    val (pf | ()) =
      the_effenv_push_set (efs) in (Some_v (pf) | ())
    // end of [val]
  end else (None_v () | ())
) // end of [the_effenv_push_set_if]

(* ****** ****** *)

implement
the_effenv_push_effmask (s2fe) = let
//
val efi = EFFENVITMeffmask (s2fe)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (0(*soft*), !p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_effmask]

(* ****** ****** *)

implement
the_effenv_check_set
  (loc0, efs0) = let
(*
val () =
  println! ("the_effenv_check_set: efs0 = ", efs0)
// end of [val]
*)
fun auxerr
(
  efs: effset
) :<cloref1> void = let
  val () = prerr_error3_loc (loc0)
  val () = filprerr_ifdebug "the_effenv_check_set"
  val () = prerrln! (": some disallowed effects may be incurred: ", efs)
in
  the_trans3errlst_add (T3E_effenv_check_set (loc0, efs0))
end (* end of [auxerr] *)
//  
fun auxcheck
(
  efis: !effenvitmlst, efs0: effset(*isnotnil*)
) :<cloref1> int =
  case+ efis of
  | EFILSTcons
      (efi, !p_efis) => (
    case+ efi of
    | EFFENVITMeff (efs) => let
        val efs =
          effset_inter (efs0, efs)
        // end of [val]
        val isnil = effset_isnil (efs)
        val ans = (
          if isnil then auxcheck (!p_efis, efs0) else 1(*fail*)
        ) : int // end of [val]
        val () = if ans > 0 then auxerr (efs)
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeff]
    | EFFENVITMeffmask (s2fe) => let
        val efs0 =
          effset_diff_s2eff (efs0, s2fe) // conservative
        val isnil = effset_isnil (efs0)
        val ans = (
          if isnil then 0(*succ*) else auxcheck (!p_efis, efs0)
        ) : int // end of [val]
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeffmask]
    ) // end of [EFILSTcons]
  | EFILSTmark (knd, !p_efis) => let
      val ans = ( // HX: note that [efs0] is not nil
        if knd > 0 then 1(*fail*) else auxcheck (!p_efis, efs0)
      ) : int // end of [val]
      val () = if knd > 0 then (if ans > 0 then auxerr (efs0))
    in
      fold@ (efis); ans
    end // end of [EFILSTmark]
//
// HX: effects are all considered to be masked at the end
//
  | EFILSTnil () => (fold@ (efis); 0)
// end of [aux]
//
val isnil = effset_isnil (efs0)
//
in
//
if isnil then 0 else let
  val (vbox pf | p) = ref_get_view_ptr (the_efis)
in
  $effmask_ref (auxcheck (!p, efs0))
end // end of [if]
//
end // end of [the_effenv_check_set]

(* ****** ****** *)

implement
the_effenv_check_eff
  (loc0, eff) = (
  the_effenv_check_set (loc0, effset_sing (eff))
) // end of [the_effenv_check_eff]

implement
the_effenv_check_exn
  (loc0) = the_effenv_check_set (loc0, effset_exn)
// end of [the_effenv_check_exn]

implement
the_effenv_check_ntm
  (loc0) = the_effenv_check_set (loc0, effset_ntm)
// end of [the_effenv_check_ntm]

implement
the_effenv_check_ref
  (loc0) = the_effenv_check_set (loc0, effset_ref)
// end of [the_effenv_check_ref]

implement
the_effenv_check_wrt
  (loc0) = the_effenv_check_set (loc0, effset_wrt)
// end of [the_effenv_check_wrt]

(* ****** ****** *)

implement
the_effenv_caskind_check_exn
  (loc0, casknd) = (case+ casknd of
  | CK_case () => the_effenv_check_exn (loc0)
  | CK_case_pos () => 0 // HX: a type error is to be reported
  | CK_case_neg () => 0 // HX: per the wish of the programmer
) // end of [the_effenv_caskind_check_exn]

(* ****** ****** *)

implement
the_effenv_check_sexp
  (loc0, s2e0) = let
(*
val () =
  println! ("the_effenv_check_sexp: s2e0 = ", s2e0)
// end of [val]
*)
fun auxerr (
  s2e0: s2exp
) :<cloref1> void = let
  val () = prerr_error3_loc (loc0)
  val () = filprerr_ifdebug "the_effenv_check_sexp"
  val () = prerrln! (": some disallowed effects may be incurred: ", s2e0)
in
  the_trans3errlst_add (T3E_effenv_check_sexp (loc0, s2e0))
end (* end of [auxerr] *)
//
fun auxcheck (
  efis: !effenvitmlst, mefs: effset, s2e0: s2exp
) :<cloref1> int =
  case+ efis of
  | EFILSTcons (efi, !p_efis) => (
    case+ efi of
    | EFFENVITMeff efs => let
        val issup = effset_supset (mefs, efs)
        val ans = (if issup then 0 else 1): int
        val () = if ans > 0 then auxerr (s2e0)
      in
        fold@ (efis); ans
      end // end of [EFFENVITMeff]
    | EFFENVITMeffmask s2fe => let
        val isnil = s2eff_contain_exp (s2fe, s2e0) // conservative
        val ans = (
          if isnil then 0(*succ*) else let
            val mefs = effset_union_s2eff (mefs, s2fe) // conservative
          in
            auxcheck (!p_efis, mefs, s2e0)
          end (* end of [if] *)
        ) : int // end of [val]
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeffmask]
    ) // end of [EFILSTcons]
  | EFILSTmark (knd, !p_efis) => let
      val ans = ( // HX: assuming [s2e0] is not nil
        if knd > 0 then 1(*fail*) else auxcheck (!p_efis, mefs, s2e0)
      ) : int // end of [val]
      val () = if ans > 0 then auxerr (s2e0)
    in
      fold@ (efis); ans
    end // end of [EFILSTmark]
  | EFILSTnil () => (fold@ (efis); 0(*succ*))
// end of [aux]
//
val (vbox pf | p) = ref_get_view_ptr (the_efis)
//
in
  $effmask_ref (auxcheck (!p, effset_nil, s2e0))
end // end of [the_effenv_check_sexp]

(* ****** ****** *)

implement
the_effenv_check_s2eff
  (loc0, s2fe0) = let
(*
val () =
  println! ("the_effenv_check_s2eff: s2fe0 = ", s2fe0)
// end of [val]
*)
val s2fe0 = s2eff_hnfize (s2fe0)
//
in
//
case+ s2fe0 of
| S2EFFset (efs0) =>
    the_effenv_check_set (loc0, efs0)
| S2EFFexp (s2e) => let
    val s2f = s2exp2hnf (s2e)
    val s2e = s2hnf2exp (s2f)
  in
    the_effenv_check_sexp (loc0, s2e)
  end // end of [S2EFFexp]
| S2EFFadd (s2fe1, s2fe2) => let
    val ans = the_effenv_check_s2eff (loc0, s2fe1)
  in
    if ans > 0 then 1 else the_effenv_check_s2eff (loc0, s2fe2)
  end // end of [S2EFFadd]
//
end // end of [the_effenv_check_s2eff]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_effect.dats] *)
