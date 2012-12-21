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

(* Author: Hanwen Wu *)
(* Authoremail: hwwu AT cs DOT bu DOT edu *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: November, 2011 *)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linheap_fibonacci.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
postfix (~) SZ
//
macdef SZ (i) = g1int2uint<int_kind,size_kind> (,(i))
//
(* ****** ****** *)

abstype node (a:viewt@ype+, l:addr)
typedef node0 (a:vt0p) = [l:addr | l >= null] node (a, l) // nullable
typedef node1 (a:vt0p) = [l:addr | l >  null] node (a, l) // non-null

(* ****** ****** *)

extern
castfn
node2ptr
  {a:vt0p}{l:addr} (nx: node (INV(a), l)):<> ptr (l)
// end of [node2ptr]

(* ****** ****** *)

abstype nodelst (a:viewt@ype+, n:int)
typedef nodelst0 (a:vt0p) = [n:nat] nodelst (a, n)
typedef nodelst1 (a:vt0p) = [n:int | n > 0] nodelst (a, n)

(* ****** ****** *)

extern
castfn node2nodelst0 {a:vt0p} (nx: node0 (INV(a))):<> nodelst0 (a)
extern
castfn node2nodelst1 {a:vt0p} (nx: node0 (INV(a))):<> nodelst1 (a)

extern
castfn nodelst2node0 {a:vt0p} (nx: nodelst0 (INV(a))):<> node0 (a)
extern
castfn nodelst2node1 {a:vt0p} (nx: nodelst1 (INV(a))):<> node1 (a)

(* ****** ****** *)

extern
fun{a:t0p}
node_get_elt (nx: !node1 (INV(a))):<> a
extern
fun{a:vt0p}
node_getref_elt (nx: !node1 (INV(a))):<> Ptr1

(* ****** ****** *)

extern
fun{a:vt0p}
node_get_rank (nx: !node1 (INV(a))):<> int
extern
fun{a:vt0p}
node_set_rank (nx: !node1 (INV(a)), d: int):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
node_get_marked (nx: !node1 (INV(a))):<> bool
extern
fun{a:vt0p}
node_get_marked (nx: !node1 (INV(a)), mark: bool):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
node_get_parent (nx: !node1 (INV(a))):<> node0 (a)
extern
fun{a:vt0p}
node_set_parent (nx: !node1 (INV(a)), par: node0 (a)):<!wrt> void

extern
fun{a:vt0p}
node_get_left (nx: !node1 (INV(a))):<> node1 (a)
extern
fun{a:vt0p}
node_set_left (nx: !node1 (INV(a)), left: node1 (a)):<!wrt> void

extern
fun{a:vt0p}
node_get_right (nx: !node1 (INV(a))):<> node1 (a)
extern
fun{a:vt0p}
node_set_right (nx: !node1 (INV(a)), right: node1 (a)):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
node_get_children (nx: !node1 (INV(a))):<> nodelst0 (a)
extern
fun{a:vt0p}
node_set_children (nx: !node1 (INV(a)), nxs: nodelst0 (a)): void

(* ****** ****** *)

extern
fun{a:vt0p}
node_make_elt (x: a):<> node1 (a)
extern
fun{a:vt0p}
node_free_elt (nx: node1 (a), res: &(a?) >> a): void

(* ****** ****** *)

extern
fun{a:vt0p}
hlink_node_node
  (nx1: node1 (a), nx2: node1 (a)):<!wrt> void
implement{a}
hlink_node_node (nx1, nx2) = let
//
val () = node_set_right (nx1, nx2) and () = node_set_left (nx2, nx1)
//
in
  // nothing
end // end of [hlink_node_node]

(* ****** ****** *)
//
// HX: [nodelst_add] is expected to be O(1)
//
extern
fun{a:vt0p}
nodelst_add {n:nat}
  (nxs: nodelst (INV(a), n), nx: node1 (a)):<!wrt> nodelst (a, n+1)
implement{a}
nodelst_add
  {n} (nxs, nx) = let
