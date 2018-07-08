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
//
// Author: Hongwei Xi
// Start Time: December, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload FC =
"libats/ATS2/SATS/fcntainer.sats"
//
(* ****** ****** *)

implement
(a:t@ype)
$FC.forall<list0(a)><a>
  (xs) =
  loop(xs) where
{
//
fun
loop(xs: list0(a)): bool =
(
case+ xs of
| list0_nil() => true
| list0_cons(x, xs) =>
  (
    if $FC.forall$test<a>(x) then loop(xs) else false
  ) (* list0_cons *)
)
//
} (* end of [$FC.forall] *)

(* ****** ****** *)

implement
(a)(*tmp*)
$FC.rforall<list0(a)><a>
  (xs) =
  auxlst(xs) where
{
//
fun
auxlst(xs: list0(a)): bool =
(
case+ xs of
| list0_nil() => true
| list0_cons(x, xs) =>
  (
    if auxlst(xs) then $FC.rforall$test<a>(x) else false
  ) (* list0_cons *)
)
//
} (* end of [$FC.rforall] *)

(* ****** ****** *)

(* end of [fcntainer_list0.dats] *)
