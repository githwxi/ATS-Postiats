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
queue_insert
  {n} (q, x) = let
  val nx = mynode_make_elt (x)
in
  queue_insert_ngc {n} (q, nx)
end // end of [queue_insert]

implement{a}
queue_takeout
  {n} (q) = res where {
  var res: a
  val nx = queue_takeout_ngc {n} (q)
  val () = mynode_free_elt (nx, res)
} // end of [queue_takeout]

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

datavtype
myqueue (
  a:viewt@ype+
) =
  MYQUEUE of (gnode0(a), gnode0(a))
// end of [datavtype]

assume
queue_viewtype (a:vt0p, n:int) = myqueue (a)

(* ****** ****** *)

implement{a}
queue_make (
) = q where {
  val (
    pf, pfgc | p
  ) = ptr_alloc<queue_struct> ()
  val (pfngc | q) = queue_make_ngc (pf | p)
  prval () = free_gcngc_v_nullify (pfgc, pfngc)
} // end of [queue_make]

(* ****** ****** *)

implement{a}
queue_make_ngc
  {l} (pfat | p) = let
//
extern
praxi __assert
  : (ptr l) -<prf> (free_gc_v l, free_ngc_v l)
//
prval (pfgc, pfngc) = __assert (p)
val q = $UN.castvwtp0 {myqueue(a)} @(pfat, pfgc | p)
val @MYQUEUE (nxf, nxr) = q
val () = nxf := gnode_null<a> ()
val () = nxr := gnode_null<a> ()
prval () = fold@ (q)
//
in
  (pfngc | q)
end // end of [queue_make_ngc]

(* ****** ****** *)

implement{a}
queue_is_empty
  {n} (q) = let
  val+ MYQUEUE (nx0, nx1) = q
in
  $UN.cast{bool(n==0)} (gnode_is_null (nx0))
end // end of [queue_is_empty]

implement{a}
queue_isnot_empty
  {n} (q) = let
  val+ MYQUEUE (nx0, nx1) = q
in
  $UN.cast{bool(n > 0)} (gnode_isnot_null (nx0))
end // end of [queue_isnot_empty]

(* ****** ****** *)

assume
mynode_viewtype (a:vt0p,l:addr) = gnode (a, l)

(* ****** ****** *)

implement{a}
queue_insert_ngc
  {n} (q, nx0) = let
//
val nx0 =
  $UN.castvwtp0{gnode1(a)} (nx0)
//
val @MYQUEUE (nxf, nxr) = q
val isnot = gnode_isnot_null (nxf)
//
in
//
if isnot then let
  val () = gnode_link (nx0, nxf)
  val () = nxf := nx0
  prval () = fold@ (q)
in
  // nothing
end else let
  val () = nxf := nx0
  val () = nxr := nx0
  prval () = fold@ (q)
in
  // nothing
end // end of [if]
//  
end // end of [queue_insert_ngc]

(* ****** ****** *)

implement{a}
queue_takeout_ngc
  {n} (q) = let
//
val @MYQUEUE (nxf, nxr) = q
val nx0 = $UN.cast{gnode1(a)}(nxf)
val neq = gnode2ptr (nxf) != gnode2ptr (nxr)
//
in
//
if neq then let
  val () = nxf := gnode_get_next (nx0)
  prval () = fold@ (q)
in
  nx0
end else let
  val () = nxf := gnode_null<a> ()
  val () = nxr := gnode_null<a> ()
  prval () = fold@ (q)
in
  nx0
end // end of [if]
//  
end // end of [queue_takeout_ngc]

(* ****** ****** *)

(* end of [linqueue_list.dats] *)
