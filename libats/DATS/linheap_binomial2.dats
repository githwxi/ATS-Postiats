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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

staload "libats/SATS/linheap_binomial.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
// HX-2012-12-21:
// the file should be included here
// before [heap_vtype] is assumed
//
#include "./SHARE/linheap.hats" // code reuse
//
(* ****** ****** *)

macdef assertloc_debug (x) = ()

(* ****** ****** *)

stadef
mytkind = $extkind"atslib_linheap_binomial2"

(* ****** ****** *)

typedef gnode
  (a:vt0p, l:addr) = gnode (mytkind, a, l)
// end of [gnode]
typedef gnode0 (a:vt0p) = gnode0 (mytkind, a)
typedef gnode1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_make_elt (x: a):<!wrt> gnode1 (a)

extern
fun{a:vt0p}
gnode_get_rank (nx: gnode1 (a)):<> int
extern
fun{a:vt0p}
gnode_set_rank (nx: gnode1 (a), r: int):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_compare
  (nx1: gnode1 (a), nx2: gnode1 (a)):<> int
implement{a}
gnode_compare
  (nx1, nx2) = sgn where {
  val p_x1 = gnode_getref_elt (nx1)
  prval (pf1, fpf1) = $UN.ptr_vtake {a} (p_x1)
  val p_x2 = gnode_getref_elt (nx2)
  prval (pf2, fpf2) = $UN.ptr_vtake {a} (p_x2)
  val sgn = compare_elt_elt<a> (!p_x1, !p_x2)
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
} // end of [gnode_compare]

extern
fun{a:vt0p}
gnode_compare01
  (nx1: gnode0 (a), nx2: gnode1 (a)):<> int
implement{a}
gnode_compare01
  (nx1, nx2) =
  if gnode_isnot_null (nx1) then gnode_compare (nx1, nx2) else 1
// end of [gnode_compare01]

extern
fun{a:vt0p}
gnode_compare10
  (nx1: gnode1 (a), nx2: gnode0 (a)):<> int
implement{a}
gnode_compare10
  (nx1, nx2) =
  if gnode_isnot_null (nx2) then gnode_compare (nx1, nx2) else ~1
// end of [gnode_compare10]

(* ****** ****** *)

extern
fun{a:vt0p}
join_gnode_gnode
  (nx1: gnode1 (a), nx2: gnode1 (a)):<!wrt> void
implement{a}
join_gnode_gnode
  (nx1, nx2) = let
  val r = gnode_get_rank (nx1)
(*
  val () = assertloc_debug (r = gnode_get_rank (nx2))
*)
  val () = gnode_set_rank (nx1, r+1)
  val () = gnode_set_parent (nx2, nx1)
  val () = gnode_link10 (nx2, gnode_get_children (nx1))
  val () = gnode_set_children (nx1, nx2)
in
  // nothing
end // end of [join_gnode_gnode]

extern
fun{a:vt0p}
merge_gnode_gnode
  (nx1: gnode1 (a), nx2: gnode1 (a)):<!wrt> gnode1 (a)
implement{a}
merge_gnode_gnode
  (nx1, nx2) = let
  val sgn = gnode_compare (nx1, nx2)
in
  if sgn < 0 then let
    val () = gnode_link (nx1, nx2) in nx1
  end else let
    val () = gnode_link (nx2, nx1) in nx2
  end // end of [if]
end // end of [merge_gnode_gnode]

(* ****** ****** *)

local

extern
fun{a:vt0p}
merge_gnode_gnodelst
  (nx1: gnode1 (a), r1: int, nxs2: gnode0 (a)):<!wrt> gnode1 (a)
implement{a}
merge_gnode_gnodelst
  (nx1, r1, nxs2) = let
in
//
if gnode2ptr (nxs2) > 0 then let
  val nx2 = nxs2
  val r2 = gnode_get_rank (nx2)
in
  if r1 < r2 then
    gnode_cons (nx1, nxs2)
  else let
    val nxs2 = gnode_get_next (nx2)
    val nx1 = merge_gnode_gnode (nx1, nx2)
  in
    merge_gnode_gnodelst (nx1, r1+1, nxs2)
  end // end of [if]
end else
  gnode_cons (nx1, gnode_null ())
// end of [if]
//
end // end of [merge_gnode_gnodelst]

in // in of [local]

(*
** HX-2012-12:
** pre-condition for merging_gnodelst_gnodelst:
** both [nxs1] and [nxs2] are sorted ascendingly
** according to ranks of binomial trees
*)
extern
fun{a:vt0p}
merge_gnodelst_gnodelst
  (nxs1: gnode0 (a), nxs2: gnode0 (a)):<!wrt> gnode0 (a)
implement{a}
merge_gnodelst_gnodelst
  (nxs1, nxs2) = let
