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

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_trans1_env.sats"

(* ****** ****** *)

local

viewtypedef e1xpenv = symenv (e1xp)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {e1xpenv} (pf | p0)

assume e1xpenv_push_v = unit_v // HX: it is just a dummy

in // in of [local]

implement
the_e1xpenv_add
  (k, i) = () where {
  prval vbox pf = pf0
  val () = symenv_insert (!p0, k, i)
} // end of [the_e1xpenv_add]

implement
the_e1xpenv_addperv
  (k, i) = () where {
  prval vbox pf = pf0
  val () = symenv_pervasive_insert (!p0, k, i)
} // end of [the_e1xpenv_addperv]

implement
the_e1xpenv_find (k) = let
  prval vbox pf = pf0
  val ans = symenv_search (!p0, k)
in
  case+ ans of
  | Some_vt _ => (fold@ ans; ans)
  | ~None_vt () => symenv_pervasive_search (!p0, k)
end // end of [the_e1xpenv_find]

implement
the_e1xpenv_pop
  (pfenv | (*none*)) = map where {
  prval unit_v () = pfenv
  prval vbox pf = pf0
  val map = symenv_pop (!p0)
} // end of [the_e1xpenv_pop_free]

implement
the_e1xpenv_push_nil
  () = (pfenv | ()) where {
  prval vbox pf = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_e1xpenv_push_nil]

fun the_e1xpenv_localjoin (
  pfenv1: e1xpenv_push_v
, pfenv2: e1xpenv_push_v
| (*none*)
) = () where {
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  prval vbox pf = pf0
  val () = symenv_localjoin (!p0)
} // end of [the_e1xpenv_localjoin]

end // end of [local]

(* ****** ****** *)

local

viewtypedef fxtyenv = symenv (fxty)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {fxtyenv} (pf | p0)

assume fxtyenv_push_v = unit_v // HX: it is just a dummy

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

implement
the_fxtyenv_pop
  (pfenv | (*none*)) = map where {
  prval unit_v () = pfenv
  prval vbox pf = pf0
  val map = symenv_pop (!p0)
} // end of [the_fxtyenv_pop_free]

implement
the_fxtyenv_push_nil
  () = (pfenv | ()) where {
  prval vbox pf = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_fxtyenv_push_nil]

fun the_fxtyenv_localjoin (
  pfenv1: fxtyenv_push_v
, pfenv2: fxtyenv_push_v
| (*none*)
) = () where {
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  prval vbox pf = pf0
  val () = symenv_localjoin (!p0)
} // end of [the_fxtyenv_localjoin]

implement
the_fxtyenv_pervasive_joinwth (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth (!p0, map)
end // end of [fun]

end // end of [local]

(* ****** ****** *)

local

var the_level: int = 0
val p_the_level = &the_level
val (pf_the_level | ()) =
  vbox_make_view_ptr {int} (view@ the_level | p_the_level)
// end of [val]

assume trans1_level_v = unit_v // HX: it is just a dummy

in // in of [local]

implement
trans1_level_get () = let
  prval vbox pf = pf_the_level in !p_the_level
end // end of [trans1_level_get]

implement
trans1_level_inc () = let
  prval pflev = unit_v ()
  prval vbox pf = pf_the_level
  val () = !p_the_level := !p_the_level + 1
in
  (pflev | ())
end // end of [trans1_level_inc]

implement
trans1_level_dec
  (pflev | (*none*)) = () where {
  prval unit_v () = pflev
  prval vbox pf = pf_the_level
  val () = !p_the_level := !p_the_level - 1
} // end of [trans1_level_dec]

end // end of [local]

(* ****** ****** *)

local

assume
trans1_env_push_v = (e1xpenv_push_v, fxtyenv_push_v)

in // in of [local]

implement
trans1_env_pop
  (pfenv | (*none*)) = () where {
  prval (pf1env, pf2env) = pfenv
  val map = the_e1xpenv_pop (pf1env | (*none*))
  val () = symmap_free (map)
  val map = the_fxtyenv_pop (pf2env | (*none*))
  val () = symmap_free (map)
} // end of [trans1_env_pop]

implement
trans1_env_push
  () = (pfenv | ()) where {
  val (pf1env | ()) = the_e1xpenv_push_nil ()
  val (pf2env | ()) = the_fxtyenv_push_nil ()
  prval pfenv = (pf1env, pf2env)
} // end of [trans1_env_pop]

implement
trans1_env_localjoin
  (pfenv1, pfenv2 | (*none*)) = () where {
  prval (pf1env1, pf2env1) = pfenv1
  prval (pf1env2, pf2env2) = pfenv2
  val () = the_e1xpenv_localjoin (pf1env1, pf1env2 | (*none*))
  val () = the_fxtyenv_localjoin (pf2env1, pf2env2 | (*none*))
} // end of [trans1_env_localjoin]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans1_env.dats] *)
