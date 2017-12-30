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
//
staload
UN = "prelude/SATS/unsafe.sats"
//
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/list.sats"
//
staload
"libats/ATS1/SATS/funmset_listord.sats"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
compare_elt_elt(x1, x2, cmp) = cmp(x1, x2)
//
(* ****** ****** *)

typedef intGt0 = intGt(0)

(* ****** ****** *)

assume
mset_t0ype_type(a: t@ype) = List0(@(intGt0, a))

(* ****** ****** *)
//
// HX:
// mset is represented as a sorted mlist in descending order;
// note that desending order is chosen to facilitate mset comparion
//
(* ****** ****** *)

implement{}
funmset_make_nil () = list_nil ()

(* ****** ****** *)

implement{a}
funmset_make_sing (x) = let
  typedef nx = (intGt0, a) in list_vt2t(list_make_sing<nx>((1, x)))
end // end of [funmset_make_sing]

implement{a}
funmset_make_pair
  (x1, x2, cmp) = let
//
typedef nx = (intGt0, a)
//
val sgn = compare_elt_elt<a> (x1, x2, cmp)
//
in
//
if sgn > 0 then let
  val nx1 = (1, x1) and nx2 = (1, x2)
in
  list_vt2t(list_make_pair<nx> (nx1, nx2))
end else if sgn < 0 then let
  val nx1 = (1, x1) and nx2 = (1, x2)
in
  list_vt2t(list_make_pair<nx> (nx2, nx1))
end else let
  val nx = @(2, x1) in list_vt2t(list_make_sing<nx> (nx))
end // end of [if]
//
end // end of [funmset_make_pair]

(* ****** ****** *)

implement{a}
funmset_make_list
  (xs, cmp) = let
//
typedef nx = (intGt0, a)
//
fun ntimes
  {k:nat} .<k>.
(
  xs: list_vt (a, k), x0: a, n: &intGt0 >> _
) :<!wrt> [k1:nat | k1 <= k] list_vt (a, k1) =
(
  case+ xs of
    | @list_vt_cons
        (x, xs1) => let
        val sgn =
          compare_elt_elt<a> (x0, x, cmp)
        // end of [val]
      in
        if sgn > 0 then let
          prval () = fold@ (xs) in xs
        end else let
          val xs1 = xs1
          val () = n := n + 1
          val () = free@{a}{0}(xs)
        in
          ntimes (xs1, x0, n)
        end // end of [if]
      end // end of [list_vt_cons]
    | list_vt_nil ((*void*)) => xs
) (* end of [ntimes] *)
//
fun loop{k:nat} .<k>.
(
  xs: list_vt (a, k), res: &mset(a)? >> mset(a)
) :<!wrt> void =
(
  case+ xs of
  | ~list_vt_cons
      (x0, xs) => let
      var n: intGt0 = 1
      val xs = ntimes (xs, x0, n)
      val nx0 = @(n, x0)
      val () = res := list_cons{nx}{0} (nx0, _)
      val+list_cons (_, res1) = res
      val ((*void*)) = loop (xs, res1)
      prval ((*void*)) = fold@ (res)
    in
      // nothing
    end // end of [list_vt_cons]
  | ~list_vt_nil () => let
      val () = res := list_nil () in (*nothing*)
    end // end of [list_vt_nil]
) (* end of [loop] *)
//
val xs = list_copy (xs)
prval () = lemma_list_vt_param (xs)
//
// HX: ~cmp: descending order
//
val xs = list_vt_mergesort_fun (xs, lam (x1, x2) => ~cmp (x1, x2))
//
var res: mset(a)
val () = loop (xs, res)
//
in
  res
end // end of [funmset_make_list]

(* ****** ****** *)

implement{a}
funmset_size (nxs) = let
  typedef nx = @(intGt0, a)
  fun loop {k:nat} .<k>.
    (nxs: list (nx, k), res: Size):<> Size =
    case+ nxs of
    | list_cons (nx, nxs) => loop (nxs, res + nx.0) | list_nil () => res
  // end of [loop]
in
  loop (nxs, i2sz(0))
end // end of [funmset_size]

(* ****** ****** *)

implement{a}
funmset_get_ntime
  (nxs, x0, cmp) = let
//
typedef nx = @(intGt0, a)
//
fun loop
  {k:nat} .<k>.
(
  nxs: list (nx, k)
) :<> intGte(0) =
  case+ nxs of
  | list_nil ((*void*)) => 0
  | list_cons (nx, nxs) => let
      val sgn = compare_elt_elt<a> (x0, nx.1, cmp) in
      if sgn > 0 then 0 else (if sgn < 0 then loop (nxs) else nx.0)
    end // end of [list_cons]
// end of [loop]
//
in
  loop (nxs)
end // end of [funmset_get_ntime]

(* ****** ****** *)

implement{a}
funmset_is_member
  (xs, x0, cmp) = funmset_get_ntime (xs, x0, cmp) > 0
