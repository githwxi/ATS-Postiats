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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: December, 2012
//
(* ****** ****** *)
//
// HX: generic nodes: singly-linked, doubly-linked, ...
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

implement{
} gnode_null
  {tk}{a}() = $UN.cast{gnode(tk,a,null)}(nullp)
// end of [gnode_null]

(* ****** ****** *)

implement{
} gnode_is_null
  {tk}{a}{l}(nx) = let
  val p = $UN.cast{ptr}(nx) in $UN.cast{bool(l==null)}(p = nullp)
end // end of [gnode_is_null]

implement{}
gnode_isnot_null
  {tk}{a}{l}(nx) = let
  val p = $UN.cast{ptr}(nx) in $UN.cast{bool(l > null)}(p > nullp)
end // end of [gnode_isnot_null]

(* ****** ****** *)

implement
{tk}{elt}
gnode_get_elt
  (nx) = let
  val p = gnode_getref_elt (nx) in $UN.cptr_get<elt> (p)
end // end of [gnode_get_elt]

implement
{tk}{elt}
gnode_set_elt
  (nx, x0) = let
  val p = gnode_getref_elt (nx) in $UN.cptr_set<elt> (p, x0)
end // end of [gnode_set_elt]

(* ****** ****** *)

implement
{tk}{elt}
gnode_get_next
  (nx) = nx2 where {
  val p = gnode_getref_next (nx)
  val nx2 = $UN.cptr_get<gnode0(tk,elt)> (p)
} // end of [gnode_get_next]

implement
{tk}{elt}
gnode_set_next
  (nx, nx2) = () where {
  val p = gnode_getref_next (nx)
  val () = $UN.cptr_set<gnode(tk,elt)> (p, nx2)
} // end of [gnode_set_next]

implement
{tk}{elt}
gnode0_set_next
  (nx, nx2) = let
in
  if gnode_isnot_null (nx) then gnode_set_next (nx, nx2)
end // end of [gnode0_set_next]

(* ****** ****** *)

implement
{tk}{elt}
gnode_set_next_null
  (nx) = gnode_set_next (nx, gnode_null ())
// end of [gnode_set_next_null]

implement
{tk}{elt}
gnode0_set_next_null (nx) = let
in
  if gnode_isnot_null (nx) then gnode_set_next_null (nx)
end // end of [gnode0_set_next_null]

(* ****** ****** *)

implement
{tk}{elt}
gnode_get_prev
  (nx) = nx2 where {
  val p = gnode_getref_prev (nx)
  val nx2 = $UN.cptr_get<gnode0(tk,elt)> (p)
} // end of [gnode_get_prev]

implement
{tk}{elt}
gnode_set_prev
  (nx, nx2) = () where {
  val p = gnode_getref_prev (nx)
  val () = $UN.cptr_set<gnode(tk,elt)> (p, nx2)
} // end of [gnode_set_prev]

implement
{tk}{elt}
gnode0_set_prev
  (nx, nx2) = let
in
  if gnode_isnot_null (nx) then gnode_set_prev (nx, nx2)
end // end of [gnode0_set_prev]

(* ****** ****** *)

implement
{tk}{elt}
gnode_set_prev_null
  (nx) = gnode_set_prev (nx, gnode_null ())
// end of [gnode_set_prev_null]

implement
{tk}{elt}
gnode0_set_prev_null (nx) = let
in
  if gnode_isnot_null (nx) then gnode_set_prev_null (nx)
end // end of [gnode0_set_prev_null]

(* ****** ****** *)

(*
implement
{tk}{elt}
gnode_link = gnode_link11
*)

implement
{tk}{elt}
gnode_link00
  (nx1, nx2) = let
  val () = gnode0_set_next (nx1, nx2)
  val () = gnode0_set_prev (nx2, nx1)
in
  // nothing
end // end of [gnode_link00]

implement
{tk}{elt}
gnode_link01
  (nx1, nx2) = let
  val () = gnode0_set_next (nx1, nx2)
  val () = gnode_set_prev (nx2, nx1)
in
  // nothing
end // end of [gnode_link01]

implement
{tk}{elt}
gnode_link10
  (nx1, nx2) = let
  val () = gnode_set_next (nx1, nx2)
  val () = gnode0_set_prev (nx2, nx1)
  // end of [val]