//
typedef tres = nodelst (a, n+1)
//
val nx0 = nodelst2node0 (nxs)
//
in
//
if node2ptr (nx0) > 0 then let
  val nx0_r = node_get_right (nx0)
  val () = hlink_node_node (nx0, nx)
  and () = hlink_node_node (nx, nx0_r)
in
  $UN.cast{tres} (nx0)
end else let
  val () = hlink_node_node (nx, nx) in $UN.cast{tres} (nx)
end // end of [if]
//
end // end of [nodelst_add]

(* ****** ****** *)
//
// HX: [nodelst_addlst] is expected to be O(1)
//
extern
fun{a:vt0p}
nodelst_addlst_left {n1,n2:nat} (
  nxs1: nodelst (INV(a), n1), nxs2: nodelst (a, n2)
) : nodelst (a, n1+n2) // end of [nodelst_addlst_left]
extern
fun{a:vt0p}
nodelst_addlst_right {n1,n2:nat} (
  nxs1: nodelst (INV(a), n1), nxs2: nodelst (a, n2)
) : nodelst (a, n1+n2) // end of [nodelst_addlst_right]

(* ****** ****** *)

implement{a}
nodelst_addlst_left
  {n1,n2} (nxs1, nxs2) = let
//
typedef tres = nodelst (a, n1+n2)
//
val nx10 = nodelst2node0 (nxs1)
val nx20 = nodelst2node0 (nxs2)
//
in
//
if node2ptr (nx10) > 0 then (
  if node2ptr (nx20) > 0 then let
    val nx10_l = node_get_left (nx10)
    val nx20_r = node_get_right (nx20)
    val () = hlink_node_node (nx20, nx10)
    val () = hlink_node_node (nx10_l, nx20_r)
  in
    $UN.cast{tres} (nx10)
  end else $UN.cast{tres} (nx10)
) else $UN.cast{tres} (nx20)
//
end // end of [nodelst_addlst_left]

implement{a}
nodelst_addlst_right
  {n1,n2} (nxs1, nxs2) = let
//
typedef tres = nodelst (a, n1+n2)
//
val nx10 = nodelst2node0 (nxs1)
val nx20 = nodelst2node0 (nxs2)
//
in
//
if node2ptr (nx10) > 0 then (
  if node2ptr (nx20) > 0 then let
    val nx20_l = node_get_left (nx20)
    val nx10_r = node_get_right (nx10)
    val () = hlink_node_node (nx10, nx20)
    val () = hlink_node_node (nx20_l, nx10_r)
  in
    $UN.cast{tres} (nx10)
  end else $UN.cast{tres} (nx10)
) else $UN.cast{tres} (nx20)
//
end // end of [nodelst_addlst_right]

(* ****** ****** *)

datavtype
fibheap (a:viewt@ype+) =
  | FIBHEAP (a) of (node0 (a), size_t(*size*))
// end of [fibheap]

(* ****** ****** *)

assume heap_viewtype (a:vt0p) = fibheap (a)

(* ****** ****** *)

implement{a}
linheap_is_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => if node2ptr (nx) > 0 then false else true
//
end // end of [linheap_is_nil]

implement{a}
linheap_isnot_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => if node2ptr (nx) > 0 then true else false
//
end // end of [linheap_isnot_nil]

(* ****** ****** *)

implement{a}
linheap_size (hp) =
  case+ hp of FIBHEAP (_, N) => N
// end of [linheap_size]

(* ****** ****** *)
//
// HX: implementing mergeable-heap operations
//
(* ****** ****** *)

extern
fun{a:vt0p}
compare_elt_node
  (x1: &a, nx2: node0 (a)):<> int
implement{a}
compare_elt_node
  (x1, nx2) = let
in
//
if node2ptr (nx2) > 0 then let
  val [l2:addr]
    p_x2 = node_getref_elt (nx2)
  prval (pf, fpf) =
    __assert (p_x2) where {
    extern praxi __assert : ptr l2 -<prf> (a@l2, a@l2 -<lin,prf> void)
  } // end of [prval]
  val sgn = compare_elt_elt (x1, !p_x2)
  prval () = fpf (pf)
