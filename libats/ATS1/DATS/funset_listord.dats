(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
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

(*
**
** A functional map implementation based on ordered lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May 18, 2011
**
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)

staload "libats/ATS1/SATS/funset_listord.sats"

(* ****** ****** *)
//
implement{a}
compare_elt_elt (x1, x2, cmp) = cmp (x1, x2)
//
(* ****** ****** *)

assume
set_t0ype_type (a:t0p) = List0 (a)

(* ****** ****** *)
//
// HX:
// a set is represented as a sorted list in descending order;
// note that descending order is chosen to faciliate set comparison
//
(* ****** ****** *)

implement{}
funset_make_nil () = list_nil ()

(* ****** ****** *)

implement{a}
funset_make_sing (x) = list_cons{a}(x, list_nil)

(* ****** ****** *)

implement{a}
funset_make_list
  (xs, cmp) = let
//
fun loop1
  {m:pos} .<m,0>.
(
  xs: list_vt (a, m)
, ys: List0_vt (a), cmp: cmp a
) :<!wrt> List0_vt (a) = let
  val-@list_vt_cons (x, xs1) = xs
  val x_ = x and xs1_ = xs1
  val ((*void*)) = xs1 := ys
  prval ((*void*)) = fold@ (xs)
in
  loop2 (x_, xs1_, xs, cmp)
end // end of [loop1]
//
and loop2
  {n:nat} .<n,1>.
(
  x0: a
, xs: list_vt (a, n)
, ys: List0_vt (a), cmp: cmp a
) :<!wrt> List0_vt (a) = let
in
//
case+ xs of
| @list_vt_cons
    (x, xs1) => let
    val sgn =
      compare_elt_elt<a> (x0, x, cmp)
    // end of [val]
  in
    if sgn < 0 then let // HX: [xs] is ascending!
      prval () = fold@ (xs) in loop1 (xs, ys, cmp)
    end else let
      val xs1_ = xs1
      val () = free@{a}{0}(xs) in loop2 (x0, xs1_, ys, cmp)
    end // end of [if]
  end (* end of [list_vt_cons] *)
| ~list_vt_nil ((*void*)) => ys
//
end (* end of [loop2] *)
//
local
implement
list_mergesort$cmp<a>
  (x1, x2) = compare_elt_elt<a> (x1, x2, cmp)
in(*in-of-local*)
val xs2 = list_mergesort<a> (xs) // [xs2] is ascending!
end // end of [local]
//
in
//
case+ xs2 of
| list_vt_cons _ => let
    val ys = loop1 (xs2, list_vt_nil, cmp)
  in
    list_vt2t (ys)
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_nil ()
//
end // end of [funset_make_list]

(* ****** ****** *)

implement{a}
funset_size (xs) = i2sz(list_length(xs))

(* ****** ****** *)

implement{a}
funset_is_member
  (xs, x0, cmp) = let
//
fun loop
  {n:nat} .<n>.
(
  xs: list (a, n)
) :<cloref> bool =
(
  case+ xs of
  | list_cons
      (x, xs) => let
      val sgn =
        compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0
        then false
        else (if sgn < 0 then loop (xs) else true)
      // end of [if]
    end // end of [list_cons]
  | list_nil ((*void*)) => false
) (* end of [loop] *)
//
in
  loop (xs)
end // end of [funset_is_member]

implement{a}
funset_isnot_member
  (xs, x0, cmp) = not (funset_is_member (xs, x0, cmp))
// end of [funset_isnot_member]

(* ****** ****** *)

implement{a}
funset_is_equal
  (xs1, xs2, cmp) = let
//
fun aux // tail-recursive
  {n1,n2:nat} .<n1>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> bool =
(
  case+ xs1 of
  | list_cons (x1, xs1) => (
    case+ xs2 of
    | list_cons (x2, xs2) => let
        val sgn = compare_elt_elt<a> (x1, x2, cmp)
      in
        if sgn = 0 then aux (xs1, xs2) else false
      end
    | list_nil () => false
    ) // end of [list_cons]
  | list_nil () => (
    case+ xs2 of
      list_cons _ => false | list_nil () => true
    // end of [case]
    ) // end of [list_nil]
) (* end of [aux] *)
in
  aux (xs1, xs2)
end // end of [funset_is_equal]

(* ****** ****** *)

implement{a}
funset_is_subset
  (xs1, xs2, cmp) = let
//
fun aux // tail-recursive
  {n1,n2:nat} .<n1+n2>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> bool =
(
  case+ xs1 of
  | list_cons (x1, xs11) => (
    case+ xs2 of
    | list_cons (x2, xs21) => let
        val sgn =
          compare_elt_elt<a> (x1, x2, cmp)
        // end of [val]
      in
        if sgn > 0 then false
        else if sgn < 0 then aux (xs1, xs21)
        else aux (xs11, xs21)
      end
    | list_nil () => false
    ) // end of [list_cons]
  | list_nil ((*void*)) => true
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_is_subset]

(* ****** ****** *)

implement{a}
funset_compare
  (xs1, xs2, cmp) = let
//
fun aux // tail-recursive
  {n1,n2:nat} .<n1>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> int = (
  case+ xs1 of
  | list_cons (x1, xs1) => (
    case+ xs2 of
    | list_cons (x2, xs2) => let
        val sgn = compare_elt_elt<a> (x1, x2, cmp)
      in
        if sgn > 0 then 1 else (
          if sgn < 0 then ~1 else aux (xs1, xs2)
        ) // end of [if]
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil ((*void*)) => (
    case+ xs2 of list_cons _ => ~1 | list_nil _ => 0
    ) (* end of [list_nil] *)
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_compare]

(* ****** ****** *)

implement{a}
funset_insert
  (xs, x0, cmp) = let
//
fun ins
  {n:nat} .<n>.
(
  xs: list (a, n), flag: &int
) :<!wrt> List0 (a) =
(
  case+ xs of
  | list_cons (x, xs1) => let
      val sgn =
        compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0 then let
        val () = flag := flag + 1 in list_cons{a}(x0, xs)
      end else if sgn < 0 then let
        val flag0 = flag
        val xs1 = ins (xs1, flag)
      in
        if flag = flag0 then xs else list_cons{a}(x, xs1)
      end else xs // end of [if]
    end // end of [list_cons]
  | list_nil () => let
      val () = flag := flag + 1 in list_cons{a}(x0, list_nil)
    end // end of [val]
) (* end of [ins] *)
//
var flag: int = 0
val () = xs := ins (xs, flag)
//
in
  if flag = 0 then true else false
end // end of [funset_insert]

(* ****** ****** *)

implement{a}
funset_remove
  (xs, x0, cmp) = let
//
fun rem
  {n:nat} .<n>.
(
  xs: list (a, n), flag: &int
) :<!wrt> List0 (a) =
(
  case xs of
  | list_cons (x, xs1) => let
      val sgn =
        compare_elt_elt<a> (x0, x, cmp)
      // end of [val]
    in
      if sgn > 0 then xs
      else if sgn < 0 then let
        val flag0 = flag
        val xs1 = rem (xs1, flag)
      in
        if flag = flag0 then xs else list_cons{a}(x, xs1)
      end else let
        val () = flag := flag + 1 in xs1
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => list_nil ()
) (* end of [rem] *)
//
var flag: int = 0
val () = xs := rem (xs, flag)
//
in
  if flag > 0 then true else false
end // end of [funset_remove]

(* ****** ****** *)

implement{a}
funset_union
  (xs1, xs2, cmp) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> List0 (a) =
(
  case xs1 of
  | list_cons (x1, xs11) => (
      case+ xs2 of
      | list_cons (x2, xs21) => let
          val sgn = compare_elt_elt<a> (x1, x2, cmp)
        in
          if sgn > 0 then
            list_cons{a}(x1, aux (xs11, xs2))
          else if sgn < 0 then
            list_cons{a}(x2, aux (xs1, xs21))
          else
            list_cons{a}(x1, aux (xs11, xs21))
          // end of [if]
        end // end of [list_cons]
      | list_nil () => xs1
    ) // end of [list_cons]
  | list_nil ((*void*)) => xs2
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_union]

(* ****** ****** *)

implement{a}
funset_intersect
  (xs1, xs2, cmp) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> List0 (a) =
(
  case xs1 of
  | list_cons (x1, xs11) => (
      case+ xs2 of
      | list_cons (x2, xs21) => let
          val sgn = compare_elt_elt<a> (x1, x2, cmp)
        in
          if sgn > 0 then
            aux (xs11, xs2)
          else if sgn < 0 then
            aux (xs1, xs21)
          else
            list_cons{a}(x1, aux (xs11, xs21))
          // end of [if]
        end // end of [list_cons]
      | list_nil () => list_nil ()
    ) // end of [list_cons]
  | list_nil ((*void*)) => list_nil ()
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_intersect]

(* ****** ****** *)

implement{a}
funset_diff
  (xs1, xs2, cmp) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> List0 (a) =
(
  case xs1 of
  | list_cons (x1, xs11) => (
      case+ xs2 of
      | list_cons (x2, xs21) => let
          val sgn =
            compare_elt_elt<a> (x1, x2, cmp)
          // end of [val]
        in
          if sgn > 0 then
            list_cons{a}(x1, aux (xs11, xs2))
          else if sgn < 0 then
            aux (xs1, xs21)
          else
            aux (xs11, xs21)
          // end of [if]
        end // end of [list_cons]
      | list_nil () => xs1
    ) // end of [list_cons]
  | list_nil ((*void*)) => xs2
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_diff]

(* ****** ****** *)

implement{a}
funset_symdiff
  (xs1, xs2, cmp) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>. (
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref> List0 (a) =
(
  case xs1 of
  | list_cons (x1, xs11) => (
    case+ xs2 of
    | list_cons (x2, xs21) => let
        val sgn =
          compare_elt_elt<a> (x1, x2, cmp)
        // end of [val]
      in
        if sgn > 0 then
          list_cons{a}(x1, aux (xs11, xs2))
        else if sgn < 0 then
          list_cons{a}(x2, aux (xs1, xs21))
        else
          aux (xs11, xs21)
        // end of [if]
      end // end of [list_cons]
    | list_nil () => xs1
  ) // end of [list_cons]
  | list_nil ((*void*)) => xs2
) (* end of [aux] *)
//
in
  aux (xs1, xs2)
end // end of [funset_symdiff]

(* ****** ****** *)

implement{a}
funset_foreach_funenv
  {v}{vt}(pf | xs, f, env) = let
//
fun loop
(
  pf: !v
| xs: set(INV(a))
, f: (!v | a, !vt) -> void, env: !vt
) : void = (
//
case+ xs of
| list_cons (x, xs) =>
    (f (pf | x, env); loop (pf | xs, f, env))
| list_nil ((*void*)) => ()
//
) (* end of [loop] *)
//
in
  loop (pf | xs, f, env)
end (* end of [funset_foreach_funenv] *)

(* ****** ****** *)

implement{a}
funset_listize (xs) = list_copy<a> (xs)

(* ****** ****** *)

(* end of [funset_listord.dats] *)
