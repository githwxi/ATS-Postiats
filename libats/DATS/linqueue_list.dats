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

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

staload "libats/SATS/linqueue_list.sats"

(* ****** ****** *)

stadef qstruct = queue_struct

(* ****** ****** *)

datavtype
queue (
  a:viewt@ype+
) =
  QUEUE of (gnode0(a), gnode0(a))
// end of [datavtype]

assume queue_viewtype (a:vt0p, n:int) = queue (a)

(* ****** ****** *)

implement{a}
queue_make () = q where {
  val (
    pf, pfgc | p
  ) = ptr_alloc<qstruct> ()
  val (pfngc | q) = queue_make_ngc (pf | p)
  prval () = free_gcngc_v_nullify (pfgc, pfngc)
} // end of [queue_make]

(* ****** ****** *)

implement{a}
queue_is_empty
  {n} (q) = let
  val QUEUE (nx0, nx1) = q
in
  $UN.cast{bool(n==0)} (gnode_is_null (nx0))
end // end of [queue_is_empty]

implement{a}
queue_isnot_empty
  {n} (q) = let
  val+ QUEUE (nx0, nx1) = q
in
  $UN.cast{bool(n > 0)} (gnode_isnot_null (nx0))
end // end of [queue_is_empty]

(* ****** ****** *)

implement{a}
queue_insert
  {n} (q, x) = let
  val+ @QUEUE (nx0, nx1) = q
  val isnot = gnode_isnot_null (nx1)
  val nx2 = gnode_make_elt (x)
in
//
if isnot then let
  val () = gnode_link (nx1, nx2)
  val () = nx1 := nx2
  prval () = fold@ (q)
in
  // nothing
end else let
  val () = nx0 := nx2
  val () = nx1 := nx2
  prval () = fold@ (q)
in
  // nothing
end // end of [if]
//  
end // end of [queue_insert]

(* ****** ****** *)

implement{a}
queue_remove
  {n} (q) = let
//
var res: a?
//
val+ @QUEUE (nx0, nx1) = q
val nx0_ = $UN.cast{gnode1(a)}(nx0)
val neq = gnode2ptr (nx0) != gnode2ptr (nx1)
//
in
//
if neq then let
  val () = nx0 := gnode_get_next (nx0_)
  prval () = fold@ (q)
  val () = gnode_free_elt (nx0_, res)
in
  res
end else let
  val () = nx0 := gnode_null<a> ()
  val () = nx1 := gnode_null<a> ()
  prval () = fold@ (q)
  val () = gnode_free_elt (nx0_, res)
in
  res
end // end of [if]
//  
end // end of [queue_remove]

(* ****** ****** *)

(* end of [linqueue_list.dats] *)
