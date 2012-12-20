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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: December, 2012
//
(* ****** ****** *)
//
// HX: generic nodes: singly-linked, doubly-linked, parental
//
(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

implement{a}
gnode_prev_null
  (nx) = gnode_set_prev (nx, gnode_null ())
// end of [gnode_prev_null]

implement{a}
gnode_next_null
  (nx) = gnode_set_next (nx, gnode_null ())
// end of [gnode_next_null]

(* ****** ****** *)

implement{a}
gnode_reverse (nx) = let
//
fun loop (
  nx: gnode (a), res: gnode1 (a)
) : gnode1 (a) = let
  val isnot = gnode_isnot_null (nx)
in
//
if isnot then let
  val nx_next =
    gnode_get_next (nx)
  // end of [val]
  val () = gnode_link (nx, res)
in
  loop (nx_next, nx)
end else let
  val () = gnode_prev_null (res) in res
end // end of [if]
//
end // end of [loop]
//
val isnot = gnode_isnot_null (nx)
//
in
//
if isnot then let
  val nx_next =
    gnode_get_next (nx)
  val () = gnode_next_null (nx)
in
  $effmask_all (loop (nx_next, nx))
end else
  gnode_null () // nx = null
// end of [if]
//
end // end of [gnode_reverse]

(* ****** ****** *)

implement{a}
gnode_slink
  (nx1, nx2) = gnode_set_next (nx1, nx2)
// end of [gnode_slink]

(* ****** ****** *)

implement{a}
gnode_dlink
  (nx1, nx2) = let
  val () = gnode_set_next (nx1, nx2)
  val () = gnode_set_prev (nx2, nx1)
in
  // nothing
end // end of [gnode_dlink]

implement{a}
gnode_dlink00
  (nx1, nx2) = let
  val () =
    if gnode_isnot_null (nx1) then gnode_set_next (nx1, nx2)
  val () =
    if gnode_isnot_null (nx2) then gnode_set_prev (nx2, nx1)
  // end of [val]
in
  // nothing
end // end of [gnode_dlink00]

implement{a}
gnode_dlink01
  (nx1, nx2) = let
  val () =
    if gnode_isnot_null (nx1) then gnode_set_next (nx1, nx2)
  // end of [val]
  val () = gnode_set_prev (nx2, nx1)
in
  // nothing
end // end of [gnode_dlink01]

implement{a}
gnode_dlink10
  (nx1, nx2) = let
  val () = gnode_set_next (nx1, nx2)
  val () =
    if gnode_isnot_null (nx2) then gnode_set_prev (nx2, nx1)
  // end of [val]
in
  // nothing
end // end of [gnode_dlink10]

(* ****** ****** *)

implement{a}
gnode_dinsert_prev
  (nx1, nx2) = let
  val nx1_prev = gnode_get_prev (nx1)
  val () = gnode_dlink (nx2, nx1)
  val () = gnode_dlink01 (nx1_prev, nx2)
in
  // nothing
end // end of [gnode_dinsert_prev]

implement{a}
gnode_dinsert_next
  (nx1, nx2) = let
  val nx1_next = gnode_get_next (nx1)
  val () = gnode_dlink (nx1, nx2)
  val () = gnode_dlink10 (nx2, nx1_next)
in
  // nothing
end // end of [gnode_dinsert_next]

(* ****** ****** *)

implement{a}
gnode_dremove_prev (nx) = let
//
val nx_prev = gnode_get_prev (nx)
val isnot = gnode_isnot_null (nx_prev)
val () =
  if isnot then let
  val nx_prev2 = gnode_get_prev (nx_prev) in gnode_dlink01 (nx_prev2, nx)
end // end of [of] // end of [val]
//
in
  nx_prev
end // end of [gnode_dremove_prev]

implement{a}
gnode_dremove_next (nx) = let
//
val nx_next = gnode_get_next (nx)
val isnot = gnode_isnot_null (nx_next)
val () =
  if isnot then let
  val nx_next2 = gnode_get_next (nx_next) in gnode_dlink10 (nx, nx_next2)
end // end of [of] // end of [val]
//
in
  nx_next
end // end of [gnode_dremove_next]

(* ****** ****** *)

(* end of [gnode.dats] *)
