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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
ERR = "./pats_error.sats"

(* ****** ****** *)

staload
LOC ="./pats_location.sats"
overload print with $LOC.print_location
overload prerr with $LOC.prerr_location

(* ****** ****** *)

staload "./pats_fixity.sats"

(* ****** ****** *)

implement
fprint_fxty
  (out, fxty) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
  case+ fxty of
  | FXTYnon () => begin
      prstr ("FXTYnon()")
    end // end of [FXTYnon]
  | FXTYinf (p, a) => begin
      prstr "FXTYinf("; fprint_int (out, (int_of_prec)p); prstr ")"
    end // end of [FXTYinf]
  | FXTYpre (p) => begin
      prstr "FXTYpre("; fprint_int (out, (int_of_prec)p); prstr ")"
    end // end of [FXTYpre]
  | FXTYpos (p) => begin
      prstr "FXTYpos("; fprint_int (out, (int_of_prec)p); prstr ")"
    end // end of [FXTYpos]
end // end of [fprint_fxty]

implement print_fxty (x) = fprint_fxty (stdout_ref, x)
implement prerr_fxty (x) = fprint_fxty (stderr_ref, x)

(* ****** ****** *)

implement fxty_non = FXTYnon ()
implement fxty_inf (p, a) = FXTYinf (p, a)
implement fxty_pre (p) = FXTYpre p
implement fxty_pos (p) = FXTYpos p

(* ****** ****** *)

implement
selptr_fxty_dyn = FXTYinf (select_prec, ASSOClft)

implement deref_fxty_dyn = FXTYpre (deref_prec_dyn)

(* ****** ****** *)

implement
fxty_get_prec
  (fxty) = case+ fxty of
  | FXTYnon () => None_vt ()
  | FXTYinf (p, _) => Some_vt (p)
  | FXTYpre p => Some_vt (p)
  | FXTYpos p => Some_vt (p)
// end of [fxty_get_prec]

(* ****** ****** *)

implement
fxopr_associativity (x) = begin
  case+ x of FXOPRinf (_, a, _) => a | _ => ASSOCnon ()
end // end of [fxopr_associativity]
        
implement
fxopr_precedence (x) = begin case+ x of
  | FXOPRinf (p, _, _) => p | FXOPRpre (p, _) => p | FXOPRpos (p, _) => p
end // end of [fxopr_precedence]

(* ****** ****** *)

local
//
macdef app_assoc = ASSOClft (* left association *)
//
in // in of [local]
//
implement
fxitm_app (loc, f) = FXITMopr (loc, FXOPRinf (app_prec, app_assoc, f))
//
end // end of [local]

(* ****** ****** *)

implement
fxopr_make {a} (
  locf, appf, opr, fxty
) = let
//
  val loc_opr = locf opr
