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
#staload
"libats/ML/SATS/array0.sats"
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
$FC.forall<array0(a)><a>
  (xs) =
  loop(p0,i2sz(0)) where
{
//
val
(p0, n0) =
array0_get_refsize{a}(xs)
val p0 = arrayref2ptr(p0)
//
fun
loop
(p0: ptr, i: Size): bool =
(
if
i >= n0
then true
else let
//
val x0 = $UN.ptr0_get<a>(p0)
//
in
//
if
$FC.forall$test<a>(x0)
then loop(ptr0_succ<a>(p0), i+1) else false
//
end // end of [else]
//
) (* end of [loop] *)
//
} (* end of [$FC.forall] *)

(* ****** ****** *)

implement
(a:t@ype)
$FC.rforall<array0(a)><a>
  (xs) =
  loop(pz,i2sz(0)) where
{
//
val
(p0, n0) =
array0_get_refsize{a}(xs)
val p0 = arrayref2ptr(p0)
val pz =
ptr0_add_guint<a>(p0, n0)
//
fun
loop
(pz: ptr, i: Size): bool =
(
if
i >= n0
then true
else let
//
val pz =
ptr0_pred<a>(pz)
val x0 =
$UN.ptr0_get<a>(pz)
//
in
//
if
$FC.rforall$test<a>(x0)
then loop(pz, i+1) else false
//
end // end of [else]
//
) (* end of [loop] *)
//
} (* end of [$FC.rforall] *)

(* ****** ****** *)

(* end of [fcntainer_array0.dats] *)
