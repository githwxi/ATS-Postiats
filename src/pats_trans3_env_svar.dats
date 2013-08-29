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

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

local

assume s2varbindmap_push_v = unit_v

val the_s2varbindmap =
  ref_make_elt<s2varbindmap> (s2varbindmap_make_nil ())
// end of [val]

viewtypedef s2varlstlst_vt = List_vt (s2varlst_vt)
val the_s2varlst = ref_make_elt<s2varlst_vt> (list_vt_nil)
val the_s2varlstlst = ref_make_elt<s2varlstlst_vt> (list_vt_nil)

fun auxrmv (
  map: &s2varbindmap, s2vs: s2varlst_vt
) : void =
  case+ s2vs of
  | ~list_vt_cons (s2v, s2vs) => let
      val () = s2varbindmap_remove (map, s2v) in auxrmv (map, s2vs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
// end of [auxrmv]

in // in of [local]

implement
the_s2varbindmap_pop
  (pf | (*nothing*)) = let
//
prval unit_v () = pf
val s2vs = let
  val (vbox pf | pp) = ref_get_view_ptr (the_s2varlstlst)
in
  case+ !pp of
  | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
  | list_vt_nil () => let prval () = fold@ (!pp) in list_vt_nil end
end : s2varlst_vt
val s2vs = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
  val xs = !p
  val () = !p := s2vs
} // end of [val]
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (auxrmv (!p, s2vs))
end // end of [val]
//
in
  // nothing
end // end of [the_s2varbindmap_pop]

implement
the_s2varbindmap_push () = let
  val s2vs = s2vs where {
    val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
    val s2vs = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val (vbox pf | pp) = ref_get_view_ptr (the_s2varlstlst)
  val () = !pp := list_vt_cons (s2vs, !pp)
in
  (unit_v () | ())
end // end of [the_s2varbindmap_push]

implement
fprint_the_s2varbindmap (out) = let
  fun aux (
    out: FILEref, kis: List_vt @(s2var, s2exp)
  ) : void =
    case+ kis of
    | ~list_vt_cons (ki, kis) => let
        val () = fprint_s2var (out, ki.0)
        val () = fprint_string (out, " -> ")
        val () = fprint_s2exp (out, ki.1)
        val () = fprint_newline (out)
      in
        aux (out, kis)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [aux]
  val kis = let
    val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
  in
    $effmask_ref (s2varbindmap_listize (!p))
  end // end of [val]
in
  aux (out, kis)
end // end of [fprint_the_s2varbindmap]

implement
the_s2varbindmap_search (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (s2varbindmap_search (!p, s2v))
end // end of [the_s2varbindmap_search]

implement
the_s2varbindmap_insert (s2v, s2f) = let
//
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
in
  !p := list_vt_cons (s2v, !p)
end // end of [val]
//
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (s2varbindmap_insert (!p, s2v, s2f))
end // end of [val]
//
in
  (* nothing *)
end // end of [the_s2varbindmap_insert]

implement
the_s2varbindmap_freetop () = let
//
val s2vs = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [val]
//
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (auxrmv (!p, s2vs))
end // end of [val]
//
in
  (*nothing*)
end // end of [the_s2varbinmap_freetop]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_svar.dats] *)