//
fun loop (
  nxs1: gnode0 (a), nxs2: gnode0 (a), res: Ptr1
) : void = let
in
//
if gnode_isnot_null (nxs1) then (
  if gnode_isnot_null (nxs2) then let
    val nx1 = nxs1
    val r1 = gnode_get_rank (nx1)
    val nx2 = nxs2
    val r2 = gnode_get_rank (nx2)
  in
    if r1 < r2 then let
      val () =
        $UN.ptr_set<gnode1(a)> (res, nx1)
      val res = gnode_getref_next (nx1)
      val nxs1 = $UN.ptr_get<gnode0(a)> (res)
    in
      loop (nxs1, nxs2, res)
    end else if r1 > r2 then let
      val () = 
        $UN.ptr_set<gnode1(a)> (res, nx2)
      val res = gnode_getref_next (nx2)
      val nxs2 = $UN.ptr_get<gnode0(a)> (res)
    in
      loop (nxs1, nxs2, res)
    end else let // r1 = r2
      val nxs1 = gnode_get_next (nx1)
      val nxs2 = gnode_get_next (nx2)
      val nx1 = merge_gnode_gnode (nx1, nx2)
      val nxs1 = merge_gnode_gnodelst (nx1, r1+1, nxs1)
    in
      loop (nxs1, nxs2, res)
    end // end of [if]
  end else $UN.ptr_set<gnode0(a)> (res, nxs1)
) else $UN.ptr_set<gnode0(a)> (res, nxs2)
//
end // end of [loop]
//
var res: gnode0(a)
val () = $effmask_all (loop (nxs1, nxs2, addr@ (res)))
//
in
  $UN.cast{gnode0(a)} (res)
end // end of [merge_gnodelst_gnodelst]

end // end of [local]

(* ****** ****** *)

assume heap_vtype (a: vt0p) = gnode0 (a)

(* ****** ****** *)

implement{} linheap_nil () = gnode_null ()

(* ****** ****** *)

implement{}
linheap_is_nil (hp) = gnodelst_is_nil (hp)
implement{}
linheap_isnot_nil (hp) = gnodelst_is_cons (hp)

(* ****** ****** *)
  
implement{a}
linheap_insert
  (hp0, x0) = let
  val nxs = hp0
  val nxs2 = gnode_make_elt (x0)
  val () = hp0 := merge_gnodelst_gnodelst (nxs, nxs2)
in
  // nothing
end // end of [linheap_insert]
  
(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp0) = let
//
fun loop (
  nxs: gnode0 (a), nx0: gnode0 (a)
) : gnode0 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nxs = gnode_get_next (nx)
  val sgn = gnode_compare01 (nx0, nx)
in
  if sgn <= 0 then loop (nxs, nx0) else loop (nxs, nx)
end else nx0 // end of [if]
//
end // end of [loop]
//
var nxs =
  $UN.castvwtp1{gnode0(a)} (hp0)
val nx_min = loop (nxs, gnode_null ())
//
in
  gnode2ptr (nx_min)
end // end of [linheap_getmin_ref]

(* ****** ****** *)

local

fun{a:vt0p}
auxrev (
  nxs: gnode0 (a)
) : gnode0 (a) = let
//
fun loop (
  nxs: gnode0 (a), res: gnode0 (a)
) : gnode0 (a) = let
  val isnot = gnode_isnot_null (nxs)
in
//
if isnot then let
  val nx = nxs
  val () = gnode_set_parent_null (nx)
  val nxs = gnode_get_next (nx)
in
  loop (nxs, gnode_cons (nx, res))
end else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop (nxs, gnode_null ()))
end // end of [auxrev]

in // end of [local]

implement{a}
linheap_delmin
  (hp0, res) = let
//
fun loop (
  nxs_ref: Ptr1, nx0_ref: Ptr1, nx0: gnode1 (a)
) : gnode1 (a) = let
  val nxs =
    $UN.ptr_get<gnode0(a)> (nxs_ref)
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nx_ref = nxs_ref
  val nxs_ref = gnode_getref_next (nx)
  val sgn = gnode_compare01 (nx0, nx)
in
  if sgn <= 0 then
    loop (nxs_ref, nx0_ref, nx0) else loop (nxs_ref, nx_ref, nx)
  // end of [if]
end else let
  val () = $UN.ptr_set<gnode0(a)> (nx0_ref, gnode_get_next (nx0))
in
  nx0
end // end of [if]
//
end // end of [loop]
//
var nxs0 =
  $UN.cast{gnode0(a)} (hp0)
val iscons = gnodelst_is_cons (nxs0)
//
in
//
if iscons then let
  val nx0_ref = addr@ (nxs0)
  val nx0 = nxs0
  val nxs_ref = gnode_getref_next (nx0)
//
  val nx_min = loop (nxs_ref, nx0_ref, nx0)
//
  val nxs_min = gnode_get_children (nx_min)
  val () = gnode_free_elt (nx_min, res)
//
  val nxs_min = auxrev (nxs_min)
  val () = hp0 := merge_gnodelst_gnodelst (nxs0, nxs_min)
//
  prval () = opt_some {a} (res)
//
in
  true
end else let
  prval () = opt_none {a} (res)
in
  false
end // end of [if]
//
end // end of [linheap_delmin]

end // end of [local]

(* ****** ****** *)

implement{a}
linheap_free (hp0) = let
//
fun loop (
  nxs: gnode0 (a)
) : void = let
//
val iscons = gnodelst_is_cons (nxs)
//
in
  if iscons then let
    val nx = nxs
    val nxs = gnode_get_next (nx)
    val () = gnode_free (nx)
  in
    loop (nxs)
  end else () // end of [if]
end // end of [loop]
//
in
  $effmask_all (loop (hp0))
end // end of [linheap_free]

(* ****** ****** *)

(* linheap_binomial2.dats *)
