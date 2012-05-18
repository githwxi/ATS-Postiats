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
// Start Time: May, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_patcon"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

abstype lstate // for local state objects

(* ****** ****** *)

implement
lstbefitm_make
  (d2v, linval) = let
  val opt = d2var_get_type (d2v) in '{
  lstbefitm_var= d2v, lstbefitm_linval= linval, lstbefitm_type= opt
} end // end of [lstbefitm_make]

(* ****** ****** *)

implement
fprint_lstbefitm (out, x) = let
  macdef
    prstr (s) = fprint_string (out, ,(s))
  // end of [macdef]
  val () = prstr "lstbefitm("
  val () = fprint_d2var (out, x.lstbefitm_var)
  val () = prstr ", "
  val () = fprint_int (out, x.lstbefitm_linval)
  val () = prstr ", "
  val opt = x.lstbefitm_type
  val () = (
    case+ opt of
    | Some (s2e) =>
        (prstr "Some("; fprint_s2exp (out, s2e); prstr ")")
    | None () => prstr "None()"
  ) : void // end of [val]
  val () = prstr ")" // end of [val]
in
  // nothing
end // end of [fprint_lstbefitm]

implement
fprint_lstbefitmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_lstbefitm)
// end of [fprint_lstbefitmlst]

(* ****** ****** *)

implement
lstbefitmlst_restore_type
  (xs) = list_app_fun (xs, f) where {
  fun f (x: lstbefitm): void =
    d2var_set_type (x.lstbefitm_var, x.lstbefitm_type)
  // end of [f]
} // end of [where] // end of [lstbefitmlst_restore_type]

implement
lstbefitmlst_restore_linval_type
  (xs) = list_app_fun (xs, f) where {
  fun f (x: lstbefitm): void = let
    val d2v = x.lstbefitm_var
    val () =
      d2var_set_linval (d2v, x.lstbefitm_linval)
    val () = d2var_set_type (d2v, x.lstbefitm_type)
  in
    // nothing
  end // end of [f]
} // end of [where] // end of [lstbefitmlst_restore_type]

(* ****** ****** *)

datatype saityp =
  | SAITYPsome of (location, s2exp) | SAITYPnone of location
typedef saityplst = List saityp

(* ****** ****** *)

extern
fun saityp_get_loc (x: saityp): location

implement
saityp_get_loc (x) = (
  case+ x of SAITYPsome (loc, _) => loc | SAITYPnone (loc) => loc
) // end of [saityp_get_locl]

(* ****** ****** *)

extern
fun fprint_saityp : fprint_type (saityp)
extern
fun fprint_saityplst : fprint_type (saityplst)

implement
fprint_saityp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ x of
  | SAITYPsome (_, s2e) =>
      (prstr "SAITYPsome("; fprint_s2exp (out, s2e); prstr ")")
  | SAITYPnone _ => prstr "SAITYPnone()"
end // end of [fprint_saityp]

implement
fprint_saityplst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_saityp)
// end of [fprint_saityplst]

(* ****** ****** *)

extern
fun lstate_snapshot
  (): lstate // lstate creation by snapshot
// end of [lstate_snapshot]

extern
fun lstate_merge (lst1: lstate, lst2: lstate): lstate

(* ****** ****** *)

(* end of [pats_trans3_lstate.dats] *)
