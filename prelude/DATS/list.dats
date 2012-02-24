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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(*
staload "fiterator.sats"
staload "fcontainer.sats"
*)

(* ****** ****** *)

implement{x}
list_copy (xs) = let
  viewtypedef res = List_vt (x)
  fun loop {n:nat} .<n>. (
    xs: list (x, n), res: &res? >> list_vt (x, n)
  ) :<> void = case+ xs of
    | list_cons (x, xs) => let
        val () = res := list_vt_cons {x}{0} (x, ?)
        val+ list_vt_cons (_, !p_tl) = res; val () = loop (xs, !p_tl)
      in
        fold@ (res)
      end // end of [cons]
    | list_nil () => res := list_vt_nil ()
  // end of [loop]
  var res: res // uninitialized
  val () = loop (xs, res)
in
  res (*linear list*)
end // end of [list_copy]

(* ****** ****** *)

implement{x}
list_reverse (xs) = list_append2_vt (xs, list_vt_nil)

(* ****** ****** *)

implement{x}
list_foreach_funenv
  {v}{vt}{fe}
  (pfv | xs, f, env) = let
//
fun loop {n:nat} .<n>. (
  pfv: !v
| xs: list (x, n), f: (!v | x, !vt) -<fun,fe> void, env: !vt
) :<fe> void =
  case+ xs of
  | list_cons (x, xs) => let
      val () = f (pfv | x, env) in loop (pfv | xs, f, env)
    end // end of [list_cons]
  | list_nil () => ()
// end of [loop]
in
  loop (pfv | xs, f, env)
end // end of [list_foreach_funenv]

(* ****** ****** *)

implement{x}{y}
list_map_funenv
  {v}{vt}{n}{fe}
  (pfv | xs, f, env) = ys where {
  typedef xs = List (x)
  val [n2:int] ys = listize_funenv<xs><x> (pfv | xs, f, env)
  prval () = __assert () where {
    extern praxi __assert (): [n==n2] void
  } (* end of [prval] *)
} // end of [list_map_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [list.dats] *)
