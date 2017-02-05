(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** HX-2014-06-02: Start it now!
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "./../SATS/nwaiter.sats"
//
(* ****** ****** *)
//
staload "./../SATS/parallelize.sats"
//
(* ****** ****** *)

implement
{}(*tmp*)
intrange_parallelize
(
  start
, finish
, cutoff, nw
) = let
//
vtypedef
ticket = nwaiter_ticket
//
fun segmentize
(
  m: int, n: int, cutoff: int, tick: ticket
) : void = let
  val m2 = m + cutoff
in
//
if
m2 >= n
then let
  val ((*void*)) = 
  intrange_parallelize$submit
  (
    llam () =>
    (
      intrange_parallelize$loop<>(m, n); nwaiter_ticket_put(tick)
    )
  ) (* end of [intrange_parallelize$submit] *)
in
  // nothing
end // end of [then]
else let
  val tick2 =
  nwaiter_ticket_split(tick)
  val ((*void*)) =
  intrange_parallelize$submit
  (
    llam () =>
    (
      intrange_parallelize$loop<>(m, m2); nwaiter_ticket_put(tick2)
    )
  ) (* end of [intrange_parallelize$submit] *)
in
  segmentize(m2, n, cutoff, tick)
end // end of [else]
//
end // end of [segmentize]
//
val tick = nwaiter_initiate(nw)
val ((*void*)) = segmentize(start, finish, cutoff, tick)
val ((*void*)) = nwaiter_waitfor(nw)
//
in
  // nothing
end // end of [intrange_parallelize]

(* ****** ****** *)

(* end of [parallelize.dats] *)
