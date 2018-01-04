(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: January, 2018 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#staload "libats/ML/SATS/basis.sats"
#staload "libats/ML/SATS/list0_vt.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
list0_vt_free
  (xs) =
(
  list_vt_free<a>(xs)
) where
{
val xs = $UN.castvwtp0(xs)
}

(* ****** ****** *)

implement
{a}(*tmp*)
list0_vt_append
  (xs, ys) = let
//
val xs = $UN.castvwtp0(xs)
val ys = $UN.castvwtp0(ys)
//
in
  $UN.castvwtp0
  (list_vt_append<a>(xs, ys))
end // end of [list0_vt_append]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_vt_reverse
  (xs) = let
//
val xs = $UN.castvwtp0(xs)
//
in
  $UN.castvwtp0(list_vt_reverse<a>(xs))
end // end of [list0_vt_append]

(* ****** ****** *)

(* end of [list0_vt.dats] *)

