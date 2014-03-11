(*
** A simple timer (that is, a stopwatch)
*)

(* ****** ****** *)

(*
** Copyright (C) 2011 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2014-03-10: ported to ATS2 from the version in INT2PROGINATS
//
(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

absvtype timer_vtype
vtypedef timer = timer_vtype

(* ****** ****** *)
//
extern
fun{} timer_new (): timer // creating a timer object
extern
fun{} timer_free (x: timer): void // destroying a timer object
extern
fun{} timer_start (x: !timer): void // the timer starts
extern
fun{} timer_finish (x: !timer): void // the timer finishes
extern
fun{} timer_pause (x: !timer): void // the timer pauses
extern
fun{} timer_resume (x: !timer): void // the (paused) timer resumes
extern
fun{} timer_reset (x: !timer): void // the timer resets
extern
fun{} timer_get_ntick (x: !timer): uint // obtaining the number of ticks
//
(* ****** ****** *)

typedef
timer_struct = @{
  started= bool // the timer has started
, running= bool // the timer is running
  // the tick number recorded
, ntick_beg= uint // when the timer was turned on
, ntick_acc= uint // the number of accumulated ticks
} (* end of [timer_struct] *)

(* ****** ****** *)
//
(*
extern
castfn timer_objfize
  {l:addr} (timer_struct@l | ptr l): (mfree_ngc_v (l) | timer)
extern
castfn timer_unobjfize
  {l:addr} (mfree_ngc_v (l) | timer): (timer_struct @ l | ptr l)
*)
//
(* ****** ****** *)
//
datavtype timer =
  | TIMER of (timer_struct)
//
(* ****** ****** *)

assume timer_vtype = timer

(* ****** ****** *)

implement{
} timer_new () = let
//
val timer = TIMER (_)
val+TIMER (x) = timer
//
val () = x.started := false
val () = x.running := false
val () = x.ntick_beg := 0u
val () = x.ntick_acc := 0u
//
prval () = fold@ (timer)
//
in
  timer
end // end of [timer_new]

(* ****** ****** *)

implement{
} timer_free (timer) =
  let val+~TIMER _ = timer in (*nothing*) end
// end of [timer_free]

(* ****** ****** *)

extern
fun{} the_current_tick_get ((*void*)): uint

(* ****** ****** *)

implement{
} timer_start
  (timer) = let
  val+@TIMER(x) = timer
  val () = x.started := true
  val () = x.running := true
  val () = x.ntick_beg := the_current_tick_get ()
  val () = x.ntick_acc := 0u
  prval () = fold@ (timer)
in
  // nothing
end // end of [timer_start]

(* ****** ****** *)

implement{
} timer_finish
  (timer) = let
  val+@TIMER(x) = timer
  val () = x.started := false
  val () =
  if x.running then
  {
    val () = x.running := false
    val () = x.ntick_acc :=
      x.ntick_acc + the_current_tick_get () - x.ntick_beg
  } (* end of [val] *)
  prval () = fold@ (timer)
in
  // nothing
end // end of [timer_finish]

(* ****** ****** *)

implement{
} timer_pause
  (timer) = let
  val+@TIMER(x) = timer
  val () =
  if x.running then
  {
    val () = x.running := false
    val () = x.ntick_acc :=
      x.ntick_acc + the_current_tick_get () - x.ntick_beg
  } (* end of [val] *)
  prval () = fold@ (timer)
in
  // nothing
end // end of [timer_pause]

(* ****** ****** *)

implement{
} timer_resume
  (timer) = let
  val+@TIMER(x) = timer
  val () =
  if x.started && ~(x.running) then
  {
    val () = x.running := true
    val () = x.ntick_beg := the_current_tick_get ()
  } (* end of [if] *) // end of [val]
  prval () = fold@ (timer)
in
  // nothing
end // end of [timer_resume]

(* ****** ****** *)

implement{
} timer_reset
  (timer) = let
  val+@TIMER(x) = timer
  val () = x.started := false
  val () = x.running := false
  val () = x.ntick_beg := 0u
  val () = x.ntick_acc := 0u
  prval () = fold@ (timer)
in
  // nothing
end // end of [timer_reset]

(* ****** ****** *)

implement{
} timer_get_ntick
  (timer) = let
  val+@TIMER(x) = timer
  var ntick: uint = x.ntick_acc
  val () =
  if x.running then (
    ntick := ntick + the_current_tick_get () - x.ntick_beg
  ) (* end of [if] *) // end of [val]
  prval () = fold@ (timer)
in
  ntick
end // end of [timer_get_ntick]

(* ****** ****** *)

local

staload "libc/SATS/time.sats"

in (* in-of-local *)

implement{
} the_current_tick_get () = let
  var tv: timespec // uninitialized
  val err = clock_gettime (CLOCK_REALTIME, tv)
  val () = assertloc (err >= 0)
  prval () = opt_unsome {timespec} (tv)
in
  $UN.cast2uint(tv.tv_sec)
end // end of [the_current_tick_get]

end // end of [local]

(* ****** ****** *)

staload US = "libc/SATS/unistd.sats"

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val timer = timer_new ()
//
val () = timer_start (timer)
//
val ntick = timer_get_ntick (timer)
val () = println! ("ntick(0) = ", ntick)
val err = $US.sleep (1u)
val () = timer_pause (timer)
val ntick = timer_get_ntick (timer)
val () = println! ("ntick(1) = ", ntick)
val err = $US.sleep (1u) // this one is not counted!
val () = timer_resume (timer)
val err = $US.sleep (1u)
val ntick = timer_get_ntick (timer)
val () = println! ("ntick(2) = ", ntick)
//
val () = timer_finish (timer)
//
val ((*freed*)) = timer_free (timer)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [timer.dats] *)
