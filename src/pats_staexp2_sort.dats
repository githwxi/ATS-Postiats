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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

abstype s2rtnul (l:addr)
typedef s2rtnul = [l:agez] s2rtnul (l)

(* ****** ****** *)

extern
castfn s2rtnul_none (x: ptr null): s2rtnul (null)

extern
castfn s2rtnul_some (x: s2rt): [l:agz] s2rtnul (l)
extern
castfn s2rtnul_unsome {l:agz} (x: s2rtnul l): s2rt

extern
fun s2rtnul_is_null {l:addr}
  (x: s2rtnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [s2rtnul_is_null]
extern
fun s2rtnul_isnot_null {l:addr}
  (x: s2rtnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [s2rtnul_isnot_null]

(* ****** ****** *)

local

assume s2rtVar = ref (s2rtnul)

in // in of [local]

implement
eq_s2rtVar_s2rtVar
  (x1, x2) = (p1 = p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [eq_s2rtVar_s2rtVar]

implement
compare_s2rtVar_s2rtVar
  (x1, x2) = compare_ptr_ptr (p1, p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [compare_s2rtVar_s2rtVar]

implement
s2rtVar_make (loc) = let
  val nul = s2rtnul_none (null) in ref_make_elt (nul)
end // end of [s2rtVar_make]

implement
s2rt_whnf (s2t0) = let
  fun aux (s2t0: s2rt): s2rt =
    case+ s2t0 of
    | S2RTVar r => let
        val s2t = !r
        val test = s2rtnul_isnot_null (s2t)
      in
        if test then let
          val s2t = s2rtnul_unsome (s2t)
          val s2t = aux (s2t)
          val () = !r := s2rtnul_some (s2t)
        in
          s2t
        end else s2t0
      end (* S2RTVar *)
    | _ => s2t0 // end of [_]
  // end of [aux]
in
  aux (s2t0)
end // end of [s2rt_whnf]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_sort.dats] *)
