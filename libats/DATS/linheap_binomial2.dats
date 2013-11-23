(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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

#define ATS_PACKNAME "ATSLIB.libats.linheap_binomial2"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"
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

typedef
g2node (a:vt0p, l:addr) = gnode (mytkind, a, l)
typedef g2node0 (a:vt0p) = gnode0 (mytkind, a)
typedef g2node1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)

extern
fun{a:vt0p}
g2node_make_elt (x: a):<!wrt> g2node1 (a)

(* ****** ****** *)

extern
fun{a:t0p}
g2node_free (nx: g2node1 (INV(a))):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
g2node_free_elt
  (nx: g2node1 (INV(a)), res: &a? >> a):<!wrt> void
// end of [g2node_free_elt]

(* ****** ****** *)

extern
fun{a:vt0p}
g2node_get_rank (nx: g2node1 (INV(a))):<> int
extern
fun{a:vt0p}
g2node_set_rank (nx: g2node1 (INV(a)), r: int):<!wrt> void

extern
fun{a:vt0p}
g2node_get_parent (nx: g2node1 (INV(a))):<> g2node0 (a)
extern
fun{a:vt0p}
g2node_set_parent (nx: g2node1 (INV(a)), par: g2node0 (a)):<!wrt> void
extern
fun{a:vt0p}
g2node_set_parent_null (nx: g2node1 (INV(a))):<!wrt> void

extern
fun{a:vt0p}
g2node_get_children (nx: g2node1 (INV(a))):<> g2node0 (a)
extern
fun{a:vt0p}
g2node_set_children (nx: g2node1 (INV(a)), nxs: g2node0 (a)):<!wrt> void
extern
fun{a:vt0p}
g2node_set_children_null (nx: g2node1 (INV(a))):<!wrt> void

(* ****** ****** *)

extern
fun{a:vt0p}
g2nodelst_cons (nx: g2node1 (INV(a)), nxs: g2node0 (a)):<!wrt> g2node1 (a)

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_compare
  (nx1: g2node1 (a), nx2: g2node1 (a)):<> int
implement{a}
gnode_compare
  (nx1, nx2) = sgn where {
  val p_x1 = gnode_getref_elt (nx1)
  val (
    pf1, fpf1 | p_x1
  ) = $UN.cptr_vtake (p_x1)
  val p_x2 = gnode_getref_elt (nx2)
  val (
    pf2, fpf2 | p_x2
  ) = $UN.cptr_vtake (p_x2)
  val sgn = compare_elt_elt<a> (!p_x1, !p_x2)
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
} // end of [gnode_compare]

(* ****** ****** *)

extern
fun{a:vt0p}
gnode_compare01
  (nx1: g2node0 (a), nx2: g2node1 (a)):<> int
implement{a}
gnode_compare01
  (nx1, nx2) =
  if gnode_isnot_null (nx1) then gnode_compare<a> (nx1, nx2) else 1
// end of [gnode_compare01]

extern
fun{a:vt0p}
gnode_compare10
  (nx1: g2node1 (a), nx2: g2node0 (a)):<> int
implement{a}
gnode_compare10
  (nx1, nx2) =
  if gnode_isnot_null (nx2) then gnode_compare<a> (nx1, nx2) else ~1
// end of [gnode_compare10]

(* ****** ****** *)
//
// HX-2013-08:
// [nx1] and [nx2] are of the same rank
//
extern
fun{a:vt0p}
join_gnode_gnode
  (nx1: g2node1 (a), nx2: g2node1 (a)):<!wrt> void
implement{a}
join_gnode_gnode
  (nx1, nx2) = let
  val r = g2node_get_rank (nx1)
  val () = g2node_set_rank (nx1, r+1)
  val () = g2node_set_parent (nx2, nx1)
  val () = gnode_link10 (nx2, g2node_get_children (nx1))
  val () = g2node_set_children (nx1, nx2)
in
  // nothing
end // end of [join_gnode_gnode]

(* ****** ****** *)

extern
fun{a:vt0p}
merge_gnode_gnode
(
  nx1: g2node1 (a), nx2: g2node1 (a)
) :<!wrt> g2node1 (a) // endfun
implement{a}
merge_gnode_gnode
  (nx1, nx2) = let
  val sgn = gnode_compare<a> (nx1, nx2)
in
  if sgn < 0 then let
    val () = join_gnode_gnode<a> (nx1, nx2) in nx1
  end else let
    val () = join_gnode_gnode<a> (nx2, nx1) in nx2
  end // end of [if]
end // end of [merge_gnode_gnode]

(* ****** ****** *)

