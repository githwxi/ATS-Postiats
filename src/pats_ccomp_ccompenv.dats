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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

dataviewtype
d2varmarklst_vt =
  | DVMLSTnil of ()
  | DVMLSTmark of (d2varmarklst_vt)
  | DVMLSTcons of (d2var, d2varmarklst_vt)
// end of [d2varmarklst]

(* ****** ****** *)

extern
fun d2varmarklst_vt_free_all (xs: d2varmarklst_vt): void
implement
d2varmarklst_vt_free_all (xs) = let
in
  case+ xs of
  | ~DVMLSTnil () => ()
  | ~DVMLSTmark (xs) => d2varmarklst_vt_free_all (xs)
  | ~DVMLSTcons (_, xs) => d2varmarklst_vt_free_all (xs)
end // end of [d2varmarklst_vt_free_all]

extern
fun d2varmarklst_vt_free_mark (xs: d2varmarklst_vt): d2varmarklst_vt
implement
d2varmarklst_vt_free_mark (xs) = let
in
  case+ xs of
  | DVMLSTnil () => let
      prval () = fold@ (xs) in xs
    end // end of [DVMLSTnil]
  | ~DVMLSTmark (xs) => xs
  | ~DVMLSTcons (_, xs) => d2varmarklst_vt_free_mark (xs)
end // end of [d2varmarklst_vt_free_mark]

(* ****** ****** *)

extern
fun fprint_dvmlst
  (out: FILEref, xs: !d2varmarklst_vt): void
// end of [fprint_dvmlst]

implement
fprint_dvmlst
  (out, xs) = let
//
fun loop (
  out: FILEref, xs: !d2varmarklst_vt, i: int
) : void = let
in
//
case+ xs of
| DVMLSTnil () => fold@ (xs)
| DVMLSTmark (!p_xs) => let
    val () =
      if i > 0 then fprint_string (out, ", ")
    val () = fprint_string (out, "||")
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [DVMLSTmark]
| DVMLSTcons
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then fprint_string (out, ", ")
    // end of [val]
    val () = fprint_d2var (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [DVMLSTcons]
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_dvmlst]

(* ****** ****** *)

viewtypedef
ccompenv_struct = @{
  ccompenv_dvmlst = d2varmarklst_vt
}

(* ****** ****** *)

extern
fun ccompenv_struct_uninitize
  (x: &ccompenv_struct >> ccompenv_struct?): void
// end of [ccompenv_struct_uninitize]

implement
ccompenv_struct_uninitize (x) = let
  val () = d2varmarklst_vt_free_all (x.ccompenv_dvmlst)
in
  // end of [ccompenv_struct_uninitize]
end // end of [ccompenv_struct_uninitize]

(* ****** ****** *)

dataviewtype
ccompenv = CCOMPENV of ccompenv_struct

(* ****** ****** *)

assume ccompenv_vtype = ccompenv

(* ****** ****** *)

implement
ccompenv_make
  () = env where {
  val env = CCOMPENV (?)
  val CCOMPENV (!p) = env
  val () = p->ccompenv_dvmlst := DVMLSTnil ()
  val () = fold@ (env)
} // end of [ccompenv_make]

(* ****** ****** *)

implement
ccompenv_free (env) = let
in
//
case+ env of
| CCOMPENV (!p_env) => let
    val () = ccompenv_struct_uninitize (!p_env)
  in
    free@ (env)
  end // end of [CCOMPENV]
//
end // end of [ccompenv_free]

(* ****** ****** *)

local

assume ccompenv_push_v = unit_v

in // in of [local]

implement
ccompenv_pop
  (pfpush | env) = let
//
  prval unit_v () = pfpush
//
  val CCOMPENV (!p) = env
  val dvms = p->ccompenv_dvmlst
  val () = p->ccompenv_dvmlst := d2varmarklst_vt_free_mark (dvms)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_pop]

implement
ccompenv_push (env) = let
//
  val CCOMPENV (!p) = env
//
  val () = p->ccompenv_dvmlst := DVMLSTmark (p->ccompenv_dvmlst)
//
  prval () = fold@ (env)
//
in
  (unit_v | ())
end // end of [ccompenv_push]

end // end of [local]

(* ****** ****** *)

implement
ccompenv_add_dvar
  (env, d2v) = let
//
  val CCOMPENV (!p) = env
  val dvms = p->ccompenv_dvmlst
  val () = p->ccompenv_dvmlst := DVMLSTcons (d2v, dvms)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_dvar]

(* ****** ****** *)

(* end of [pats_ccomp_ccompenv.dats] *)
