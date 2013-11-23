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

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

staload "libats/SATS/dllist.sats"
staload "libats/DATS/dllist.dats"

(* ****** ****** *)

staload "libats/SATS/lindeque_dllist.sats"

(* ****** ****** *)
//
extern
castfn
deque_encode
  : {a:vt0p}{n:int} (g2node0 (INV(a))) -<> deque (a, n)
extern
castfn
deque_decode
  : {a:vt0p}{n:int} (deque (INV(a), n)) -<> g2node0 (a)
//
extern
castfn
deque1_encode
  : {a:vt0p}{n:int | n > 0} (g2node1 (INV(a))) -<> deque (a, n)
extern
castfn
deque1_decode
  : {a:vt0p}{n:int | n > 0} (deque (INV(a), n)) -<> g2node1 (a)
//
(* ****** ****** *)

implement{}
lindeque_nil{a} () = $UN.castvwtp0{deque(a,0)}(nullp)

(* ****** ****** *)
//
implement{}
lindeque_is_nil{a}{n} (dq) =
  $UN.cast{bool(n==0)}($UN.castvwtp1{ptr}(dq) = nullp)
//
implement{}
lindeque_isnot_nil{a}{n} (dq) =
  $UN.cast{bool(n > 0)}($UN.castvwtp1{ptr}(dq) > nullp)
//
(* ****** ****** *)

implement{a}
lindeque_length {n} (dq) = let
//
fun loop
(
  nxs: g2node1 (a), p0: ptr, n: int
) : int = let
  val nxs2 = gnode_get_next (nxs)
  val nxs2 = $UN.cast{g2node1(a)}(nxs2)
in
//
if p0 != gnode2ptr (nxs2) then loop (nxs2, p0, n+1) else n
//
end // end of [loop]
//
prval () = lemma_deque_param (dq)
val isnot = lindeque_isnot_nil (dq)
//
in
//
if isnot then let
  val nxs = $UN.castvwtp1{g2node1(a)}(dq)
  val len = $effmask_all (loop (nxs, gnode2ptr (nxs), 1))
in
  $UN.cast{int(n)}(len)
end else (0) // end of [if]
//
end // end of [lindeque_length]

(* ****** ****** *)

implement{a}
lindeque_insert_at
  (dq, i, x) = let
//
val nx0 =
  g2node_make_elt<a> (x) in lindeque_insert_at_ngc (dq, i, nx0)
//
end // end of [lindeque_insert_at]

implement{a}
lindeque_insert_atbeg
  (dq, x) = let
//
val nx0 =
  g2node_make_elt<a> (x) in lindeque_insert_atbeg_ngc (dq, nx0)
//
end // end of [lindeque_insert_atbeg]

implement{a}
lindeque_insert_atend
  (dq, x) = let
//
val nx0 =
  g2node_make_elt<a> (x) in lindeque_insert_atend_ngc (dq, nx0)
//
end // end of [lindeque_insert_atend]

(* ****** ****** *)

implement{a}
lindeque_takeout_at
  (dq, i) = let
//
val nx = lindeque_takeout_at_ngc (dq, i) in g2node_getfree_elt (nx)
//
end // end of [lindeque_takeout_at]

implement{a}
lindeque_takeout_atbeg
  (dq) = let
//
val nx = lindeque_takeout_atbeg_ngc (dq) in g2node_getfree_elt (nx)
//
end // end of [lindeque_takeout_atbeg]

implement{a}
lindeque_takeout_atend
  (dq) = let
//
val nx = lindeque_takeout_atend_ngc (dq) in g2node_getfree_elt (nx)
//
end // end of [lindeque_takeout_atend]

(* ****** ****** *)

implement{a}
lindeque2dllist {n} (dq) = let
//
val nxs = deque_decode (dq)
val isnot = gnode_isnot_null (nxs)
//
val () =
if isnot then
{
  val nxs2 = gnode_get_prev (nxs)
  val nxs2 = $UN.cast{g2node1(a)}(nxs2)
  val () = gnode_set_prev_null (nxs)
  val () = gnode_set_next_null (nxs2)
} // end of [if]
in
  $UN.castvwtp0{dllist(a,0,n)}(nxs)
end // end of [lindeque2dllist]

(* ****** ****** *)
//
// HX: ngc-functions should not involve malloc/free!
//
(* ****** ****** *)

implement{a}
lindeque_insert_atbeg_ngc
  (dq, nx0) = let
//
val nxs = deque_decode (dq)
val isnul = gnode_is_null (nxs)
//
in
//
if isnul then let
  val () = gnode_link11 (nx0, nx0)
in
  dq := deque_encode (nx0)
end else let
  val () = gnode_insert_prev (nxs, nx0)
in
  dq := deque_encode (nx0)
end // end of [if]
//
end // end of [lindeque_insert_atbeg_ngc]

(* ****** ****** *)

implement{a}
lindeque_insert_atend_ngc
  (dq, nx0) = let
//
val nxs = deque_decode (dq)
val isnul = gnode_is_null (nxs)
//
in
//
if isnul then let
  val () = gnode_link11 (nx0, nx0)
in
  dq := deque_encode (nx0)
end else let
  val () = gnode_insert_prev (nxs, nx0)
in
  dq := deque_encode (nxs)
end // end of [if]
//
end // end of [lindeque_insert_atend_ngc]

(* ****** ****** *)

implement{a}
lindeque_takeout_atbeg_ngc
  (dq) = let
//
val nxs = deque1_decode (dq)
val nxs2 = gnode_get_next (nxs)
//
val p = gnode2ptr (nxs)
val p2 = gnode2ptr (nxs2)
//
val nxs = gnode_remove (nxs)
//
in
//
if (p != p2) then let
  val () = dq := deque_encode (nxs2) in nxs
end else let
  val () = dq := deque_encode (gnode_null ()) in nxs
end // end of [if]
//
end // end of [lindeque_takeout_atbeg_ngc]

(* ****** ****** *)

implement{a}
lindeque_takeout_atend_ngc
  (dq) = let
//
val nxs = deque1_decode (dq)
val nxs2 = gnode_remove_prev (nxs)
val nxs2 = $UN.cast{g2node1(a)}(nxs2)
//
val p = gnode2ptr (nxs)
val p2 = gnode2ptr (nxs2)
//
in
//
if (p != p2) then let
  val () = dq := deque_encode (nxs) in nxs2
end else let
  val () = dq := deque_encode (gnode_null ()) in nxs2
end // end of [if]
//
end // end of [lindeque_takeout_atend_ngc]

(* ****** ****** *)

(* end of [lindeque_dllist.dats] *)
