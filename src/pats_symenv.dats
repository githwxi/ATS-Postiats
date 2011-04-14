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

staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload "pats_symmap.sats"
staload "pats_symenv.sats"

(* ****** ****** *)

viewtypedef
symmaplst (
  itm:type, n:int
) = list_vt (symmap itm, n)
viewtypedef
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
, pervasive= symmaplst (itm)
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
  val () = p->pervasive := list_vt_nil ()
  prval () = free_gc_elim (pfgc)
in
  (pfat | p)
end // end of [symenv_make_null]

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
symenv_savecur
  {itm} (env) = let
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
  {itm} (env) = let
  viewtypedef map = symmap (itm)
  val () = symmap_free (env.map)  
  val () = symmaplst_free (env.maplst)
  val- ~list_vt_cons (x, xs) = env.savedlst
  val () = env.savedlst := xs
  val () = env.map := x.0 and () = env.maplst := x.1
in
  // nothing
end // end of [symenv_restore]

(* ****** ****** *)

implement
symenv_localjoin
  {itm} (env) = let
  val ms = env.maplst
  val- ~list_vt_cons (m1, ms) = ms
  val () = symmap_free (m1)
  val- ~list_vt_cons (m2, ms) = ms
  val () = env.maplst := ms
in
  symmap_joinwth {itm} (env.map, m2)
end // end of [symenv_localjoin]

(* ****** ****** *)

implement
symenv_pervasive_search
  {itm} (env, k) = symmaplst_search (env.pervasive, k)
// end of [symenv_pervasive_search]

(* ****** ****** *)

implement
fprint_symenv_map
  (out, env, f) = fprint_symmap (out, env.map, f)
// end of [fprint_symenv_map]

(* ****** ****** *)

(* end of [pats_symenv.dats] *)
