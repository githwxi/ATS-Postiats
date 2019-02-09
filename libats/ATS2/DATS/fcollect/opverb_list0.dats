(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2018 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: January, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#staload "./opverb.dats"
#staload "libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

implement
(a:tflt)
streamize_vt<list0(a)><a>
  (xs) =
(
  auxmain(xs)
) where
{
fun
auxmain
(
xs: list0(a)
) : stream_vt(a) =
$ldelay
(
case+ xs of
| list0_nil() =>
  stream_vt_nil()
| list0_cons(x0, xs) =>
  stream_vt_cons(x0, auxmain(xs))
)
} (* end of [streamize_vt] *)

(* ****** ****** *)
//
implement
(a:tflt)
forall<list0(a)><a>(xs) =
(
  loop(xs)
) where
{
fun
loop(xs: list0(a)) =
(
case+ xs of
| list0_nil() => true
| list0_cons(x0, xs) =>
  if forall$test<a>(x0) then loop(xs) else false
)
//
} (* end of [forall<list0(a)><a>] *)
//
(* ****** ****** *)

(* end of [opverb_list0.sats] *)