extern
fun{a:vt0p}
merge_gnode_gnodelst
(
  nx1: g2node1 (a), r1: int, nxs2: g2node0 (a)
) :<!wrt> g2node1 (a) // endfun
implement{a}
merge_gnode_gnodelst
  (nx1, r1, nxs2) = let
//
val iscons = gnodelst_is_cons (nxs2)
//
in
//
if iscons then let
  val nx2 = nxs2
  val r2 = g2node_get_rank (nx2)
in
  if r1 < r2 then
    g2nodelst_cons (nx1, nxs2)
  else let // HX: r1 = r2
    val nxs2 = gnode_get_next (nx2)
    val nx1 = merge_gnode_gnode<a> (nx1, nx2)
  in
    merge_gnode_gnodelst<a> (nx1, r1+1, nxs2)
  end // end of [if]
end else
  g2nodelst_cons (nx1, nxs2)
// end of [if]
//
end // end of [merge_gnode_gnodelst]

(* ****** ****** *)

(*
** HX-2012-12:
** pre-condition for merging_gnodelst_gnodelst:
** both [nxs1] and [nxs2] are sorted ascendingly
** according to ranks of binomial trees
*)
extern
fun{a:vt0p}
merge_gnodelst_gnodelst
(
  nxs1: g2node0 (a), nxs2: g2node0 (a)
) :<!wrt> g2node0 (a) // endfun
implement{a}
merge_gnodelst_gnodelst
  (nxs1, nxs2) = let
//
fun loop
(
  nxs1: g2node0 (a), nxs2: g2node0 (a), res: Ptr1
) : void = let
in
//
if gnode_isnot_null (nxs1) then (
  if gnode_isnot_null (nxs2) then let
    val nx1 = nxs1
    val r1 = g2node_get_rank (nx1)
    val nx2 = nxs2
    val r2 = g2node_get_rank (nx2)
  in
    if r1 < r2 then let
      val () =
        $UN.ptr1_set<g2node1(a)> (res, nx1)
      val res = gnode_getref_next (nx1)
      val nxs1 = $UN.cptr_get<g2node0(a)> (res)
    in
      loop (nxs1, nxs2, cptr2ptr (res))
    end else if r1 > r2 then let
      val () = 
        $UN.ptr1_set<g2node1(a)> (res, nx2)
      val res = gnode_getref_next (nx2)
      val nxs2 = $UN.cptr_get<g2node0(a)> (res)
    in
      loop (nxs1, nxs2, cptr2ptr (res))
    end else let // r1 = r2
      val nxs1 = gnode_get_next (nx1)
      val nxs2 = gnode_get_next (nx2)
      val nx1 = merge_gnode_gnode<a> (nx1, nx2)
      val nxs1 = merge_gnode_gnodelst<a> (nx1, r1+1, nxs1)
    in
      loop (nxs1, nxs2, res)
    end // end of [if]
  end else $UN.ptr1_set<g2node0(a)> (res, nxs1)
) else $UN.ptr1_set<g2node0(a)> (res, nxs2)
//
end // end of [loop]
//
var res: g2node0(a)
val () = $effmask_all (loop (nxs1, nxs2, addr@(res)))
//
in
  $UN.cast{g2node0(a)} (res)
end // end of [merge_gnodelst_gnodelst]

(* ****** ****** *)

(*
assume
heap_vtype (a:vt0p) = g2node0 (a)
*)

(* ****** ****** *)

implement{}
linheap_nil{a} () =
  $UN.castvwtp1{heap(a)}(gnode_null())
// end of [linheap_nil]

(* ****** ****** *)
//
implement{}
linheap_is_nil{a} (hp) =
  gnodelst_is_nil ($UN.castvwtp1{g2node0(a)}(hp))
implement{}
linheap_isnot_nil{a} (hp) =
  gnodelst_is_cons ($UN.castvwtp1{g2node0(a)}(hp))
//
(* ****** ****** *)

implement{a}
linheap_size (hp) = let
//
fun loop
(
  nxs: g2node0(a), res: size_t
) : size_t = let
//
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
  val nx = nxs
  val r = g2node_get_rank (nx)
  val r = $UN.cast{intGte(0)}(r)
  val nsz = g0uint_lsl_size ((i2sz)1, r)
  val nxs = gnode_get_next (nx)
in
  loop (nxs, res + nsz)
end else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop ($UN.castvwtp1{g2node0(a)}(hp), i2sz(0)))
end // end of [linheap_size]

(* ****** ****** *)
  
implement{a}
linheap_insert
  (hp0, x0) = let
//
val nx = g2node_make_elt<a> (x0)
//
val () = gnode_set_next_null (nx)
//
val () = g2node_set_rank (nx, 0)
val () = g2node_set_parent_null (nx)
val () = g2node_set_children_null (nx)
//
val nxs = $UN.castvwtp0{g2node0(a)}(hp0)
val nxs = merge_gnode_gnodelst<a> (nx, 0, nxs)
val () = hp0 := $UN.castvwtp0{heap(a)}(nxs)
//
in
  // nothing
