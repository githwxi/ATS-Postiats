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
(* Start time: March, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.BUCS520.DivideConquerLazy"
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
DivideConquerLazy$solve
  (x0: input): stream_vt(output)
and
DivideConquerLazy$solve_rec
  (x0: input): stream_vt(output)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquerLazy$base_test(x0: input): bool
//
extern
fun{}
DivideConquerLazy$base_solve(x0: input): stream_vt(output)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquerLazy$divide(x0: input): stream_vt(input)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquerLazy$conquer
  (x0: input, xs: stream_vt(input)): stream_vt(output)
//
extern
fun{}
DivideConquerLazy$conquer$combine
  (x0: input, rs: stream_vt(stream_vt(output))): stream_vt(output)
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquerLazy$solve
  (x0) = let
//
val
test =
DivideConquerLazy$base_test<>(x0)
//
in (* in-of-let *)
//
if
(test)
then
DivideConquerLazy$base_solve<>(x0)
else r0 where
{
  val xs =
    DivideConquerLazy$divide<>(x0)
  // end of [val]
  val r0 =
    DivideConquerLazy$conquer<>(x0, xs)
  // end of [val]
} (* end of [else] *)
//
end // end of [DivideConquerLazy$solve]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquerLazy$solve_rec
  (x0) = DivideConquerLazy$solve<>(x0)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquerLazy$conquer
  (x0, xs) = r0 where
{
//
vtypedef
outstream = stream_vt(output)
//
val rs =
stream_vt_map<input><outstream>
  (xs) where
{
//
implement
stream_vt_map$fopr<input><outstream>
  (x) = DivideConquerLazy$solve_rec<>(x)
//
} (* end of [val] *)
//
val r0 =
DivideConquerLazy$conquer$combine<>(x0, rs)
//
} (* end of [DivideConquerLazy$conquer] *)
//
(* ****** ****** *)
(*
//
// HX-2017-03-27:
// this is a very common implementation
// when divide-and-conquer is used for DFS:
//
*)
(*
//
implement
{}(*tmp*)
DivideConquerLazy$conquer$combine
  (x0, rs) = stream_vt_concat<output>(rs)
//
*)
(* ****** ****** *)

(* end of [DivideConquerLazy.dats] *)
