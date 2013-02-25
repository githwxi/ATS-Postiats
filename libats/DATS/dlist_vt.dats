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
(* Start time: Feburary, 2013 *)

(* ****** ****** *)
//
// HX-2013-02: this is a completely new effort
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "libats/SATS/dlist_vt.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

assume
dlist_vtype
  (a:vt@ype, f: int, r: int) = gnode0 (a)
// end of [dlist_vtype]

(* ****** ****** *)

implement{}
dlist_vt_nil () = gnode_null ()

(* ****** ****** *)

implement{a}
dlist_vt_sing (x) =
  dlist_vt_cons<a> (x, dlist_vt_nil ())
// end of [dlist_vt_sing]

(* ****** ****** *)

implement{a}
dlist_vt_cons
  (x, xs) = let
in
  gnode_cons (gnode_make_elt<a> (x), xs)
end // end of [dlist_vt_cons]

(* ****** ****** *)

implement{a}
dist_vt_uncons
  (xs) = let
  val nx = $UN.cast{gnode1(a)} (xs)
  val nx_next = gnode_get_next (nx)
  val () = gnode0_set_prev_null (nx_next)
  val () = xs := nx_next
in
  gnode_getfree_elt (nx)
end // end of [dist_vt_uncons]

(* ****** ****** *)

implement{a}
dlist_vt_length
  {f,r} (xs) = let
in
  $UN.cast{int(r)} (gnodelst_length (xs))
end // end of [dlist_vt_length]

(* ****** ****** *)

implement{a}
dlist_vt_free (xs) = gnodelst_free<a> (xs)

(* ****** ****** *)

datavtype
gnode2 (a:vt@ype+) =
  | GNODE2 of (a, ptr(*next*), ptr(*prev*))
// end of [gnode2]

(* ****** ****** *)

extern
praxi gnode2_vfree {a:vt0p} (nx: gnode2 (a)): void
extern
castfn
gnode_decode {a:vt0p} (nx: gnode (INV(a))):<> gnode2 (a)
extern
castfn
gnode_encode {a:vt0p} (nx: gnode2 (INV(a))):<> gnode (a)

(* ****** ****** *)

implement{a}
gnode_make_elt (x) =
  $UN.castvwtp0{gnode1(a)}(GNODE2 {a} (x, _, _))
// end of [gnode_make_elt]

(* ****** ****** *)

implement{a}
gnode_free (nx) = let
  val nx = gnode_decode (nx)
  val~GNODE2 (_, _, _) = (nx )in (*nothing*)
end // end of [gnode_free]

implement{a}
gnode_free_elt
  (nx, res) = let
  val nx = gnode_decode (nx)
  val~GNODE2 (x, _, _) = (nx); val () = res := x in (*nothing*)
end // end of [gnode_free_elt]

(* ****** ****** *)

implement{a}
gnode_getref_next
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @GNODE2 (_, next, _) = nx
val p_next = addr@ (next)
prval () = fold@ (nx)
prval () = gnode2_vfree (nx)
//
in
  p_next
end // end of [gnode_getref_next]

(* ****** ****** *)

implement{a}
gnode_getref_prev
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @GNODE2 (_, _, prev) = nx
val p_prev = addr@ (prev)
prval () = fold@ (nx)
prval () = gnode2_vfree (nx)
//
in
  p_prev
end // end of [gnode_getref_prev]

(* ****** ****** *)

(* end of [dlist_vt.dats] *)
