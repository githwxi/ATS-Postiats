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
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_symmap.sats"
staload "./pats_symenv.sats"

(* ****** ****** *)

vtypedef
symmaplst (
  itm:type, n:int
) = list_vt (symmap itm, n)
vtypedef
symmaplst (itm:type) = [n:nat] symmaplst (itm, n)

(* ****** ****** *)

fun
symmaplst_free
  {itm:type}
  {n:nat} .<n>.
  (xs: symmaplst (itm, n)):<> void =
  case+ xs of
  | ~list_vt_cons (x, xs) => (symmap_free (x); symmaplst_free (xs))
  | ~list_vt_nil () => ()
// end of [symmaplst_free]

fun
symmaplst_search
  {itm:type} {n:nat} .<n>. (
  ms0: !symmaplst (itm, n), k: symbol
) :<> Option_vt itm = begin case+ ms0 of
  | list_vt_cons
      (!p_m, !p_ms) => let
      val ans = symmap_search (!p_m, k)
    in
      case+ ans of
      | Some_vt _ => ans where {
          val () = fold@ ms0; val () = fold@ ans
        } // end of [Some_vt]
      | ~None_vt () => ans where {
          val ans = symmaplst_search {itm} (!p_ms, k)
          val () = fold@ ms0
        } // end of [None_vt]
    end (* end of [list_vt_cons] *)
  | list_vt_nil () => (fold@ ms0; None_vt ())
end // end of [symmaplst_search]

(* ****** ****** *)

assume
symenv_vt0ype
  (itm:type) = @{
  map= symmap (itm)
, maplst= symmaplst (itm)
, savedlst= List_vt @(symmap itm, symmaplst itm)
, pervasive= symmap (itm)
} // end of [symenv_v0type]

(* ****** ****** *)

implement
symenv_make_nil
  {itm} () = let
  stadef T = symenv (itm)
  val (pfgc, pfat | p) = ptr_alloc<T> ()
  val () = p->map := symmap_make_nil ()
  val () = p->maplst := list_vt_nil ()
  val () = p->savedlst := list_vt_nil ()
  val () = p->pervasive := symmap_make_nil ()
  prval () = free_gc_elim (pfgc)
in
  (pfat | p)
end // end of [symenv_make_nil]

(* ****** ****** *)

implement
symenv_search
  {itm} (env, k) = let
  val ans = symmap_search (env.map, k)
in
  case+ ans of
  | Some_vt _ => (fold@ (ans); ans)
  | ~None_vt () => symmaplst_search (env.maplst, k)
end // end of [symenv_search]

(* ****** ****** *)

implement
symenv_insert {itm}
  (env, k, i) = symmap_insert {itm} (env.map, k, i)
// end of [symenv_insert]

(* ****** ****** *)

implement
symenv_pop
  (env) = map0 where {
  val map0 = env.map
  val-~list_vt_cons (map, maps) = env.maplst
  val () = env.map := map
  val () = env.maplst := maps
} // end of [symenv_pop]

implement
symenv_pop_free
  (env) = () where {
  val map = symenv_pop (env)
  val () = symmap_free (map)
} // end of [symmap_pop_free]

implement
symenv_push
  (env, map0) = () where {
  val () = env.maplst := list_vt_cons (env.map, env.maplst)
  val () = env.map := map0
} // end of [symenv_push]

implement
symenv_push_nil
  (env) = () where {
  val map = symmap_make_nil ()
  val () = symenv_push (env, map)
} // end of [symmap_push_nil]

(* ****** ****** *)

implement
symenv_top_clear
  (env) = () where {
//
val () = symmap_free (env.map)
val () = env.map := symmap_make_nil ()
//
} (* end of [symenv_top_clear] *)

(* ****** ****** *)

implement
symenv_savecur
  {itm}(env) = let
  val m = env.map
  val () = env.map := symmap_make_nil ()
  val ms = env.maplst
  val () = env.maplst := list_vt_nil ()
  val () = env.savedlst := list_vt_cons ((m, ms), env.savedlst)
in
  // nothing
end // end of [symenv_savecur]

implement
symenv_restore
  {itm}(env) = let
  vtypedef map = symmap (itm)
  val top = env.map
  val () = symmaplst_free (env.maplst)
  val-~list_vt_cons (x, xs) = env.savedlst
  val () = env.savedlst := xs
  val () = env.map := x.0 and () = env.maplst := x.1
in
  top
end // end of [symenv_restore]

(* ****** ****** *)

implement
symenv_localjoin
  {itm}(env) = let
//
val ms = env.maplst
val-~list_vt_cons (m1, ms) = ms
val () = symmap_free (m1)
val-~list_vt_cons (m2, ms) = ms
val () = env.maplst := ms
//
// HX-2013-06:
// it is done in this way so that a binding
// in [map1] can replace another one in [map2]
// if they happen to be sharing the same key.
//
val m0 = env.map
val () = env.map := m2
val res = symmap_joinwth {itm} (env.map, m0)
val () = symmap_free (m0)
//
in
  res
end // end of [symenv_localjoin]

(* ****** ****** *)

implement
symenv_pervasive_search
  (env, k) =
  symmap_search (env.pervasive, k)
// end of [symenv_pervasive_search]

implement
symenv_pervasive_insert
  (env, k, i) =
  symmap_insert (env.pervasive, k, i)
// end of [symenv_insert]

(* ****** ****** *)

implement
symenv_pervasive_joinwth0
  (env, map) = let
//
val () = symmap_joinwth (env.pervasive, map)
//
in
  symmap_free (map)
end // end of [symenv_pervasive_joinwth0]

implement
symenv_pervasive_joinwth1
  (env, map) = symmap_joinwth (env.pervasive, map)
// end of [symenv_pervasive_joinwth1]

(* ****** ****** *)

implement
fprint_symenv_map
  (out, env, f) = fprint_symmap (out, env.map, f)
// end of [fprint_symenv_map]

(* ****** ****** *)

(* end of [pats_symenv.dats] *)