in
  sgn
end else ~1 // end of [if]
//
end // end of [compare_elt_node]

(* ****** ****** *)

extern
fun{a:vt0p}
compare_node_node
  (nx1: node0 (a), nx2: node0 (a)):<> int
implement{a}
compare_node_node
  (nx1, nx2) = let
in
//
if node2ptr (nx1) > 0 then let
  val [l1:addr]
    p_x1 = node_getref_elt (nx1)
  prval (pf, fpf) =
    __assert (p_x1) where {
    extern praxi __assert : ptr l1 -<prf> (a@l1, a@l1 -<lin,prf> void)
  } // end of [prval]
  val sgn = compare_elt_node (!p_x1, nx2)
  prval () = fpf (pf)
in
  sgn
end else 1 // end of [if]
//
end // end of [compare_node_node]

(* ****** ****** *)

implement{a}
linheap_insert
  (hp, x0) = let
//
val @FIBHEAP (nx0, N) = hp
//
var x0: a = x0
val sgn = compare_elt_node<a> (x0, nx0)
//
val nx2 = node_make_elt (x0)
val nxs = node2nodelst0 (nx0)
val _(*nxs*) = nodelst_add (nxs, nx2)
//
val () = if :(nx0: node0 (a)) => sgn < 0 then nx0 := nx2
val () = N := succ (N)
//
prval () = fold@ (hp)
//
in
  // nothing
end // end of [linheap_insert]

(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp) =
  case+ hp of FIBHEAP (nx, _) => node2ptr (nx)
// end of [linheap_getmin_ref]

(* ****** ****** *)

implement{a}
linheap_merge
  (hp1, hp2) = hp1 where {
//
val @FIBHEAP (nx1, N1) = hp1
val ~FIBHEAP (nx2, N2) = hp2
//
val sgn = compare_node_node<a> (nx1, nx2)
//
val nxs1 = node2nodelst0 (nx1)
val nxs2 = node2nodelst0 (nx2)
val _(*nxs*) = nodelst_addlst_right (nxs1, nxs2)
//
val () = if :(nx1: node0 (a)) => (0 < sgn) then nx1 := nx2
val () = N1 := N1 + N2
//
prval () = fold@ (hp1)
//
} // end of [linheap_merge]

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_del
  {n:int | n > 0}
  (nxs: nodelst (a, n)): nodelst (a, n-1)
// end of [nodelst_del]

extern
fun{a:vt0p}
nodelst_set_parent_nil (nxs: nodelst0 (a)): void

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_consolidate (nxs: nodelst0 (a)): nodelst0 (a)

(* ****** ****** *)

implement{a}
linheap_delmin
  (hp, res) = let
//
val @FIBHEAP (nx0_ref, N) = hp
//
in
//
if N > 0SZ then let
  val nx0 =
    $UN.cast{node1(a)} (nx0_ref)
  // end of [val]
  val nxs1 = node2nodelst1 (nx0)
  val nxs2 = node_get_children (nx0)
  val () = nodelst_set_parent_nil (nxs2)
//
  val nxs12 =
    nodelst_addlst_right (nxs1, nxs2)
  val nxs12 = nodelst_del (nxs12)
  val nxs12 = nodelst_consolidate (nxs12)
//
  val () =
    node_free_elt (nx0, res)
  // end of [val]
  prval () = opt_some {a} (res)
//
  val () = N := pred (N)
  val () = nx0_ref := nodelst2node0 (nxs12)
  prval () = fold@ (hp)
//
in
  true (*removed*)
end else let
  prval () =
    opt_none {a} (res)
  prval () = fold@ (hp)
in
  false (*~removed*)
end // end of [if]
//
end // end of [linheap_delmin]

(* ****** ****** *)

(* linheap_fibonacci.dats *)
