(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: April, 2011
//
(* ****** ****** *)

staload FIX = "pats_fixity.sats"

(* ****** ****** *)

staload "pats_symmap.sats"
staload "pats_symenv.sats"
staload "pats_trans1_env.sats"

(* ****** ****** *)

local

viewtypedef fxtyenv = symenv (fxty)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {fxtyenv} (pf | p0)

in // in of [local]

implement
the_fxtyenv_add
  (k, i) = () where {
  prval vbox pf = pf0
  val () = symenv_insert (!p0, k, i)
} // end of [the_fxtyenv_add]

implement
the_fxtyenv_find (k) = let
  prval vbox pf = pf0
  val ans = symenv_search (!p0, k)
in
  case+ ans of
  | Some_vt _ => (fold@ ans; ans)
  | ~None_vt () => symenv_pervasive_search (!p0, k)
end // end of [the_fxtyenv_find]

implement
fprint_the_fxtyenv (out) = let
  prval vbox (pf) = pf0 in // HX: ref-effect is not allowed
  $effmask_ref (fprint_symenv_map (out, !p0, $FIX.fprint_fxty))
end // end of [fprint_the_fxtyenv]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans1_env.dats] *)


