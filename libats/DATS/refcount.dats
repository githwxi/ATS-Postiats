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
(* Start time: July, 2013 *)

(* ****** ****** *)
//
// HX: For supporting ref-counted resourse.
// HX: This implementation does not support locked counting
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/refcount.sats"

(* ****** ****** *)
//
datavtype
refcnt(a:vt@ype) =
  | REFCNT (a) of (uint, a)
//
(* ****** ****** *)

assume
refcnt_vt0ype_vtype(a) = refcnt(a)

(* ****** ****** *)

implement
{a}(*tmp*)
refcnt (x) = REFCNT (1u, x)
implement
{a}(*tmp*)
refcnt_make_elt (x) = REFCNT (1u, x)

(* ****** ****** *)

implement
{a}(*tmp*)
refcnt_get_count
  (rfc) = let
//
val+REFCNT (u, _) = rfc
//
in
  $UN.cast{intGte(1)}(u)
end // end of [refcnt_get_count]

(* ****** ****** *)

implement
{a}(*tmp*)
refcnt_incref
  (rfc) = let
//
val+@REFCNT (u, _) = rfc
val ((*void*)) = u := succ (u)
prval () = fold@(rfc)
//
in
  $UN.castvwtp1{refcnt(a)}(rfc)
end // end of [refcnt_incref]

(* ****** ****** *)

implement
{a}(*tmp*)
refcnt_decref
  (rfc, x0) = let
//
val+@REFCNT (u, x) = rfc
val u1 = pred (u)
//
in
//
if
isgtz(u1)
then let
  val ((*void*)) = u := u1
  prval () = fold@(rfc)
  prval () = $UN.cast2void (rfc)
  prval () = opt_none{a}(x0)
in
  false
end else let
  val () = x0 := x
  val ((*freed*)) = free@(rfc)
  prval () = opt_some{a}(x0)
in
  true
end // end of [if]
//
end // end of [refcnt_decref]

implement
{a}(*tmp*)
refcnt_decref_opt
  (rfc) = let
//
var x0: a?
val ans = refcnt_decref (rfc, x0)
//
in (* in of [let] *)
//
if ans
then let
  prval () = opt_unsome{a}(x0) in Some_vt{a}(x0)
end else let
  prval () = opt_unnone{a}(x0) in None_vt{a}((*void*))
end // end of [if]
//
end // end of [refcnt_decref_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
refcnt_vtakeout
  (rfc) = let
//
val+@REFCNT (_, x) = rfc
val p_x = addr@x
prval () = fold@(rfc)
//
val (pf, fpf | p_x) = $UN.ptr_vtake{a}(p_x)
//
in
  (pf, fpf | p_x)
end // end of [refcnt_vtakeout]

(* ****** ****** *)

(* end of [refcount.dats] *)
