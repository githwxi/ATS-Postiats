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
//
typedef
intrange = $FC.intrange
//
(* ****** ****** *)
//
implement
{}(*tmp*)
$FC.intrange_make_int
  (x) = $FC.INTRANGE(0, x)
implement
{}(*tmp*)
$FC.intrange_make_int2
  (l, r) = $FC.INTRANGE(l, r)
//
(* ****** ****** *)

implement
$FC.streamize_vt<intrange><int>
  (xs) = let
//
val
$FC.INTRANGE
  (l, r) = xs
//
fun
auxmain
( l: int
, r: int
) : stream_vt(int) = $ldelay
(
  if
  (l < r)
  then
  (
    stream_vt_cons(l, auxmain(l+1, r))
  )
  else stream_vt_nil()
)
//
in
  $effmask_all(auxmain(l, r))
end (* end of [$FC.streamize_vt] *)

(* ****** ****** *)
//
implement
$FC.forall<intrange><int>
  (xs) =
  loop(l, r) where
{
//
val
$FC.INTRANGE
  (l, r) = xs
//
fun
loop
( l: int
, r: int): bool =
(
if (
l < r
) then (
  if $FC.forall$test<int>(l) then loop(l+1, r) else false
) else true // end of [if]
)
//
} (* end of [$FC.forall] *)
//
(* ****** ****** *)
//
implement
$FC.rforall<intrange><int>
  (xs) =
  loop(l, r) where
{
//
val
$FC.INTRANGE
  (l, r) = xs
//
fun
loop
( l: int
, r: int): bool =
(
if (
l < r
) then let
//
val r1 = r-1
//
in
  if $FC.rforall$test<int>(r1) then loop(l, r1) else false
end else true // end of [if]
)
//
} (* end of [$FC.rforall] *)
//
(* ****** ****** *)

(* end of [fcntainer_intrange.dats] *)
