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
// Time: February 2012
//
(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)

implement{a}
fprint_myintvec
  (out, iv, n) = let
//
  prval () =
    lemma_myintvec_params (iv)
  // end of [prval]
//
  viewtypedef x = myint(a)
  val (pf | p) = myintvec_takeout (iv)
  var i: int = 0
  viewdef v = int@i
  var !p_clo =
    @lam (pf: !v | x: &x): void => let
    val () = if i > 0 then fprint (out, ", ")
    val () = i := i + 1
  in
    fprint_myint (out, x)
  end // end of [var]
  val n = size1_of_int1 (n)
  val () = array_ptr_foreach_vclo<x> {v} (view@(i) | !p, !p_clo, n)
  prval () = myintvecout_addback (pf | iv)
in
  (*nothing*)
end // end of [fprint_intvec]

implement{a}
print_myintvec
  (x, n) = fprint_myintvec<a> (stdout_ref, x, n)
// end of [print_myintvec]

(* ****** ****** *)

implement{a}
fprint_myintveclst
  (out, xs, n) =
  case+ xs of
  | list_vt_cons
      (!p_x, !p_xs) => let
      val () = fprint_myintvec (out, !p_x, n)
      val () = fprint_newline (out)
      val () = fprint_myintveclst (out, !p_xs, n)
    in
      fold@ (xs)
    end // end of [list_vt]
  | list_vt_nil () => fold@ (xs)
// end of [fprint_myintveclst]

implement{a}
print_myintveclst
  (xs, n) = fprint_myintveclst<a> (stdout_ref, xs, n)
// end of [print_myintveclst]

(* ****** ****** *)

implement{a}
fprint_icnstr
  (out, ic, n) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ ic of
| ICvec
    (knd, !p_ivec) => let
    val () = prstr "ICvec("
    val () = (
      case+ knd of
      |  1 => prstr "=="
      | ~1 => prstr "!="
      |  2 => prstr ">="
      | ~2 => prstr "<<"
      | _ => fprint_int (out, knd)
    ) : void // end of [val]
    val () = prstr "; "
    val () = fprint_myintvec<a> (out, !p_ivec, n)
    val () = prstr ")"
  in
    fold@ (ic)
  end // end of [ICvec]
| ICveclst
    (knd, !p_ics) => let
    val () = prstr "ICveclst("
    val () = (
      case knd of
      | 0 => prstr "conj"
      | 1 => prstr "disj"
      | _ => fprint_int (out, knd)
    ) : void // end of [val]
    val () = prstr ";"
    val () = prstr "\n"
    val () = fprint_icnstrlst (out, !p_ics, n)
    val () = prstr ")"
  in
    fold@ (ic)
  end // end of [ICveclst]
//
  | ICerr _ => let
      val () = prstr "ICerr("
      val () = fprint_string (out, "...")
      val () = prstr ")"
    in
      fold@ (ic)
    end // end of [ICerr]
//
end // end of [fprint_icnstr]

implement{a}
print_icnstr
  (x, n) = fprint_icnstr<a> (stdout_ref, x, n)
// end of [print_icnstr]

(* ****** ****** *)

implement{a}
fprint_icnstrlst
  (out, ics, n) = (
  case+ ics of
  | list_vt_cons
      (!p_ic, !p_ics) => let
      val () = fprint_icnstr<a> (out, !p_ic, n)
      val () = fprint_newline (out)
      val () = fprint_icnstrlst<a> (out, !p_ics, n)
    in
      fold@ (ics)
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ ics
) // end of [fprint_icnstrlst]

implement{a}
print_icnstrlst
  (xs, n) = fprint_icnstrlst<a> (stdout_ref, xs, n)
// end of [print_icnstrlst]

(* ****** ****** *)

(* end of [pats_lintprgm_print.dats] *)
