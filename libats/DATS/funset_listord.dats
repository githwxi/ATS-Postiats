(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2010-2013 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
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
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.funset_listord"
#define
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define
ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/funset_listord.sats"

(* ****** ****** *)
//
#include "./SHARE/funset.hats" // code reuse
//
(* ****** ****** *)

assume
set_type (a: t0p) = List0 (a)

(* ****** ****** *)
//
// HX:
// A set is represented as a sorted list in descending order;
// note that descending order is chosen to faciliate set comparison
//
(* ****** ****** *)

implement{
} funset_nil () = list_nil ()
implement{
} funset_make_nil () = list_nil ()

(* ****** ****** *)

implement{a}
funset_sing (x) = list_cons{a}(x, list_nil)
implement{a}
funset_make_sing (x) = list_cons{a}(x, list_nil)

(* ****** ****** *)
(*
** HX-2012-12:
** it supersedes the one in [./SHARE/funset.hats]
*)
implement{a}
funset_make_list
  (xs) = let
//
val xs = let
//
implement
list_mergesort$cmp<a>
  (x, y) = compare_elt_elt<a> (x, y)
//
in
  $effmask_wrt (list_mergesort<a> (xs))
end // end of [let] // [val]
//
fnx loop1
  {m:pos;n:nat} .<m,0>.
(
  xs: list_vt (a, m), ys: list_vt (a, n)
) :<!wrt>
  listLte_vt (a, m+n) = let
//
val-@cons_vt (x, xs1) = xs
val x_ = x
val xs1_ = xs1; val () = (xs1 := ys)
prval () = fold@ (xs)
//
in
  loop2 (x_, xs1_, xs)
end // end of [loop1]
//
and loop2
  {m:nat;n:nat} .<m,1>.
(
  x0: a, xs: list_vt (a, m), ys: list_vt (a, n)
) :<!wrt>
  listLte_vt (a, m+n) = let
in
//
case+ xs of
| @cons_vt (x, xs1) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if (sgn < 0)
      then let // [xs] ascending!
        prval () = fold@ (xs) in loop1 (xs, ys)
      end // end of [then]
      else let
        val xs1_ = xs1
        val () = free@{a}{0}(xs) in loop2 (x0, xs1_, ys)
      end // end of [else]
    // end of [if]
  end (* end of [cons_vt] *)
| ~nil_vt ((*void*)) => ys
//
end // end of [loop2]
//
in (* in of [let] *)
//
case+ xs of
| cons_vt _ =>
  (
    $effmask_wrt (list_of_list_vt(loop1 (xs, nil_vt())))
  ) // end of [cons_vt]
| ~nil_vt () => list_nil ()
//
end // end of [funset_make_list]

(* ****** ****** *)

implement{}
funset_is_nil (xs) = list_is_nil (xs)
implement{}
funset_isnot_nil (xs) = list_is_cons (xs)

(* ****** ****** *)

implement{a}
funset_size (xs) = g1int2uint (list_length<a> (xs))

(* ****** ****** *)

implement{a}
funset_is_member
  (xs, x0) = let
//
fun aux
  {n:nat} .<n>. (
  xs: list (a, n)
) :<> bool = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val sgn = compare_elt_elt<a> (x0, x) in
    if sgn > 0 then false else (if sgn < 0 then aux (xs) else true)
  end // end of [list_cons]
| list_nil () => false
//
end // end of [aux]
in
  aux (xs)
end // end of [funset_is_member]

(* ****** ****** *)

implement{a}
funset_insert
  (xs, x0) = let
//
fun aux
  {n:nat} .<n>.
(
  xs: list (a, n), flag: &int >> _
) :<cloref1> List0 (a) = let
in
//
case+ xs of
| list_cons
    (x, xs1) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn > 0 then let
      val () = flag := flag + 1 in list_cons{a}(x0, xs)
    end else if sgn < 0 then let
      val flag0 = flag
      val xs1 = aux (xs1, flag)
    in
      if flag = flag0 then xs else list_cons{a}(x, xs1)
    end else xs // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = flag := flag + 1 in list_cons{a}(x0, list_nil)
  end // end of [val]
//
end // end of [aux]
//
var flag: int = 0
val () = xs := $effmask_all (aux (xs, flag))
//
in
  if flag = 0 then true else false
end // end of [funset_insert]

(* ****** ****** *)

implement{a}
funset_remove
  (xs, x0) = let
//
fun aux {n:nat} .<n>.
(
  xs: list (a, n), flag: &int >> _
) :<cloref1> List0 (a) = let
in
//
case xs of
| list_cons (x, xs1) => let
    val sgn = compare_elt_elt<a> (x0, x)
  in
    if sgn > 0 then xs
    else if sgn < 0 then let
      val flag0 = flag
      val xs1 = aux (xs1, flag)
    in
      if flag = flag0 then xs else list_cons{a}(x, xs1)
    end else let
      val () = flag := flag + 1 in xs1
    end (* end of [if] *)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [aux]
//
var flag: int = 0
val () = xs := $effmask_all (aux (xs, flag))
//
in
  if flag > 0 then true else false
end // end of [funset_remove]

(* ****** ****** *)

implement{a}
funset_getmax
  (xs, x0) = let
in
//
case+ xs of
| list_cons
    (x, _) => let
    val () = x0 := x
    prval () = opt_some{a}(x0) in true
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none{a}(x0) in false
  end // end of [list_nil]
//
end // end of [funset_getmax]

(* ****** ****** *)

implement{a}
funset_getmin
  (xs, x0) = let
in
//
case+ xs of
| list_cons _ => let
    val () = x0 := list_last (xs)
    prval () = opt_some{a}(x0) in true
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none{a}(x0) in false
  end // end of [list_nil]
//
end // end of [funset_getmin]

(* ****** ****** *)

implement{a}
funset_takeoutmax
  (xs, x0) = let
in
//
case+ xs of
| list_cons
    (x, xs2) => let
    val () = (x0 := x)
    val () = (xs := xs2)
    prval () = opt_some{a}(x0)
  in
    true
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none{a}(x0)
  in
    false
  end // end of [list_nil]
//
end // end of [funset_takeoutmax]

(* ****** ****** *)

implement{a}
funset_takeoutmin
  (xs, x0) = let
//
fun aux{n:pos} .<n>.
(
  xs: list (a, n), x0: &a? >> a
) :<!wrt> list (a, n-1) = let
//
val+list_cons (x, xs2) = xs
//
in
//
case+ xs2 of
| list_cons _ => let
    val xs2 = aux (xs2, x0)
  in
    list_cons{a}(x, xs2)
  end // end of [list_cons]
| list_nil () => let
    val () = x0 := x in list_nil ()
  end // end of [list_nil]
//
end // end of [aux]
//
in
//
case+ xs of
| list_cons _ => let
    val () = xs := aux (xs, x0)
    prval () = opt_some{a}(x0) in true
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none{a}(x0) in false
  end // end of [list_nil]
//
end // end of [funset_takeoutmin]

(* ****** ****** *)

implement{a}
funset_union
  (xs1, xs2) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<> List0 (a) = let
in
//
case xs1 of
| list_cons
    (x1, xs11) =>
  (
  case+ xs2 of
  | list_cons (x2, xs21) => let
      val sgn = compare_elt_elt<a> (x1, x2)
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
| list_nil () => xs2
//
end // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_union]

(* ****** ****** *)

implement{a}
funset_intersect
  (xs1, xs2) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<> List0 (a) = let
in
//
case xs1 of
| list_cons
    (x1, xs11) =>
  (
  case+ xs2 of
  | list_cons (x2, xs21) => let
      val sgn = compare_elt_elt<a> (x1, x2)
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
| list_nil () => list_nil ()
//
end // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_intersect]

(* ****** ****** *)

implement{a}
funset_diff
  (xs1, xs2) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<cloref0> List0 (a) = let
in
//
case xs1 of
| list_cons
    (x1, xs11) => (
  case+ xs2 of
  | list_cons
      (x2, xs21) => let
      val sgn = compare_elt_elt<a> (x1, x2)
    in
      if sgn > 0
        then list_cons{a}(x1, aux (xs11, xs2))
        else (
          if sgn < 0 then aux (xs1, xs21) else aux (xs11, xs21)
        ) (* end of [else] *)
      // end of [if]
    end // end of [list_cons]
  | list_nil () => xs1
  ) // end of [list_cons]
| list_nil () => xs2
//
end // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_diff]

(* ****** ****** *)

implement{a}
funset_symdiff
  (xs1, xs2) = let
//
fun aux // non-tail-recursive
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<> List0 (a) = let
in
//
case xs1 of
| list_cons
    (x1, xs11) => (
  case+ xs2 of
  | list_cons
      (x2, xs21) => let
      val sgn =
        compare_elt_elt<a> (x1, x2)
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
| list_nil () => xs2
//
end // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_symdiff]

(* ****** ****** *)

implement{a}
funset_compare
  (xs1, xs2) = let
//
fun aux // tail-recursive
  {n1,n2:nat} .<n1>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<> Sgn = (
  case+ xs1 of
  | list_cons
      (x1, xs1) => (
    case+ xs2 of
    | list_cons (x2, xs2) => let
        val sgn = compare_elt_elt<a> (x1, x2)
      in
        if sgn > 0 then 1 else (
          if sgn < 0 then ~1 else aux (xs1, xs2)
        ) // end of [if]
      end // end of [list_cons]
    | list_nil () => 1
    ) // end of [list_cons]
  | list_nil () => (
    case+ xs2 of list_cons _ => ~1 | list_nil _ => 0
    )
) // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_compare]

(* ****** ****** *)

implement{a}
funset_is_subset
  (xs1, xs2) = let
//
fun aux // tail-recursive
  {n1,n2:nat} .<n1+n2>.
(
  xs1: list (a, n1), xs2: list (a, n2)
) :<> bool = let
in
//
case+ xs1 of
| list_cons
    (x1, xs11) => (
  case+ xs2 of
  | list_cons
      (x2, xs21) => let
      val sgn = compare_elt_elt<a> (x1, x2)
    in
      if sgn > 0 then false else
        (if sgn < 0 then aux (xs1, xs21) else aux (xs11, xs21))
      // end of [if]
    end // end of [list_cons]
  | list_nil () => false
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [aux]
//
in
  aux (xs1, xs2)
end // end of [funset_is_subset]

(* ****** ****** *)

implement
{a}{env}
funset_foreach_env
  (xs, env) = let
//
val xs = list_reverse (xs)
//
implement{a}{env}
list_vt_foreach$cont (x, env) = true
implement
list_vt_foreach$fwork<a><env> (x, env) =
  funset_foreach$fwork<a><env> (x, env)
//
val () = list_vt_foreach_env<a><env> (xs, env)
//
val () = list_vt_free (xs)
//
in
  // nothing
end // end of [funset_foreach_env]

(* ****** ****** *)

implement{a}
funset_listize (xs) = list_reverse<a> (xs)

(* ****** ****** *)

(*
//
// HX: this is now a cast funciton
//
implement{}
funset2list (xs) = xs // HX: [xs] in decending order
*)

(* ****** ****** *)

(* end of [funset_listord.dats] *)
