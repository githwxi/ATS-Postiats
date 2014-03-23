(* ****** ****** *)
//
#define ATS_PACKNAME
"ATSCNTRB.libats-hwxi.\
teaching.gtkcairotimer_toplevel"
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload
NCLICK = {
//
typedef T = int
//
fun
initize (x: &T? >> T): void = x := 0
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [NCLICK] *)

(* ****** ****** *)

staload
TOPWIN = {
//
typedef T = ptr
//
fun
initize (x: &T? >> T): void = x := the_null_ptr
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [TOPWIN] *)

(* ****** ****** *)
//
staload
TIMER =
"./gtkcairotimer_timer.dats"
//
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
extern
fun the_timer_is_started (): bool
extern
fun the_timer_is_running (): bool
//
(* ****** ****** *)

local

val t0 = $TIMER.timer_new ()

in (* in-of-local *)

implement
the_timer_start
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_start (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_start] *)

implement
the_timer_finish
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_finish (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_finish] *)

implement
the_timer_pause
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_pause (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_pause] *)

implement
the_timer_resume
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_resume (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_resume] *)

implement
the_timer_reset
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_reset (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

(* ****** ****** *)

implement
the_timer_get_ntick
  ((*void*)) = ntick where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ntick = $TIMER.timer_get_ntick (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

(* ****** ****** *)

implement
the_timer_is_started
  ((*void*)) = ans where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ans = $TIMER.timer_is_started (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_is_started] *)

implement
the_timer_is_running
  ((*void*)) = ans where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ans = $TIMER.timer_is_running (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_is_running] *)

end // end of [local]

(* ****** ****** *)

(* end of [gtkcairotimer_toplevel.dats] *)
