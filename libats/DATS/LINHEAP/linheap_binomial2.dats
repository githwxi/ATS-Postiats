(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2012 Hongwei Xi, Boston University
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2012 *)

(* ****** ****** *)
//
// HX: This implementation is of imperative style;
// it supports mergeable-heap operations and also
// the decrease-key operation.
//
(* ****** ****** *)
//
// License: LGPL 3.0
// available at http://www.gnu.org/licenses/lgpl.txt
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynamic loading at run-time

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linheap_binomial.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

abstype node (a:viewt@ype+, l:addr)
typedef node0 (a: vt0p) = [l:addr | l >= null] node (a, l)
typedef node1 (a: vt0p) = [l:addr | l >  null] node (a, l)

(* ****** ****** *)

extern
fun{a:vt0p} node_nil (): node (a, null)

extern
fun{a:vt0p}
node_make_elt (x: a):<> node1 (a)
extern
fun{a:vt0p}
node_free_elt (nx: node1 (a), res: &(a?) >> a): void

(* ****** ****** *)

extern
castfn
node2ptr {a:vt0p}{l:addr} (nx: node (a, l)):<> ptr l

(* ****** ****** *)

abstype nodelst (a:viewt@ype+, n:int)
typedef nodelst0 (a: vt0p) = [n:nat] nodelst (a, n)
typedef nodelst1 (a: vt0p) = [n:int | n > 0] nodelst (a, n)

(* ****** ****** *)

extern
fun{a:vt0p}
node_getref_elt (nx: node1 (a)):<> Ptr1

extern
fun{a:vt0p}
node_get_rank (nx: node1 (a)):<> int
extern
fun{a:vt0p}
node_set_rank (nx: node1 (a), r: int):<!wrt> void

extern
fun{a:vt0p}
node_get_parent (nx: node1 (a)):<> node0 (a)
extern
fun{a:vt0p}
node_set_parent (nx: node1 (a), par: node0 (a)):<!wrt> void

extern
fun{a:vt0p}
node_get_children (nx: node1 (a)):<> nodelst0 (a)
extern
fun{a:vt0p}
node_set_children (nx: node1 (a), nxs: nodelst0 (a)):<!wrt> void

extern
fun{a:vt0p}
node_get_children2
  (nx: node1 (a), n: &int? >> int n):<!wrt> #[n:nat] nodelst (a, n)
// end of [node_get_children2]

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_nil ():<> nodelst (a, 0)

extern
fun{a:vt0p}
nodelst_cons {n:nat} (
  nx1: node1 (a), nxs2: nodelst (a, n)
) :<> nodelst (a, n+1) // endfun

extern
fun{a:vt0p}
nodelst_uncons
  {n:int | n > 0} (
  xs: &nodelst (a, n) >> nodelst (a, n-1)
) : node1 (a) // end of [nodelst_uncons]

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_sing_elt (x0: a):<> nodelst (a, 1)
implement{a}
nodelst_sing_elt (x0) = let
  val nx = node_make_elt<a> (x0) in nodelst_cons (nx, nodelst_nil ())
end  // end of [nodelst_sing_elt]

(* ****** ****** *)

extern
castfn
nodelst_is_nil {a:vt0p}{n:nat} (xs: nodelst (a, n)):<> bool (n==0)
extern
castfn
nodelst_is_cons {a:vt0p}{n:nat} (xs: nodelst (a, n)):<> bool (n > 0)

(* ****** ****** *)

extern
castfn
node2nodelst0 {a:vt0p} (nx: node0 (a)):<> nodelst0 (a)

extern
castfn
nodelst2node1 {a:vt0p} (nxs: nodelst1 (a)):<> node1 (a)

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_revapp
  {m,n:nat} (
  xs: nodelst (a, m), ys: nodelst (a, n)
) : nodelst (a, m+n) // endfun
implement{a}
nodelst_revapp
  (xs, ys) = let
in
//
if nodelst_is_cons (xs) then let
  var xs = xs
  val x = nodelst_uncons (xs)
in
  nodelst_revapp (xs, nodelst_cons (x, ys))
end else ys // end of [if]
//
end // end of [nodelst_revapp]

extern
fun{a:vt0p}
nodelst_reverse
  {n:nat} (xs: nodelst (a, n)): nodelst (a, n)
implement{a}
nodelst_reverse (xs) = nodelst_revapp (xs, nodelst_nil ())

(* ****** ****** *)

extern
fun{a:vt0p}
compare_node_node
  (nx1: node1 (a), nx2: node1 (a)):<> int
implement{a}
compare_node_node
  (nx1, nx2) = sgn where {
  val p_x1 = node_getref_elt (nx1)
  prval (pf1, fpf1) = $UN.ptr_vtake {a} (p_x1)
  val p_x2 = node_getref_elt (nx2)
  prval (pf2, fpf2) = $UN.ptr_vtake {a} (p_x2)
  val sgn = compare_elt_elt<a> (!p_x1, !p_x2)
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
} // end of [compare_node_node]

(* ****** ****** *)

extern
fun{a:vt0p}
join_node_node (nx1: node1 (a), nx2: node1 (a)):<!wrt> void

implement{a}
join_node_node (nx1, nx2) = let
  var r: int
  val nxs1 =
    node_get_children2 (nx1, r)
  // end of [val]
  val () = node_set_rank (nx1, r+1)
  val () = node_set_parent (nx2, nx1)
  val () = node_set_children (nx1, nodelst_cons (nx2, nxs1))
in
  // nothing
end // end of [join_node_node]

(* ****** ****** *)

extern
fun{a:vt0p}
merge_nodelst_nodelst
  (nxs1: nodelst0 (a), nxs2: nodelst0 (a)):<!wrt> nodelst0 (a)
// end of [merge_nodelst_nodelst]

(* ****** ****** *)

assume heap_viewtype (a: vt0p) = nodelst0 (a)

(* ****** ****** *)

implement{a} linheap_nil () = nodelst_nil ()

(* ****** ****** *)

implement{a}
linheap_is_nil (hp) = nodelst_is_nil (hp)
implement{a}
linheap_isnot_nil (hp) = nodelst_is_cons (hp)

(* ****** ****** *)
  
implement{a}
linheap_insert
  (hp, x0) = let
  val nxs = hp
  val nxs2 = nodelst_sing_elt (x0)
  val () = hp := merge_nodelst_nodelst (nxs, nxs2)
in
  // nothing
end // end of [linheap_insert]
  
(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp0) = let
//
fun loop (
  nxs: &nodelst0 (a) >> _, nx0: node1 (a)
) : node1 (a) = let
in
//
if nodelst_is_cons (nxs) then let
  val nx = nodelst_uncons (nxs)
  val sgn = compare_node_node (nx, nx0)
in
  if sgn < 0 then loop (nxs, nx) else loop (nxs, nx0)
end else nx0 // end of [if]
//
end // end of [loop]
//
var nxs: nodelst0 (a) = $UN.castvwtp1 {nodelst0(a)} (hp0)
//
in
//
if nodelst_is_cons (nxs) then let
  val nx = nodelst_uncons (nxs) in node2ptr (loop (nxs, nx))
end else nullp // end of [if]
//
end // end of [linheap_getmin_ref]

(* ****** ****** *)

(* linheap_binomial2.dats *)