// end of [funmset_is_member]

implement{a}
funmset_isnot_member
  (xs, x0, cmp) = funmset_get_ntime (xs, x0, cmp) = 0
// end of [funmset_isnot_member]

(* ****** ****** *)

implement{a}
funmset_is_subset
  (nxs1, nxs2, cmp) = let
//
typedef nx = (int, a)
fun aux // tail-recursive
  {k1,k2:nat} .<k1+k2>. (
  nxs1: list (nx, k1), nxs2: list (nx, k2)
) :<cloref> bool =
  case+ nxs1 of
  | list_cons
      (nx1, nxs11) => (
    case+ nxs2 of
    | list_cons
        (nx2, nxs21) => let
        val sgn = compare_elt_elt<a> (nx1.1, nx2.1, cmp)
      in
        if sgn > 0 then false
        else if sgn < 0 then aux (nxs1, nxs21)
        else (
          if nx1.0 <= nx2.0 then aux (nxs11, nxs21) else false
        ) // end of [if]
      end // end of [list_cons]
    | list_nil ((*void*)) => false
    ) // end of [list_cons]
  | list_nil ((*void*)) => true
// end of [aux]
in
  aux (nxs1, nxs2)
end // end of [funmset_is_subset]

implement{a}
funmset_is_equal
  (nxs1, nxs2, cmp) = let
//
typedef nx = (int, a)
fun aux // tail-recursive
  {k1,k2:nat} .<k1>. (
  nxs1: list (nx, k1), nxs2: list (nx, k2)
) :<cloref> bool = (
  case+ nxs1 of
  | list_cons
      (nx1, nxs1) => (
    case+ nxs2 of
    | list_cons
        (nx2, nxs2) => let
        val sgn = compare_elt_elt<a> (nx1.1, nx2.1, cmp)
      in
        if sgn = 0 then (
          if nx1.0 = nx2.0 then aux (nxs1, nxs2) else false
        ) else false // end of [if]
      end // end of [list_cons]
    | list_nil ((*void*)) => false
    ) // end of [list_cons]
  | list_nil ((*void*)) => (
      case+ nxs2 of | list_cons _ => false | list_nil () => true
    ) (* end of [list_nil] *)
) (* end of [aux] *)
//
in
  aux (nxs1, nxs2)
end // end of [funmset_is_equal]

(* ****** ****** *)

implement{a}
funmset_compare
  (nxs1, nxs2, cmp) = let
//
typedef nx = (int, a)
//
fun aux // tail-recursive
  {k1,k2:nat} .<k1>. (
  nxs1: list (nx, k1), nxs2: list (nx, k2)
) :<cloref> int = (
  case+ nxs1 of
  | list_cons
      (nx1, nxs1) => (
    case+ nxs2 of
    | list_cons
        (nx2, nxs2) => let
        val sgn =
          compare_elt_elt<a> (nx1.1, nx2.1, cmp)
        // end of [val]
      in
        if sgn > 0 then 1
        else if sgn < 0 then ~1
        else let
          val n1 = nx1.0 and n2 = nx2.0
        in
          if n1 > n2 then 1
          else if n1 < n2 then ~1
          else aux (nxs1, nxs2)
        end (* end of [if] *)
      end // end of [list_cons]
    | list_nil ((*void*)) => 1
    ) // end of [list_cons]
  | list_nil ((*void*)) =>
    (
      case+ nxs2 of list_cons _ => ~1 | list_nil _ => 0
    ) (* end of [list_nil] *)
) (* end of [aux] *)
//
in
  aux (nxs1, nxs2)
end // end of [funmset_compare]

(* ****** ****** *)

implement{a}
funmset_insert
  (nxs, x0, cmp) = let
//
typedef nx = @(intGt0, a)
//
fun loop
  {k:nat} .<k>. (
  nxs: list (nx, k)
) :<cloref> List0 (nx) =
  case+ nxs of
  | list_cons
      (nx, nxs1) => let
      val sgn = compare_elt_elt<a> (x0, nx.1, cmp)
    in
      if sgn > 0 then
        list_cons{nx}((1, x0), nxs)
      else if sgn < 0 then let
        val nxs1 = loop (nxs1) in list_cons{nx}(nx, nxs1)
      end else let
        val nx = (nx.0 + 1, nx.1) in list_cons{nx}(nx, nxs1)
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => list_cons{nx}((1, x0), list_nil())
// end of [loop]
//
in
  nxs := loop (nxs)
end // end of [funmset_insert]

(* ****** ****** *)

implement{a}
funmset_remove
  (nxs, x0, cmp) = let
//
typedef nx = @(intGt0, a)
//
fun loop
  {k:nat} .<k>.