in
  // nothing
end // end of [gnode_link10]

implement
{tk}{elt}
gnode_link11
  (nx1, nx2) = let
  val () = gnode_set_next (nx1, nx2)
  val () = gnode_set_prev (nx2, nx1)
in
  // nothing
end // end of [gnode_link11]

(* ****** ****** *)

implement
{tk}{elt}
gnode_insert_next
  (nx1, nx2) = let
  val nx1_next = gnode_get_next (nx1)
  val () = gnode_link11 (nx1, nx2)
  val () = gnode_link10 (nx2, nx1_next)
in
  // nothing
end // end of [gnode_insert_next]

implement
{tk}{elt}
gnode_insert_prev
  (nx1, nx2) = let
  val nx1_prev = gnode_get_prev (nx1)
  val () = gnode_link11 (nx2, nx1)
  val () = gnode_link01 (nx1_prev, nx2)
in
  // nothing
end // end of [gnode_insert_prev]

(* ****** ****** *)

implement
{tk}{elt}
gnode_remove
  (nx) = nx where {
//
val nx_prev = gnode_get_prev (nx)
val nx_next = gnode_get_next (nx)
//
val () = gnode_link00 (nx_prev, nx_next)
//
} // end of [gnode_remove]

implement
{tk}{elt}
gnode_remove_next (nx) = let
//
val nx_next = gnode_get_next (nx)
val isnot = gnode_isnot_null (nx_next)
val () =
  if isnot then let
  val nx_next2 = gnode_get_next (nx_next) in gnode_link10 (nx, nx_next2)
end // end of [of] // end of [val]
//
in
  nx_next
end // end of [gnode_remove_next]

implement
{tk}{elt}
gnode_remove_prev (nx) = let
//
val nx_prev = gnode_get_prev (nx)
val isnot = gnode_isnot_null (nx_prev)
val () =
  if isnot then let
  val nx_prev2 = gnode_get_prev (nx_prev) in gnode_link01 (nx_prev2, nx)
end // end of [of] // end of [val]
//
in
  nx_prev
end // end of [gnode_remove_prev]

(* ****** ****** *)

implement
{tk}{elt}
gnodelst_length (nxs) = let
//
typedef gnode0 = gnode0 (tk, elt)
//
fun loop (
  nxs: gnode0, len: intGte(0)
) : intGte(0) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nxs = gnode_get_next (nxs)
in
  loop (nxs, succ (len))
end else (len) // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop (nxs, 0))
end // end of [gnodelst_length]

(* ****** ****** *)

implement
{tk}{elt}
gnodelst_rlength (nxs) = let
//
typedef gnode1 = gnode1 (tk, elt)
//
fun loop (
  nxs: gnode1, len: intGte(0)
) : intGte(0) = let
  val nxs2 = gnode_get_prev (nxs)
  val iscons = gnodelst_is_cons (nxs2)
in
  if iscons then loop (nxs2, succ (len)) else len
end // end of [loop]
//
val iscons = gnodelst_is_cons (nxs)
//
in
  if iscons then $effmask_all (loop (nxs, 0)) else 0
end // end of [gnodelst_rlength]

(* ****** ****** *)

implement
{tk}{elt}
gnodelst_next_all (nxs) = let
//
fun loop (
  nxs: gnode1 (tk, elt)
) : gnode1 (tk, elt) = let
  val nxs_next = gnode_get_next (nxs)
in
  if gnodelst_is_cons (nxs_next) then loop (nxs_next) else nxs
end // end of [loop]
//
in
  $effmask_all (loop (nxs))  
end // end of [gnodelst_next_all]

implement
{tk}{elt}
gnodelst_prev_all (nxs) = let
//
fun loop (
  nxs: gnode1 (tk, elt)
) : gnode1 (tk, elt) = let
  val nxs_prev = gnode_get_prev (nxs)
in
  if gnodelst_is_cons (nxs_prev) then loop (nxs_prev) else nxs
end // end of [loop]
//
in
  $effmask_all (loop (nxs))
end // end of [gnodelst_prev_all]

(* ****** ****** *)

(* end of [gnode.dats] *)
