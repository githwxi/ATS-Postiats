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

staload "libats/SATS/linheap_fibonacci.sats"

(* ****** ****** *)

#define nullp the_null_ptr

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

(* ****** ****** *)

extern
castfn
nodelst_is_nil
  {a:vt0p}{n:int} (nxs: nodelst (INV(a), n)):<> bool (n==0)
// end of [nodelst_is_nil]

extern
castfn
nodelst_isnot_nil
  {a:vt0p}{n:int} (nxs: nodelst (INV(a), n)):<> bool (n > 0)
// end of [nodelst_isnot_nil]

(* ****** ****** *)

extern
fun{a:t0p} node_getref_elt (nx: !node1 (INV(a))):<> a
extern
fun{a:vt0p} node_getref_elt (nx: !node1 (INV(a))):<> Ptr1

extern
fun{a:vt0p} node_get_degree (nx: !node1 (INV(a))):<> int
extern
fun{a:vt0p} node_get_marked (nx: !node1 (INV(a))):<> bool

extern
fun{a:vt0p} node_get_parent (nx: !node1 (INV(a))):<> node0 (a)

extern
fun{a:vt0p} node_get_left (nx: !node1 (INV(a))):<> node0 (a)
extern
fun{a:vt0p} node_get_right (nx: !node1 (INV(a))):<> node0 (a)

extern
fun{a:vt0p} node_get_children (nx: !node1 (INV(a))):<> nodelst0 (a)

(* ****** ****** *)

extern
fun{a:vt0p} node_make_elt (x: a):<> node1 (a)

(* ****** ****** *)

extern
fun{a:vt0p} nodelst_sing_elt (x: a):<> nodelst (a, 1)

(* ****** ****** *)
//
// HX: [nodelst_add] is expected to be O(1)
//
extern
fun{a:vt0p}
nodelst_add {n:int}
  (nxs: nodelst (INV(a), n), nx: node1 (a)):<!wrt> nodelst (a, n+1)
// end of [nodelst_add]

(* ****** ****** *)
//
// HX: [nodelst_union] is expected to be O(1)
//
extern
fun{a:vt0p}
nodelst_union {n1,n2:int} (
  nxs1: nodelst (INV(a), n1), nxs2: nodelst (a, n2)
) : nodelst (a, n1+n2) // end of [nodelst_union]

(* ****** ****** *)

datavtype
fibheap (a:viewt@ype+) =
  | FIBHEAP (a) of (node0 (a), int(*size*))
// end of [fibheap]

(* ****** ****** *)

assume heap_viewtype (a:vt0p) = fibheap (a)

(* ****** ****** *)

implement
linheap_is_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx0, _) => if node2ptr (nx0) > 0 then false else true
//
end // end of [linheap_is_nil]

implement
linheap_isnot_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx0, _) => if node2ptr (nx0) > 0 then true else false
//
end // end of [linheap_isnot_nil]

(* ****** ****** *)
//
// HX: implementing mergeable-heap operations
//
(* ****** ****** *)

extern
fun{a:vt0p}
compare_elt_node (x1: &a, nx2: node0 (a)):<> int
extern
fun{a:vt0p}
compare_node_node (nx1: node0 (a), nx2: node0 (a)):<> int

(* ****** ****** *)

implement{a}
linheap_insert
  (hp, x0) = let
in
//
case+ hp of
| @FIBHEAP (nx0, N) => let
    var x0: a = x0
    val sgn =
      compare_elt_node<a> (x0, nx0)
    // end of [val]
    val nx2 = node_make_elt (x0)
    val nxs = node2nodelst0 (nx0)
    val _(*nxs*) = nodelst_add (nxs, nx2)
    val () = if :(nx0: node0 (a)) => sgn < 0 then nx0 := nx2
    val () = N := N + 1
    prval () = fold@ (hp)
  in
    // nothing
  end // end of [FIBHEAP]
//
end // end of [linheap_insert]

(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp) = let
in
//
case+ hp of
| FIBHEAP (nx0, _) => node2ptr (nx0)
//
end // end of [linheap_getmin_ref]

(* ****** ****** *)

implement{a}
linheap_merge
  (hp1, hp2) = hp1 where {
//
val @FIBHEAP (nx01, N1) = hp1
val ~FIBHEAP (nx02, N2) = hp2
//
val sgn = compare_node_node<a> (nx01, nx02)
val () = if :(nx01: node0 (a)) => (0 < sgn) then nx01 := nx02
//
val nxs1 = node2nodelst0 (nx01)
val nxs2 = node2nodelst0 (nx02)
val _(*nxs*) = nodelst_union (nxs1, nxs2)
//
val () = N1 := N1 + N2
//
val () = fold@ (hp1)
//
} // end of [linheap_merge]

(* ****** ****** *)

(* linheap_fibonacci.dats *)