(
  nxs: list (nx, k), flag: &int >> _
) :<!wrt> List0 (nx) =
  case nxs of
  | list_cons
      (nx, nxs1) => let
      val sgn = compare_elt_elt<a> (x0, nx.1, cmp)
    in
      if sgn > 0 then nxs
      else if sgn < 0 then let
        val flag0 = flag
        val nxs1 = loop (nxs1, flag)
      in
        if flag = flag0 then nxs else list_cons{nx}(nx, nxs1)
      end else let
        val n1 = nx.0 - 1
        val () = flag := flag + 1
      in
        if n1 > 0 then list_cons{nx}((n1, nx.1), nxs1) else nxs1
      end (* end of [if] *)
   end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux]
//
var flag: int = 0
val () = nxs := loop (nxs, flag)
//
in
  if flag > 0 then true else false
end // end of [funmset_remove]

(* ****** ****** *)

implement{a}
funmset_union
  (nxs1, nxs2, cmp) = let
//
typedef nx = @(intGt0, a)
//
fun aux
  {k1,k2:nat} .<k1+k2>.
(
  nxs1: list (nx, k1)
, nxs2: list (nx, k2)
) :<cloref> List0 (nx) =
(
  case nxs1 of
  | list_cons
      (nx1, nxs11) => (
    case+ nxs2 of
    | list_cons
        (nx2, nxs21) => let
        val sgn =
          compare_elt_elt<a> (nx1.1, nx2.1, cmp)
        // end of [val]
      in
        if sgn > 0 then
          list_cons{nx}(nx1, aux (nxs11, nxs2))
        else if sgn < 0 then
          list_cons{nx}(nx2, aux (nxs1, nxs21))
        else let
          val nx12 = (nx1.0 + nx2.0, nx1.1)
        in
          list_cons{nx}(nx12, aux (nxs11, nxs21))
        end (* end of [if] *)
      end // end of [list_cons]
    | list_nil ((*void*)) => nxs1
  ) (* end of [list_cons] *)
  | list_nil ((*void*)) => nxs2
) (* end of [aux] *)
in
  aux (nxs1, nxs2)
end // end of [funmset_union]

(* ****** ****** *)

implement{a}
funmset_intersect
  (nxs1, nxs2, cmp) = let
//
typedef nx = @(intGt0, a)
//
fun aux
  {k1,k2:nat} .<k1+k2>.
(
  nxs1: list (nx, k1)
, nxs2: list (nx, k2)
) :<cloref> List0 (nx) = let
in
//
case nxs1 of
| list_cons
    (nx1, nxs11) => (
  case+ nxs2 of
  | list_cons
      (nx2, nxs21) => let
      val sgn =
        compare_elt_elt<a> (nx1.1, nx2.1, cmp)
      // end of [val]
    in
      if sgn > 0 then
        aux (nxs11, nxs2)
      else if sgn < 0 then
        aux (nxs1, nxs21)
      else let
        val nx12 =
        (
          if nx1.0 <= nx2.0 then nx1 else nx2
        ) : nx // end of [val]
      in
        list_cons{nx}(nx1, aux (nxs11, nxs21))
      end // end of [if]
    end // end of [list_cons]
  | list_nil ((*void*)) => list_nil ()
  ) (* end of [list_cons] *)
| list_nil ((*void*)) => list_nil ()
//
end (* end of [aux] *)
//
in
  aux (nxs1, nxs2)
end // end of [funmset_intersect]

(* ****** ****** *)
//
(*
** HX: the returned list is in descending order
*)
implement{a}
funmset_listize (nxs) = let
  typedef nx = @(intGt0, a)
  viewtypedef res = List_vt (a)
in
  list_map_fun<nx><a> (nxs, lam (nx) =<0> nx.1)
end // end of [funmset_listize]
//
(* ****** ****** *)
//
(*
** HX: the returned list is in descending order
*)
//
implement{a}
funmset_mlistize
  (nxs) = res where
{
//
typedef nx = @(intGt0, a)
vtypedef res = List0_vt (a)
//
fnx loop1{k:nat} .<k,0>.
(
  nxs: list (nx, k), res: &res? >> res
) :<!wrt> void =
(
  case+ nxs of
  | list_cons
      (nx, nxs) => loop2 (nx.0, nx.1, nxs, res)
  | list_nil ((*void*)) => (res := list_vt_nil)
) (* end of [loop1] *)
//
and loop2{k,n:nat} .<k,n+1>.
(
  n: int n, x: a, nxs: list (nx, k), res: &res? >> res
) :<!wrt> void =
(
  if n > 0 then let
    val () =
      res := list_vt_cons{a}{0}(x, _)
    // end of [val]
    val+list_vt_cons (_, res1) = res
    val () = loop2 (n-1, x, nxs, res1)
    prval ((*void*)) = fold@{a}(res)
  in
    // nothing
  end else
    loop1 (nxs, res)
  // end of [if]
) (* end of [loop2] *)
//
var res: ptr
val () = loop1 (nxs, res)
//
} (* end of [funmset_mlistize] *)
//  
(* ****** ****** *)

(* end of [funmset_listord.dats] *)
