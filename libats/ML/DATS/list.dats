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
(* Start time: December, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

#staload "libats/ML/SATS/list.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_tuple_0() = list_nil()
//
implement
{a}(*tmp*)
list_tuple_1(x0) = $list{a}(x0)
implement
{a}(*tmp*)
list_tuple_2(x0, x1) = $list{a}(x0, x1)
implement
{a}(*tmp*)
list_tuple_3(x0, x1, x2) = $list{a}(x0, x1, x2)
//
implement
{a}(*tmp*)
list_tuple_4
(x0, x1, x2, x3) = $list{a}(x0, x1, x2, x3)
implement
{a}(*tmp*)
list_tuple_5
(x0, x1, x2, x3, x4) = $list{a}(x0, x1, x2, x3, x4)
implement
{a}(*tmp*)
list_tuple_6
(x0, x1, x2, x3, x4, x5) = $list{a}(x0, x1, x2, x3, x4, x5)
//
(* ****** ****** *)

(* end of [list.dats] *)
