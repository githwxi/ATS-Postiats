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
#print "Loading [list_vt.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

implement{a}
compare_elt_elt
  (x1, x2, cmp, env) = cmp (x1, x2, env)
// end of [compare_elt_elt]

(* ****** ****** *)

implement{a}
list_vt_reverse (xs) =
  list_vt_reverse_append (xs, list_vt_nil)
// end of [list_vt_reverse]

(* ****** ****** *)

implement{a}
list_vt_reverse_append
  (xs, ys) = let
//
fun loop
  {m,n:nat} .<m>. (
  xs: list_vt (a, m), ys: list_vt (a, n)
) :<> list_vt (a, m+n) =
  case xs of
  | list_vt_cons
      (_, !p_tl) => let
      val xs1 = !p_tl
      val () = !p_tl := ys
      prval () = fold@ (xs)
    in
      loop (xs1, xs)
    end
  | ~list_vt_nil () => ys
// end of [loop]
in
  loop (xs, ys)
end // end of [list_vt_reverse_append]

(* ****** ****** *)

implement{a}
list_vt_foreach_funenv
  {v}{vt}{n}{fe}
  (pf | xs, f, env) = let
  fun loop
    {n:nat} .<n>. (
    pf: !v
  | xs: !list_vt (a, n)
  , f: (!v | &a, !vt) -<fe> void
  , env: !vt
  ) :<fe> void =
    case+ xs of
    | list_vt_cons
        (!p1_x, !p2_xs) => let
        val () = f (pf | !p1_x, env)
        val () = loop (pf | !p2_xs, f, env)
      in
        fold@ (xs)
      end // end of [list_vt_cons]
    | list_vt_nil () => fold@ (xs)
  // end of [loop]
in
  loop (pf | xs, f, env)
end // end of [list_vt_foreach_funenv]

(* ****** ****** *)

implement{a}
list_vt_mergesort
  {n} (xs, cmp) = let
  var env: ptr = null
  val cmp = __cast (cmp) where {
    extern castfn __cast (cmp: cmp (a)): cmp (a, ptr)
  } // end of [val]
in
  list_vt_mergesort_env (xs, cmp, env)
end // end of [list_vt_mergesort]

implement{a}
list_vt_mergesort_env
  {vt}{n} (xs, cmp, env) = let
//
fun split {n,n1:nat | n >= n1} .<n1>. (
    xs: &list_vt (a, n) >> list_vt (a, n1)
  , n1: int n1, res: &List_vt a? >> list_vt (a, n-n1)
  ) :<> void =
  if n1 > 0 then let
    val+ list_vt_cons (_, !p_xs1) = xs
    val () = split (!p_xs1, n1-1, res)
  in
    fold@ (xs)
  end else let
    val () = res := xs
    val () = xs := list_vt_nil ()
  in
    // nothing
  end // end of [if]
// end of [split]
fun merge {n1,n2:nat} .<n1+n2>. (
    xs1: list_vt (a, n1)
  , xs2: list_vt (a, n2)
  , cmp: cmp (a, vt), env: !vt
  , res: &List_vt a? >> list_vt (a, n1+n2)
  ) :<> void =
  case+ xs1 of
  | list_vt_cons (!p_x1, !p_xs11) => (
    case+ xs2 of
    | list_vt_cons (!p_x2, !p_xs21) => let
        val sgn = compare_elt_elt (!p_x1, !p_x2, cmp, env)
      in
        if sgn <= 0 then let
          prval () = fold@ {a} (xs2)
          val () = merge (!p_xs11, xs2, cmp, env, !p_xs11)
          prval () = fold@ {a} (xs1)
        in
          res := xs1
        end else let
          prval () = fold@ {a} (xs1)
          val () = merge (xs1, !p_xs21, cmp, env, !p_xs21)
          prval () = fold@ {a} (xs2)
        in
          res := xs2
        end // end of [if]
      end // end of [list_vt_cons]
    | ~list_vt_nil () => (fold@ (xs1); res := xs1)
    ) // end of [list_vt_cons]
  | ~list_vt_nil () => (res := xs2)
// end of [merge]
//
val n = list_vt_length<a> (xs)
//
in
//
if n >= 2 then let
  val+ list_vt_cons (_, !p_xs1) = xs
  var res: List_vt a? // uninitialized
  val () = split (!p_xs1, (n-1)/2, res)
  prval () = fold@ (xs)
  val xs1 = list_vt_mergesort_env<a> (xs, cmp, env)
  val xs2 = list_vt_mergesort_env<a> (res, cmp, env)
  val () = merge (xs1, xs2, cmp, env, res)
in
  res
end else xs // end of [if]
//
end // end of [list_vt_mergesort_env]

(* ****** ****** *)

implement{a}
list_vt_quicksort
  {n} (xs, cmp) = let
  var env: ptr = null
  val cmp = __cast (cmp) where {
    extern castfn __cast (cmp: cmp (a)): cmp (a, ptr)
  } // end of [val]
in
  list_vt_quicksort_env (xs, cmp, env)
end // end of [list_vt_quicksort]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [list_vt.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [list_vt.dats] *)
