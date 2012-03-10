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
// Start Time: March, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_effect.sats"
staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

datatype
effenvitm =
  (* effenv item *)
  | EFFENVITMeff of effset
  | EFFENVITMeffmask of effset
  | EFFENVITMlam of s2eff
// end of [effenvitm]

dataviewtype
effenvitmlst =
  | EFILSTcons of (effenvitm, effenvitmlst)
  | EFILSTmark of (effenvitmlst)
  | EFILSTnil of ()
// end of [effenvitmlst]

(* ****** ****** *)

local

assume effenv_push_v = unit_v

val the_efis = ref<effenvitmlst> (EFILSTnil ())

fun
efilst_mark (
  xs: effenvitmlst
) :<1,~ref> effenvitmlst = EFILSTmark (xs)
// end of [efilst_mark]

fun
efilst_unmark (
  xs: effenvitmlst
) :<1,~ref> effenvitmlst =
  case+ xs of
  | ~EFILSTcons (_, xs) => efilst_unmark (xs)
  | ~EFILSTmark (xs) => xs
  | ~EFILSTnil () => EFILSTnil ()
// end of [efilst_unmark]

in // in of [local]

(* ****** ****** *)

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

(* ****** ****** *)

implement
the_effenv_push () = let
  val (vbox pf | p) = ref_get_view_ptr (the_efis)
  val () = !p := EFILSTmark (!p)
in
  (unit_v () | ())
end // end of [the_effenv_push]

implement
the_effenv_push_lam
  (s2fe) = let
//
val efi = EFFENVITMlam (s2fe)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (!p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_lam]

(* ****** ****** *)

implement
the_effenv_push_eff (efs) = let
//
val efi = EFFENVITMeff (efs)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (!p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_eff]

(* ****** ****** *)

implement
the_effenv_push_effmask (efs) = let
//
val efi = EFFENVITMeffmask (efs)
val (vbox pf | p) = ref_get_view_ptr (the_efis)
val efis = EFILSTmark (!p)
val () = !p := EFILSTcons (efi, efis)
//
in
  (unit_v () | ())
end // end of [the_effenv_push_effmask]

(* ****** ****** *)

implement
the_effenv_check_eff (efs0) = let
(*
val () = begin
  print "the_effenv_check_set: efs0 = "; print_effset (efs0); print_newline ()
end // end of [val]
*)
fun aux (
  efis: !effenvitmlst, efs0: effset
) : int =
  case+ efis of
  | EFILSTcons
      (efi, !p_efis) => (
    case+ efi of
    | EFFENVITMeff efs => let
        val isint = effset_is_inter (efs0, efs)
        val ans = (
          if isint then 1 else aux (!p_efis, efs0)
        ) : int // end of [val]
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeff]
    | EFFENVITMeffmask efs => let
        val ans = aux (!p_efis, effset_diff (efs0, efs))
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeffmask]
    | EFFENVITMlam s2fe => let
        val ans = (
          if s2eff_contain_set (s2fe, efs0) then 0 else 1
        ) : int // end of [val]
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMlam]
    ) // end of [EFILSTcons]
  | EFILSTmark (!p_efis) => let
      val ans = aux (!p_efis, efs0) in fold@ (efis); ans
    end // end of [EFILSTmark]
//
// HX: effects are all considered to be masked at the end
//
  | EFILSTnil () => (fold@ (efis); 0)
// end of [aux]
//
val (vbox pf | p) = ref_get_view_ptr (the_efis)
//
in
  $effmask_ref (aux (!p, efs0))
end // end of [the_effenv_check_eff]

(* ****** ****** *)

implement
the_effenv_check_svar (s2v0) = let
//
fun aux (
  efis: !effenvitmlst, s2v0: s2var
) : int =
  case+ efis of
  | EFILSTcons (efi, !p_efis) => (
    case+ efi of
    | EFFENVITMeff efs => let
        val isnil = effset_isnil (efs)
        val ans = ( // conservative estimation
          if isnil then aux (!p_efis, s2v0) else 1(*fail*)
        ) : int // end of [val]
      in
        fold@ (efis); ans
      end // end of [EFFENVITEMeff]
    | EFFENVITMeffmask _ => let
        val ans = aux (!p_efis, s2v0); prval () = fold@ (efis) in ans
      end // end of [EFFENVITEMeffmask]
    | EFFENVITMlam s2fe => let
        val ans = s2eff_contain_var (s2fe, s2v0); prval () = fold@ (efis)
      in
        if ans then 0 else 1
      end // end of [EFFENVITEMlam]
    ) // end of [list_cons]
  | EFILSTmark (!p_efis) => let
      val ans = aux (!p_efis, s2v0); prval () = fold@ (efis) in ans
    end // end of [EFILSTmark]
  | EFILSTnil () => (fold@ (efis); 0(*succ*))
// end of [aux]
//
val (vbox pf | p) = ref_get_view_ptr (the_efis)
//
in
  $effmask_ref (aux (!p, s2v0))
end // end of [the_effenv_check_svar]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_effect.dats] *)
