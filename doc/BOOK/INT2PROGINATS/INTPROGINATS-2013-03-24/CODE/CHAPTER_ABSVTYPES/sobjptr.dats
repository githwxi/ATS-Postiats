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
// Simple Linear Objects in ATS
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

absviewtype
sobjptr (a:viewt@ype+)

extern
fun{a:viewt@ype}
sobjptr_new (): sobjptr (a?)

extern
fun sobjptr_free
  {a:t@ype} (x: sobjptr (a)): void
// end of [sobjptr_free]

(* ****** ****** *)

assume
sobjptr (a:viewt@ype) = [l:addr] @{
  atview= a @ l, gcview= free_gc_v (a?, l), ptr= ptr l
} // end of [sobjptr]

implement{a}
sobjptr_new () = let
  val (pfgc, pfat | p) = ptr_alloc<a> ()
in @{
  atview= pfat, gcview= pfgc, ptr= p
} end // end of [sobjptr_new]

implement
sobjptr_free {a} (pobj) =
  ptr_free (pobj.gcview, pobj.atview | pobj.ptr)
// end of [sobjptr_free]

(* ****** ****** *)

extern
fun sobjptr_init {a:viewt@ype}
  (pobj: !sobjptr (a?) >> sobjptr (a), f: (&a? >> a) -> void): void
// end of [sobjptr_init]

implement
sobjptr_init
  (pobj, f) = let
  prval pfat = pobj.atview
  val () = f !(pobj.ptr)
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [sobjptr_init]

(* ****** ****** *)

extern
fun sobjptr_clear
  {a:viewt@ype} (
  x: !sobjptr (a) >> sobjptr (a?), f: (&a >> a?) -> void
) : void // end of [sobjptr_clear]

implement
sobjptr_clear
  (pobj, f) = let
  prval pfat = pobj.atview
  val () = f !(pobj.ptr)
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [sobjptr_clear]

(* ****** ****** *)
//
// Implementing a timer (that is, a stopwatch)
//
(* ****** ****** *)

absviewtype timerObj

extern
fun timerObj_new (): timerObj // creating a timer object
extern
fun timerObj_free (x: timerObj): void // destroying a timer object
extern
fun timerObj_start (x: !timerObj): void // the timer starts
extern
fun timerObj_finish (x: !timerObj): void // the timer finishes
extern
fun timerObj_pause (x: !timerObj): void // the timer pauses
extern
fun timerObj_resume (x: !timerObj): void // the (paused) timer resumes
extern
fun timerObj_get_ntick (x: !timerObj): uint // obtaining the number of ticks
extern
fun timerObj_reset (x: !timerObj): void // the timer resets

(* ****** ****** *)

typedef
timer_struct = @{
  started= bool // the timer has started
, running= bool // the timer is running
  // the tick number recorded
, ntick_beg= uint // when the timer was turned on the last time
, ntick_acc= uint // the number of accumulated ticks
} // end of [timer_struct]

assume timerObj = sobjptr (timer_struct)

(* ****** ****** *)

implement
timerObj_new () = let
  typedef T = timer_struct
  fn f (
    x: &T? >> T
  ) : void = {
    val () = x.started := false
    val () = x.running := false
    val () = x.ntick_beg := 0u
    val () = x.ntick_acc := 0u
  } // end of [f]
  val pobj = sobjptr_new<T> ()
in
  sobjptr_init {T} (pobj, f); pobj
end // end of [timerObj_new]

(* ****** ****** *)

implement
timerObj_free (pobj) = sobjptr_free (pobj)

(* ****** ****** *)

extern fun the_current_tick_get (): uint

implement
timerObj_start (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  val () = p->started := true
  val () = p->running := true
  val () = p->ntick_beg := the_current_tick_get ()
  val () = p->ntick_acc := 0u
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [timerObj_start]

implement
timerObj_finish (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  val () = p->started := false
  val () = if
    p->running then {
    val () = p->running := false
    val () = p->ntick_acc :=
      p->ntick_acc + the_current_tick_get () - p->ntick_beg
    // end of [val]
  } // end of [val]
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [timerObj_finish]

implement
timerObj_pause (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  val () = if
    p->running then {
    val () = p->running := false
    val () = p->ntick_acc :=
      p->ntick_acc + the_current_tick_get () - p->ntick_beg
    // end of [val]
  } // end of [val]
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [timerObj_pause]

implement
timerObj_resume (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  val () = if
    p->started andalso ~(p->running) then {
    val () = p->running := true
    val () = p->ntick_beg := the_current_tick_get ()
    // end of [val]
  } // end of [val]
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [timerObj_resume]

implement
timerObj_get_ntick (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  var ntick: uint = p->ntick_acc
  val () = if
    p->running then {
    val () = ntick := ntick + the_current_tick_get () - p->ntick_beg
  } // end of [val]
  prval () = pobj.atview := pfat
in
  ntick
end // end of [timerObj_get_ntick]

implement
timerObj_reset (pobj) = let
  prval pfat = pobj.atview
  val p = pobj.ptr
  val () = p->started := false
  val () = p->running := false
  val () = p->ntick_beg := 0u
  val () = p->ntick_acc := 0u
  prval () = pobj.atview := pfat
in
  // nothing
end // end of [timerObj_reset]

(* ****** ****** *)

local

staload "libc/SATS/time.sats"

in // in of [local]

implement
the_current_tick_get () = let
  var tv: timespec // uninitialized
  val err = clock_gettime (CLOCK_REALTIME, tv)
  val () = assertloc (err >= 0)
  prval () = opt_unsome {timespec} (tv)
  val nsec = tv.tv_sec
  val nsec = lint_of_time (nsec)
  val nsec = ulint_of_lint (nsec)
  val nsec = uint_of (nsec)
in
  nsec
end // end of [the_current_tick_get]

end // end of [local]

(* ****** ****** *)

staload US = "libc/SATS/unistd.sats"

implement
main () = () where {
  val timer = timerObj_new ()
  val () = timerObj_start (timer)
//
  val ntick = timerObj_get_ntick (timer)
  val () = println! ("ntick(0) = ", ntick)
  val err = $US.sleep (1u)
  val () = timerObj_pause (timer)
  val ntick = timerObj_get_ntick (timer)
  val () = println! ("ntick(1) = ", ntick)
  val err = $US.sleep (1u) // this one is not counted!
  val () = timerObj_resume (timer)
  val err = $US.sleep (1u)
  val ntick = timerObj_get_ntick (timer)
  val () = println! ("ntick(2) = ", ntick)
//
  val () = timerObj_finish (timer)
  val () = timerObj_free (timer)
} // end of [main]

(* ****** ****** *)

(* end of [sobjptr.dats] *)
