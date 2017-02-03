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
#define
ATS_PACKNAME
"ATSLIB.libats\
.BUCS320.DivideConquer"
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
extern
fun{}
DivideConquer_cont$conquer
  (xs: list0(input), k0: output -<cloref1> void): void
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer_cont$solve
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
  val xs = DivideConquer$divide<>(x0)
  val () = DivideConquer_cont$conquer<>(xs, k0)
} (* end of [else] *)
//
end // end of [DivideConquer_cont$solve]


(* ****** ****** *)

(* end of [DivideConquer_parallel.dats] *)