end // end of [linheap_insert]

(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp0) = let
//
fun loop (
  nx0: g2node1 (a), nxs: g2node0 (a)
) : g2node0 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nxs = gnode_get_next (nx)
  val sgn = gnode_compare<a> (nx0, nx)
in
  if sgn <= 0 then loop (nx0, nxs) else loop (nx, nxs)
end else nx0 // end of [if]
//
end // end of [loop]
//
var nxs =
  $UN.castvwtp1{g2node0(a)}(hp0)
val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nxs = gnode_get_next (nx)
  val nx_min = loop (nx, nxs)
in
  $UN.cast{cPtr1(a)}(nx_min)
end else
  $UN.cast{cPtr0(a)}(the_null_ptr)
// end of [if]
//
end // end of [linheap_getmin_ref]

(* ****** ****** *)

implement{a}
linheap_delmin
  (hp0, res) = let
//
fun loop (
  nxs_ref: Ptr1, nx0_ref: Ptr1, nx0: g2node1 (a)
) : g2node1 (a) = let
  val nxs =
    $UN.ptr1_get<g2node0(a)> (nxs_ref)
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nx_ref = nxs_ref
  val nxs_ref = gnode_getref_next (nx)
  val nxs_ref = cptr2ptr (nxs_ref)
  val sgn = gnode_compare01<a> (nx0, nx)
in
  if sgn <= 0 then
    loop (nxs_ref, nx0_ref, nx0) else loop (nxs_ref, nx_ref, nx)
  // end of [if]
end else let
  val () = $UN.ptr1_set<g2node0(a)> (nx0_ref, gnode_get_next (nx0))
in
  nx0
end // end of [if]
//
end // end of [loop]
//
fun auxrev
(
  nxs: g2node0 (a)
) : g2node0 (a) = let
//
fun loop (
  nxs: g2node0 (a), res: g2node0 (a)
) : g2node0 (a) = let
  val isnot = gnode_isnot_null (nxs)
in
//
if isnot then let
  val nx = nxs
  val () = g2node_set_parent_null (nx)
  val nxs = gnode_get_next (nx)
in
  loop (nxs, g2nodelst_cons (nx, res))
end else res // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop (nxs, gnode_null ()))
end // end of [auxrev]
//
var nxs0 =
  $UN.castvwtp0{g2node0(a)}(hp0)
val iscons = gnodelst_is_cons (nxs0)
//
in
//
if iscons then let
  val nx0 = nxs0
  val nx0_ref = addr@(nxs0)
  val nxs_ref = gnode_getref_next (nx0)
  val nxs_ref = cptr2ptr (nxs_ref)
//
  val nx_min = loop (nxs_ref, nx0_ref, nx0)
//
  val nxs_min = g2node_get_children (nx_min)
  val ((*void*)) = g2node_free_elt (nx_min, res)
//
  val nxs_min = auxrev (nxs_min)
  val nxs0 = merge_gnodelst_gnodelst<a> (nxs0, nxs_min)
  val () = hp0 := $UN.castvwtp0{heap(a)}(nxs0)
//
  prval () = opt_some{a}(res)
//
in
  true
end else let
//
  val () = hp0 := $UN.castvwtp0{heap(a)}(the_null_ptr)
//
  prval () = opt_none{a}(res)
//
in
  false
end // end of [if]
//
end // end of [linheap_delmin]

(* ****** ****** *)

implement
{a}(*tmp*)
linheap_merge
  (hp1, hp2) = let
  val nxs1 = $UN.castvwtp0{g2node0(a)}(hp1)
  val nxs2 = $UN.castvwtp0{g2node0(a)}(hp2)
  val nxs12 = merge_gnodelst_gnodelst<a> (nxs1, nxs2)
in
  $UN.castvwtp0{heap(a)}(nxs12)
end // end of [linheap_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
linheap_freelin
  (hp) = let
//
fun auxfree
(
  nx: g2node0(a)
) : void = let
//
val isnot = gnode_isnot_null (nx)
//
in
//
if isnot then let
  val nxs = g2node_get_children (nx)
  val ((*void*)) = auxfree (nxs)
  val nx2 = gnode_get_next (nx)
  val cp = gnode_getref_elt (nx)
  val (pf, fpf | p) = $UN.cptr_vtake (cp)
  val ((*void*)) = linheap_freelin$clear<a> (!p)
  val ((*void*)) = $extfcall (void, "ATS_MFREE", $UN.castvwtp0{ptr}((pf, fpf | p)))
in
  auxfree (nx2)
