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
//
abst@ype input_t0ype
abst@ype output_t0ype
//
(* ****** ****** *)
//
typedef input = input_t0ype
typedef output = output_t0ype
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$solve(input): output
and
DivideConquer$solve_rec(input): output
//
extern
fun{}
DivideConquer$solve$eval : (input) -> output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$base_test(x0: input): bool
//
extern
fun{}
DivideConquer$base_solve(x0: input): output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$divide(x0: input): list0(input)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$conquer
  (x0: input, xs: list0(input)): output
//
extern
fun{}
DivideConquer$conquer$combine
  (x0: input, rs: list0(output)): output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$solve$memo_get : (input) -> Option_vt(output)
extern
fun{}
DivideConquer$solve$eval$memo_set : (input, output) -> void
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer$solve
  (x0) = let
//
val opt =
  DivideConquer$solve$memo_get<>(x0)
//
in
  case+ opt of
  | ~Some_vt(r0) => r0
  | ~None_vt((*void*)) =>
     DivideConquer$solve$eval<>(x0)
end // end of [DivideConquer$solve]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$solve_rec
  (x0) = DivideConquer$solve<>(x0)
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer$solve$eval
  (x0) = let
//
val
test =
DivideConquer$base_test<>(x0)
//
in (* in-of-let *)
//
if
(test)
then
DivideConquer$base_solve<>(x0)
else r0 where
{
  val xs = DivideConquer$divide<>(x0)
  val r0 = DivideConquer$conquer<>(x0, xs)
  val () = DivideConquer$solve$eval$memo_set<>(x0, r0)
} (* end of [else] *)
//
end // end of [DivideConquer$solve$eval]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$solve$memo_get
  (x0) = None_vt()
//
implement
{}(*tmp*)
DivideConquer$solve$eval$memo_set
  (x0, r0) = ((*void*))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$conquer
  (x0, xs) = r0 where
{
//
val rs =
list0_map<input><output>
( xs
, lam(x) => DivideConquer$solve_rec<>(x)
) (* end of [val] *)
//
val r0 = DivideConquer$conquer$combine<>(x0, rs)
//
} (* end of [DivideConquer$conquer] *)
//
(* ****** ****** *)

(* end of [DivideConquer.dats] *)
