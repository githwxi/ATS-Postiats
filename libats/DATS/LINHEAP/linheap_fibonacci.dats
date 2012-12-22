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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

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

extern
fun{a:vt0p}
gnode_get_rank (nx: gnode1 (INV(a))):<> int
extern
fun{a:vt0p}
gnode_set_rank (nx: gnode1 (INV(a)), d: int):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_get_marked (nx: gnode1 (INV(a))):<> bool
extern
fun{a:vt0p}
gnode_get_marked (nx: gnode1 (INV(a)), mark: bool):<!wrt> void

(* ****** ****** *)

datavtype
fibheap (a:viewt@ype+) =
  | FIBHEAP (a) of (gnode0 (a), size_t(*size*))
// end of [fibheap]

(* ****** ****** *)

assume heap_viewtype (a:vt0p) = fibheap (a)

(* ****** ****** *)

implement{a}
linheap_is_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => gnode_is_null (nx)
//
end // end of [linheap_is_nil]

implement{a}
linheap_isnot_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => gnode_isnot_null (nx)
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
compare_elt_gnode
  (x1: &a, nx2: gnode0 (a)):<> int
implement{a}
compare_elt_gnode
  (x1, nx2) = let
in
//
if gnode2ptr (nx2) > 0 then let
  val [l2:addr]
    p_x2 = gnode_getref_elt (nx2)
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
end // end of [compare_elt_gnode]

extern
fun{a:vt0p}
compare_gnode_gnode
  (nx1: gnode0 (a), nx2: gnode0 (a)):<> int
// end of [compare_gnode_gnode]

(* ****** ****** *)

implement{a}
linheap_insert
  (hp, x0) = let
//
val @FIBHEAP (nx0, N) = hp
//
var x0: a = x0
val sgn = compare_elt_gnode<a> (x0, nx0)
//
val nx2 = gnode_make_elt (x0)
val () =
  if gnode2ptr (nx0) > 0 then
    gnode_insert_next (nx0, nx2) else gnode_link (nx2, nx2)
  // end of [if]
//
val () = if :(nx0: gnode0 (a)) => sgn < 0 then nx0 := nx2
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
  case+ hp of FIBHEAP (nx, _) => gnode2ptr (nx)
// end of [linheap_getmin_ref]

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_insert_next_circlst
  (nx1: gnode1 (a), nxs2: gnode0 (a)): void
// end of [gnode_insert_prev_circlst]

extern
fun{a:vt0p}
gnode_insert_prev_circlst
  (nx1: gnode1 (a), nxs2: gnode0 (a)): void
// end of [gnode_insert_prev_circlst]

(* ****** ****** *)

implement{a}
linheap_merge
  (hp1, hp2) = hp1 where {
//
val @FIBHEAP (nx1, N1) = hp1
val ~FIBHEAP (nx2, N2) = hp2
//
val sgn = compare_gnode_gnode<a> (nx1, nx2)
val () =
  if gnode2ptr (nx1) > 0 then
    gnode_insert_next_circlst (nx1, nx2) else ()
  // end of [if]
//
val () = if :(nx1: gnode0 (a)) => (0 < sgn) then nx1 := nx2
val () = N1 := N1 + N2
//
prval () = fold@ (hp1)
//
} // end of [linheap_merge]

(* ****** ****** *)

extern
fun{a:vt0p}
gnodelst_set_parent_null (nxs: gnode0 (a)): void

(* ****** ****** *)

extern
fun{a:vt0p}
gnodelst_consolidate (nxs: gnode0 (a)): gnode0 (a)

(* ****** ****** *)

implement{a}
linheap_delmin
  (hp0, res) = let
//
val @FIBHEAP (nx0_ref, N) = hp0
//
in
//
if N > 0SZ then let
  val nx0 = nx0_ref
  val nx0 = 
    $UN.cast{gnode1(a)} (nx0)
  val nxs2 = gnode_get_children (nx0)
  val () = gnodelst_set_parent_null (nxs2)
//
  val () = gnode_insert_next_circlst (nx0, nxs2)
//
  val nx1 = gnode_get_next (nx0)
  val () = gnode_free_elt (nx0, res)
  val nx1 = gnodelst_consolidate (nx1)
//
  val () = N := pred (N)
  val () = nx0_ref := nx1
//
  prval () = opt_some {a} (res)
  prval () = fold@ (hp0)
//
in
  true (*removed*)
end else let
  prval () =
    opt_none {a} (res)
  prval () = fold@ (hp0)
in
  false (*~removed*)
end // end of [if]
//
end // end of [linheap_delmin]

(* ****** ****** *)

(* linheap_fibonacci.dats *)
