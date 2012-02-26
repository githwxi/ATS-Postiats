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

implement(x)
listize<List(x)><x> (xs) = list_copy (xs)

(* ****** ****** *)

implement{x}
list_reverse (xs) = list_append2_vt (xs, list_vt_nil)

implement(x)
rlistize<List(x)><x> (xs) = list_reverse (xs)

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

implement(x)
foreach_funenv<List(x)><x>
  (pfv | xs, f, env) = list_foreach_funenv (pfv | xs, f, env)
// end of [foreach_funenv]

(* ****** ****** *)

implement{x}
list_iforeach_funenv
  {v}{vt}{fe}
  (pfv | xs, f, env) = let
//
fun loop {n:nat} .<n>. (
  pfv: !v
| xs: list (x, n)
, f: (!v | natLt(n), x, !vt) -<fun,fe> void
, env: !vt, i: int
) :<fe> void =
  case+ xs of
  | list_cons (x, xs) => let
      val () = f (pfv | i, x, env) in loop (pfv | xs, f, env, i+1)
    end // end of [list_cons]
  | list_nil () => i(*size(xs*)
// end of [loop]
in
  loop (pfv | xs, f, env, 0)
end // end of [list_iforeach_funenv]

implement(x)
iforeach_funenv<List(x)><a>
  (pfv | xs, f, env) = list_iforeach_funenv (pfv | xs, f, env)
// end of [iforeach_funenv]

(* ****** ****** *)

implement{x}
list_copy {n} (xs) = let
  viewtypedef res = List_vt (x)
  fun loop {n:nat} .<n>. (
    xs: list (x, n), res: &res? >> list_vt (x, n)
  ) :<> void =
    case+ xs of
    | list_cons
        (x, xs) => let
        val () =
          res := list_vt_cons {x}{0} (x, ?)
        val+ list_vt_cons (_, !p_res) = res
        val () = loop (xs, !p_res)
        prval () = fold@ (res)
      in
        (*nothing*)
      end // end of [list_vt_cons]
    | list_nil () => res := list_vt_nil
  // end of [loop]
  var res: res // uninitialized
  val () = loop (xs, res)
in
  res(*list_vt(x,n)*)
end // end of [list_copy]

(* ****** ****** *)

implement{x}{y}
list_map_funenv
  {v}{vt}{n}{fe}
  (pfv | xs, f, env) = let
  viewtypedef ys = List_vt (y)
  fun loop {n:nat} .<n>. (
    pfv: !v
  | xs: list (x, n)
  , f: (!v | x, !vt) -<fun,fe> y
  , env: !vt
  , res: &ys? >> list_vt (y, n)
  ) :<fe> void =
    case+ xs of
    | list_cons
        (x, xs) => let
        val y = f (pfv | x, env)
        val () = res := list_vt_cons {y}{0} (y, ?)
        val+ list_vt_cons (_, !p_res) = res
        val () = loop (pfv | xs, f, env, !p_res)
        prval () = fold@ (res)
      in
        (*nothing*)
      end // end of [list_vt_cons]
    | list_nil () => res := list_vt_nil
  // end of [loop]
  var res: ys // uninitialized
  val () = loop (pfv | xs, f, env, res)
in
  res(*list_vt(y,n)*)
end // end of [list_map_funenv]

implement(x,y)
listize_funenv<List(x)><x><y>
  (pfv | xs, f, env) = list_map_funenv (pfv | xs, f, env)
// end of [listize_funenv]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [list.dats] *)
