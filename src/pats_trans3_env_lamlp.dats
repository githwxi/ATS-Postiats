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

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env_lamlp"

(* ****** ****** *)

staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)
//
// HX:
// [LMLPloop0]: for the first round typechecking
// [LMLPloop1]: for the second round typechekcing
//
// HX: the break/continue statements are skipped during the first round.
//
datatype lamlp =
  | LAMLPlam of p3atlst (* function arguments *)
  | LAMLPloop0 of ()
  | LAMLPloop1 of ()
// end of [lamlp]

viewtypedef lamlplst_vt = List_vt (lamlp)

(* ****** ****** *)

local

assume
lamlpenv_push_v = unit_v

val the_lamlplst = ref<lamlplst_vt> (list_vt_nil)

in // in of [local]

implement
the_lamlpenv_get_funarg () = let
//
  fun loop (
    xs: !lamlplst_vt
  ) : Option_vt (p3atlst) =
    case+ xs of
    | list_vt_cons (x, !p_xs) => (
      case+ x of
      | LAMLPlam (p3ts) =>
          (fold@ (xs); Some_vt (p3ts))
      | LAMLPloop0 _ => let
          val res = loop (!p_xs) in fold@ (xs); res
        end // end of [LAMLPloop0]
      | LAMLPloop1 _ => let
          val res = loop (!p_xs) in fold@ (xs); res
        end // end of [LAMLPloop1]
      ) // end of [list_vt_cons]
    | list_vt_nil () => (fold@ (xs); None_vt ())
//
  val (vbox pf | pp) = ref_get_view_ptr (the_lamlplst)
//
in
  $effmask_ref (loop (!pp))
end // end of [the_lamlpenv_get_funarg]

implement
the_lamlpenv_pop
  (pfpush | (*none*)) = let
  prval () = unit_v_elim (pfpush)
  val (vbox pf | pp) =
    ref_get_view_ptr (the_lamlplst)
  val- ~list_vt_cons (_, xs) = !pp in !pp := xs
end // end of [the_lamlpenv_push_pop]

implement
the_lamlpenv_push_lam (p3ts) = let
  val (vbox pf | pp) = ref_get_view_ptr (the_lamlplst)
  val () = !pp := list_vt_cons (LAMLPlam (p3ts), !pp)
  prval pfpush = unit_v ()
in
  (pfpush | ())
end // end of [the_lamlpenv_push_lam]

implement
the_lamlpenv_push_loop0 () = let
  val (vbox pf | pp) = ref_get_view_ptr (the_lamlplst)
  val () = !pp := list_vt_cons (LAMLPloop0 (), !pp)
  prval pfpush = unit_v ()
in
  (pfpush | ())
end // end of [the_lamlpenv_push_loop0]

implement
the_lamlpenv_push_loop1 () = let
  val (vbox pf | pp) = ref_get_view_ptr (the_lamlplst)
  val () = !pp := list_vt_cons (LAMLPloop1 (), !pp)
  prval pfpush = unit_v ()
in
  (pfpush | ())
end // end of [the_lamlpenv_push_loop1]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_lamlp.dats] *)