end else () // end of [if]
//
end // end of [auxfree]
//
in
  $effmask_all (auxfree ($UN.castvwtp0{g2node0(a)}(hp)))
end // end of [linheap_freelin]

(* ****** ****** *)
//
// HX: functions for processing g2nodes
//
(* ****** ****** *)

vtypedef
hpnode_struct
(
  elt: vt0p
) = // sknode_struct
@{
  elt= elt, rank= int, next= ptr, parent= ptr, children= ptr
} (* end of [hpnode_struct] *)

(* ****** ****** *)

extern
castfn
__cast_hpnode
  {a:vt0p}{l:agz}
(
  nx: g2node (INV(a), l)
) :<> [l:addr]
(
  hpnode_struct (a) @ l
, hpnode_struct (a) @ l -<lin,prf> void
| ptr l
) // end of [__cast_hpnode]

(* ****** ****** *)

implement{a}
g2node_make_elt (x) = let
//
val (
  pf, pfgc | p
) = ptr_alloc<hpnode_struct(a)> ()
//
val () = p->elt := x
//
in
  $UN.castvwtp0{g2node1(a)}((pf, pfgc | p))
end // end of [g2node_make_elt]

(* ****** ****** *)

implement{a}
g2node_free (nx) =
(
  $extfcall (void, "ATS_MFREE", $UN.cast{ptr}(nx))
) // end of [g2node_free]

(* ****** ****** *)

implement{a}
g2node_free_elt (nx, res) = let
//
val (pf, fpf | p) = __cast_hpnode (nx)
val () = res := p->elt
//
in
  $extfcall (void, "ATS_MFREE", $UN.castvwtp0{ptr}((pf, fpf | p)))
end // end of [g2node_free_elt]

(* ****** ****** *)

implement{a}
g2node_get_rank
  (nx) = r where
{
//
val (pf, fpf | p) = __cast_hpnode (nx)
val r = p->rank
prval () = fpf (pf)
} // end of [g2node_get_rank]

implement{a}
g2node_set_rank (nx, r) = let
//
val (pf, fpf | p) = __cast_hpnode (nx)
val () = p->rank := r
prval () = fpf (pf)
//
in
  // nothing
end // end of [g2node_set_rank]

(* ****** ****** *)

implement{a}
g2node_get_parent (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val p_parent = p->parent
prval () = fpf (pf)
//
in
  $UN.cast{g2node0(a)}(p_parent)
end // end of [g2node_get_parent]

implement{a}
g2node_set_parent (nx, nx2) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val () = p->parent := $UN.cast{ptr}(nx2)
prval () = fpf (pf)
//
in
  // nothing
end // end of [g2node_set_parent]

implement{a}
g2node_set_parent_null (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val () = p->parent := $UN.cast{ptr}(the_null_ptr)
prval () = fpf (pf)
//
in
  // nothing
end // end of [g2node_set_parent_null]

(* ****** ****** *)

implement{a}
g2node_get_children (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val p_children = p->children
prval () = fpf (pf)
//
in
  $UN.cast{g2node0(a)}(p_children)
end // end of [g2node_get_children]

implement{a}
g2node_set_children (nx, nx2) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val () = p->children := $UN.cast{ptr}(nx2)
prval () = fpf (pf)
//
in
  // nothing
end // end of [g2node_set_children]

implement{a}
g2node_set_children_null (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val () = p->children := $UN.cast{ptr}(the_null_ptr)
prval () = fpf (pf)
//
in
  // nothing
end // end of [g2node_set_children_null]

(* ****** ****** *)

implement{a}
g2nodelst_cons (nx, nxs) =
  let val () = gnode_link10 (nx, nxs) in nx end
// end of [g2nodelst_cons]

(* ****** ****** *)

implement(a)
gnode_getref_elt<mytkind><a>
  (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val p_elt = addr@(p->elt)
prval () = fpf (pf)
//
in
  $UN.cast{cPtr1(a)}(p_elt)
end // end of [gnode_getref_elt]

(* ****** ****** *)

implement(a)
gnode_getref_next<mytkind><a>
  (nx) = let
val (pf, fpf | p) = __cast_hpnode (nx)
val p_next = addr@(p->next)
prval () = fpf (pf)
//
in
  $UN.cast{cPtr1(g2node0(a))}(p_next)
end // end of [g2node_getref_next]

(* ****** ****** *)

implement(a)
gnode_link10<mytkind><a>
  (nx1, nx2) = gnode_set_next (nx1, nx2)
// end of [gnode_link10]

implement(a)
gnode_link11<mytkind><a>
  (nx1, nx2) = gnode_set_next (nx1, nx2)
// end of [gnode_link11]

(* ****** ****** *)

(* linheap_binomial2.dats *)