//
  fn aux_inf (
    opr: a, p: prec, a: assoc
  ) :<cloref1> fxitm a = let
    fn f (x1: a, x2: a):<cloref1> fxitm a = let
      val loc = $LOC.location_combine (locf x1, locf x2)
    in
      FXITMatm (appf (loc, opr, loc, '[x1, x2]))
    end // end of [f]
  in
    FXITMopr (locf (opr), FXOPRinf (p, a, f))
  end // end of [aux_inf]
//
  fn aux_pre (
    opr: a, p: prec
  ) :<cloref1> fxitm a = let
    fn f (x: a):<cloref1> fxitm a = let
      val loc_x = locf x
      val loc = $LOC.location_combine (loc_opr, loc_x)
    in
      FXITMatm (appf (loc, opr, loc_x, '[x]))
    end // end of [f]
  in
    FXITMopr (locf (opr), FXOPRpre (p, f))
  end // end of [aux_pre]
//
  fn aux_pos (
    opr: a, p: prec
  ) :<cloref1> fxitm a = let
    fn f (x: a):<cloref1> fxitm a = let
      val loc_x = locf x
      val loc = $LOC.location_combine (loc_x, loc_opr)
    in
      FXITMatm (appf (loc, opr, loc_x, '[x]))
    end // end of [f]
  in
    FXITMopr (locf (opr), FXOPRpos (p, f))
  end // end of [aux_pos]
//
in 
//
case+ fxty of
| FXTYnon () => FXITMatm (opr)
| FXTYinf (p, a) => aux_inf (opr, p, a)
| FXTYpre p => aux_pre (opr, p)
| FXTYpos p => aux_pos (opr, p)
//
end // end of [fxopr_make]

(* ****** ****** *)

implement
fxopr_make_backslash
  {a} (locf, appf, loc) = let
  fn f1 (x: a):<cloref1> fxitm a = let
    val loc = $LOC.location_combine (loc, locf x)
    fn f2 (x1: a, x2: a):<cloref1> fxitm a = let
      val loc = $LOC.location_combine (locf x1, locf x2)
    in
      FXITMatm (appf (loc, x, loc, '[x1, x2]))
    end // end of [f2]
  in
    FXITMopr (loc, FXOPRinf (infixtemp_prec, ASSOCnon, f2))
  end // end of [f1]
in
  FXITMopr (loc, FXOPRpre (backslash_prec, f1))
end // end of [fxopr_make_backslahsh]

(* ****** ****** *)

(*
** HX-2011-04-10:
** this is some code I originally wrote in 1998
** for implementing DML; it has been a while :)
*)

implement
fixity_resolve
  {a} (
  loc0, locf, app, xs
) = let
//
#define nil list_nil
#define cons list_cons
#define :: list_cons
//
typedef I = fxitm a
typedef J = List (I)
//
fn erropr (
  loc: location
) : a = let
  val () = prerr (loc)
  val () = prerr ": error(1)"
  val () = prerr ": operator fixity cannot be resolved."
  val () = prerr_newline ()
in
  $raise($ERR.PATSOPT_FIXITY_EXN(*void*))
end // end of [erropt]
//
fn errapp (
  locf: a -> location, m: fxitm a
) : a = let
  val-FXITMatm atm = m
  val () = prerr (locf(atm))
  val () = prerr ": error(1)"
  val () = prerr ": application fixity cannot be resolved."
  val () = prerr_newline ()
in
  $raise($ERR.PATSOPT_FIXITY_EXN(*void*))
end // end of [errapp]
//
fn err_reduce (
  loc: location, ys: J
) : a = let
  val () = prerr (loc)
  val () = prerr ": error(1)"
  val () = prerr ": operator fixity cannot be resolved."
  val () = prerr_newline ()
in
  $raise($ERR.PATSOPT_FIXITY_EXN(*void*))
end // end of [err]
//
(*
** HX: [fn*] for mutual tail-recursion
*)
fn* resolve (
  xs: J, m: I, ys: J
) :<cloref1> a = case+ m of
  | FXITMatm _ => (
    case+ ys of
    | FXITMatm _ :: _ =>
        resolve_app (xs, m, ys)
      // end of [FXITMatm]
    | _ => pushup (xs, m :: ys)
    ) // end of [_, FXITMatm, _]
  | FXITMopr (loc, opr) => resolve_opr (loc, opr, xs, m, ys)
(* end of [resolve] *)
//
and resolve_opr
(
  loc: location
, opr: fxopr a, xs: J, m: I, ys: J
) :<cloref1> a =
(
  case+ (opr, ys) of
  | (FXOPRinf _, _ :: nil ()) => pushup (xs, m :: ys)
  | (FXOPRinf _, _ :: FXITMopr (_, opr1) :: _) => let
      val p = fxopr_precedence opr and p1 = fxopr_precedence opr1
    in
      case+ compare (p, p1) of
      |  1 => pushup (xs, m :: ys)
      | ~1 => reduce (m :: xs, ys)
      |  _ (* 0 *) => let
           val assoc = fxopr_associativity opr
           and assoc1 = fxopr_associativity opr1
         in
           case+ (assoc, assoc1) of
           | (ASSOClft (), ASSOClft ()) => reduce (m :: xs, ys)
           | (ASSOCrgt (), ASSOCrgt ()) => pushup (xs, m :: ys)
           | (_, _) => erropr (loc)
         end // end of [_ (* 0 *)]
    end // end of [let]
  | (FXOPRpre _, _) => pushup (xs, m :: ys)
  | (FXOPRpos _, _ :: FXITMopr (_, opr1) :: _) => let
      val p = fxopr_precedence opr and p1 = fxopr_precedence opr1
    in
      case+ compare (p, p1) of
      |  1 => reduce (xs, m :: ys)
      | ~1 => reduce (m :: xs, ys)
      |  _ (* 0 *) => erropr (loc)
    end // end of [let]
  | (FXOPRpos _, _ :: nil ()) => reduce (xs, m :: ys)
  | (_, _) => erropr (loc)
) (* end of [resolve_opr] *)
//
and resolve_app (
  xs: J, m: I, ys: J
) :<cloref1> a =
(
  case+ ys of
  | _ :: FXITMopr (_, opr1) :: _ => let
      val p1 = fxopr_precedence opr1
      val sgn = compare (app_prec, p1): Sgn
    in
      case+ sgn of
      |  1 => pushup
         (xs, m :: app :: ys)
      | ~1 => reduce (m :: xs, ys)
      | _ (*0*) => let
           val assoc1 = fxopr_associativity opr1 in
           case+ assoc1 of
           | ASSOClft () => reduce (m :: xs, ys)
           | _ => errapp (locf, m) // HX: [m] is FXITMatm
         end // end of [_]
    end // end of [_ :: ITERMopr :: _]
  | _ :: nil () => pushup (xs, m :: app :: ys)
  | _ => errapp (locf, m) // HX: [m] is FXITMatm
) (* end of [resolve_app] *)
//
and reduce (
  xs: J, ys: J
) :<cloref1> a =
(
  case+ ys of
  | FXITMatm t :: FXITMopr (_, FXOPRpre (_, f)) :: ys => pushup (f t :: xs, ys)
  | FXITMatm t1 :: FXITMopr (_, FXOPRinf (_, _, f)) :: FXITMatm t2 :: ys => pushup (f (t2, t1) :: xs, ys)
  | FXITMopr (_, FXOPRpos (_, f)) :: FXITMatm t :: ys => pushup (xs, f t :: ys)
  | _ (*rest*) => err_reduce (loc0, ys)
) (* end of [reduce] *)
//
and pushup (
  xs: J, ys: J
) :<cloref1> a = case+ (xs, ys) of
  | (nil (), FXITMatm t :: nil ()) => t
  | (nil (), ys) => reduce (nil (), ys)
  | (x :: xs, ys) => resolve (xs, x, ys)
(* end of [pushup] *)
//
in
//
pushup (xs, nil ())
//
end // end of [fixity_resolve]

(* ****** ****** *)

(* end of [pats_fixity_fxty.dats] *)
