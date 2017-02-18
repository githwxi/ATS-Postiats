(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: February, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
// HX:
// DivideConquer_cont:
// This one is of CPS-style
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats\
.BUCS320.DivideConquer"
//
(* ****** ****** *)
//
#staload
UNSAFE =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)

#staload "./DivideConquer.dats"

(* ****** ****** *)
//
extern
fun{}
DivideConquer_cont$solve
  (x0: input, k0: output -<cloref1> void): void
//
extern
fun{}
DivideConquer_cont$solve$eval
  (x0: input, k0: output -<cloref1> void): void
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer_cont$conquer
(
x0: input, xs: list0(input), k0: list0(output) -<cloref1> void
) : void // end of [DivideConquer_cont$conquer]
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer$solve
  (x0) = let
//
var res: output
//
val ((*void*)) =
DivideConquer_cont$solve<>
( x0
, lam(r0) =>
  $UNSAFE.ptr0_set<output>
    (addr@res, r0)
  // end of [$UNSAFE.ptr0_set]
) (* end of [val] *)
//
in
  $UNSAFE.ptr0_get<output>(addr@res)
end // end of [DivideConquer$solve]

(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer_cont$solve
  (x0, k0) = let
//
val opt =
  DivideConquer$solve$memo_get<>(x0)
//
in
  case+ opt of
  | ~Some_vt(r0) => k0(r0)
  | ~None_vt((*void*)) =>
     DivideConquer_cont$solve$eval<>(x0, k0)
end // end of [DivideConquer_cont$solve]

(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer_cont$solve$eval
  (x0, k0) = let
//
val
test =
DivideConquer$base_test<>(x0)
//
in (* in-of-let *)
//
if
(test)
then k0(DivideConquer$base_solve(x0))
else () where
{
  val xs =
  DivideConquer$divide<>(x0)
  val () =
  DivideConquer_cont$conquer<>
  ( x0, xs
  , lam(rs) => k0(r0) where
    {
      val r0 = DivideConquer$conquer$combine<>(x0, rs)
      val () = DivideConquer$solve$eval$memo_set<>(x0, r0)
    } // end of [where] // end of [lam]
  )
  // end of [val]
} (* end of [else] *)
//
end // end of [DivideConquer_cont$solve]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer_cont$conquer
  (x0, xs, k0) = let
//
fun
conquer:
$d2ctype
(
DivideConquer_cont$conquer<>
) = lam(x0, xs, k0) =>
(
case+ xs of
| list0_nil() =>
  k0(list0_nil())
| list0_cons(x, xs) =>
  DivideConquer_cont$solve<>
  ( x
  , lam(r) => conquer(x0, xs, lam(rs) => k0(list0_cons(r, rs)))
  )
)
in
  conquer(x0, xs, k0)
end (* end of [DivideConquer_cont$conquer] *)
//
(* ****** ****** *)

(* end of [DivideConquer_cont.dats] *)
