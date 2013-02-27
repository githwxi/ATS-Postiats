(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

staload
UN = "prelude/SATS/unsafe.sats"
// staload

(* ****** ****** *)

staload "libats/SATS/linqueue_list.sats"

(* ****** ****** *)

implement{a}
queue_make (
) = que where {
  val (
    pf, pfgc | p
  ) = ptr_alloc<qstruct> ()
  val que = ptr2ptrlin (p)
  val () = qstruct_initize (!p)
  prval pfngc = qstruct_objfize (pf | que)
  prval () = free_gcngc_v_nullify (pfgc, pfngc)
} // end of [queue_make]

(* ****** ****** *)

implement{a}
queue_insert
  {n} (q, x) = let
  val nx = mynode_make_elt (x)
in
  queue_insert_ngc {n} (q, nx)
end // end of [queue_insert]

implement{a}
qstruct_insert
  {n} (q, x) = let
//
val pq = addr@(q)
val q2 = ptr2ptrlin (pq)
prval pfngc =
  qstruct_objfize (view@(q) | q2)
val () = queue_insert<a> (q2, x)
prval pfat = qstruct_unobjfize (pfngc | pq, q2)
prval () = view@(q) := pfat
prval () = ptrlin_free (q2)
//
in
  // nothing
end // end of [qstruct_insert]

(* ****** ****** *)

implement{a}
queue_takeout
  {n} (q) = res where {
  var res: a
  val nx = queue_takeout_ngc {n} (q)
  val () = mynode_free_elt (nx, res)
} // end of [queue_takeout]

implement{a}
qstruct_takeout
  {n} (q) = res where {
//
val pq = addr@(q)
val q2 = ptr2ptrlin (pq)
prval pfngc =
  qstruct_objfize (view@(q) | q2)
val res = queue_takeout<a> (q2)
prval pfat = qstruct_unobjfize (pfngc | pq, q2)
prval () = view@(q) := pfat
prval () = ptrlin_free (q2)
//
} // end of [qstruct_takeout]

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

stadef
mykind = $extkind"atslib_libqueue_list"

(* ****** ****** *)

typedef gnode
  (a:vt0p, l:addr) = gnode (mykind, a, l)
// end of [gnode]
typedef gnode0 (a:vt0p) = gnode0 (mykind, a)
typedef gnode1 (a:vt0p) = gnode1 (mykind, a)

(* ****** ****** *)

datavtype
myqueue (
  a:vt@ype+
) =
  MYQUEUE of (gnode0(a), ptr)
// end of [datavtype]

assume
queue_vtype (a:vt0p, n:int) = myqueue (a)

(* ****** ****** *)

implement{a}
queue_is_empty
  {n} (q) = let
  val+ @MYQUEUE (nxf, p_nxr) = q
  val isemp = (addr@ (nxf) = p_nxr)
  prval () = fold@ (q)
in
  $UN.cast{bool(n==0)} (isemp)
end // end of [queue_is_empty]

implement{a}
queue_isnot_empty
  {n} (q) = let
  val+ @MYQUEUE (nxf, p_nxr) = q
  val isnot = (addr@ (nxf) != p_nxr)
  prval () = fold@ (q)
in
  $UN.cast{bool(n > 0)} (isnot)
end // end of [queue_isnot_empty]

(* ****** ****** *)

assume
mynode_vtype (a:vt0p, l:addr) = gnode (a, l)

(* ****** ****** *)

implement{a}
queue_insert_ngc
  {n} (q, nx0) = let
//
//
val @MYQUEUE (nxf, p_nxr) = q
val nx0 = $UN.castvwtp0{gnode1(a)} (nx0)
val () = $UN.ptr0_set<gnode1(a)> (p_nxr, nx0)
val () = p_nxr := gnode_getref_next (nx0)
prval () = fold@ (q)
//  
in
  // nothing
end // end of [queue_insert_ngc]

(* ****** ****** *)

implement{a}
queue_takeout_ngc
  {n} (q) = nx0 where {
//
val @MYQUEUE (nxf, p_nxr) = q
val nx0 = $UN.cast{gnode1(a)}(nxf)
val iseq = (p_nxr = gnode_getref_next (nx0))
val () = if iseq then p_nxr := addr@ (nxf)
prval () = fold@ (q)
//
} // end of [queue_takeout_ngc]

(* ****** ****** *)

implement{a}
queue_takeout_list
  {n} (q) = let
//
val @MYQUEUE (nxf, p_nxr) = q
val () = $UN.ptr0_set<List_vt(a)> (p_nxr, list_vt_nil)
val nx0 = nxf
val () = p_nxr := addr@ (nxf)
prval () = fold@ (q)
//
in
  $UN.castvwtp0{list_vt(a,n)} (nx0)
end // end of [queue_takeout_list]

(* ****** ****** *)

(* end of [linqueue_list.dats] *)
