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
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./timer.dats"

(* ****** ****** *)
//
extern
fun the_timer_start (): void
extern
fun the_timer_finish (): void
extern
fun the_timer_pause (): void
extern
fun the_timer_resume (): void
extern
fun the_timer_reset (): void
//
extern
fun the_timer_get_ntick (): double // obtaining the number of ticks
//
(* ****** ****** *)

local

val t0 = timer_new ()

in (* in-of-local *)

implement
the_timer_start
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = timer_start (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_start] *)

implement
the_timer_finish
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = timer_finish (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_finish] *)

implement
the_timer_pause
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = timer_pause (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_pause] *)

implement
the_timer_resume
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = timer_resume (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_resume] *)

implement
the_timer_reset
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = timer_reset (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

implement
the_timer_get_ntick
  ((*void*)) = ntick where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ntick = timer_get_ntick (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

end // end of [local]

(* ****** ****** *)

(* end of [the_timer.dats] *)
