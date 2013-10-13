(*
//
A Wall Clock: ATS->Javascript
//
Author: Will Blair
Authoremail: wdblairATcsDOTbuDOTedu
Start Time: September 2013
//
Author: Hongwei Xi
Authoremail: hwxi AT cs DOT bu DOT edu
Start Time: October 2013
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "{$HTML5canvas2d}/SATS/canvas2d.sats"

(* ****** ****** *)

#define
PI 3.1415926535898

(* ****** ****** *)

val PI2 = PI / 2.0

(* ****** ****** *)

extern
fun wallclock_now
(
  nhr: &double? >> double, nmin: &double? >> double, nsec: &double? >> double
) : void = "ext#JS_wallclock_now"

(* ****** ***** *)

val w = 920.0
val h = 600.0
val mn = min (w, h)
val xc = w / 2 and yc = h / 2
val alpha = mn / h

(* ****** ***** *)

fun
draw_hand
(
  ctx: !canvas2d1
, bot: double, top: double, len: double
) : void =
(
 canvas2d_beginPath (ctx);
 canvas2d_moveTo (ctx, 0.0, bot/2);
 canvas2d_lineTo (ctx, len, top/2);
 canvas2d_lineTo (ctx, len, ~top/2);
 canvas2d_lineTo (ctx, 0.0, ~bot/2);
 canvas2d_fill (ctx);
 canvas2d_closePath (ctx);
) (* end of [draw_hand] *)

fun
draw_clock
(
  ctx: !canvas2d1
, nhr: double, nmin: double, nsec: double
) : void = {
//
val rad = 280.0
//
val h_angle = nhr * (PI / 6) - PI2
val m_angle = nmin * (PI / 30) - PI2
val s_angle = nsec * (PI / 30) - PI2
//
val h_l = 0.60 * rad
val m_l = 0.85 * rad
val s_l = 0.85 * rad
//    
val () = canvas2d_clearRect (ctx, ~xc, ~yc, w, h)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_set_fillStyle_string (ctx, "rgb(25, 25, 25)")
val () = canvas2d_arc (ctx, 0.0, 0.0, rad, 0.0, 2.0*PI, true)
val () = canvas2d_fill (ctx)
val () = canvas2d_closePath (ctx)
//
val () = canvas2d_beginPath (ctx)
val () = canvas2d_set_fillStyle_string (ctx, "rgba(200, 200, 200, 0.50)")
val () = canvas2d_arc (ctx, 0.0, 0.0, 10.0, 0.0, 2.0*PI, true)
val () = canvas2d_fill (ctx)
val () = canvas2d_closePath (ctx)
//
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_set_fillStyle_string (ctx, "rgb(150, 150, 150)");
val () = canvas2d_rotate (ctx, h_angle)
val () = draw_hand (ctx, 6.0, 3.5, h_l)
val () = canvas2d_rotate (ctx, PI)
val () = draw_hand (ctx, 6.0, 3.5, h_l / 6)
val () = canvas2d_restore (pf | ctx)
//
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_set_fillStyle_string (ctx, "rgb(175, 175, 175)")
val () = canvas2d_rotate (ctx, m_angle)
val () = draw_hand (ctx, 4.0, 3.0, m_l)
val () = canvas2d_rotate (ctx, PI)
val () = draw_hand (ctx, 4.0, 3.0, m_l / 6)
val () = canvas2d_restore (pf | ctx)
//
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_set_fillStyle_string (ctx, "rgb(200, 200, 200)");
val () = canvas2d_rotate (ctx, s_angle)
val () = draw_hand (ctx, 2.0, 1.5, s_l)
val () = canvas2d_rotate (ctx, PI)
val () = draw_hand (ctx, 2.0, 1.5, s_l / 6)
val () = canvas2d_restore (pf | ctx)
//
} (* end of [draw_clock] *)

(* ****** ****** *)
//
extern 
fun render_frame
  (timestamp: double, ctx: !canvas2d1) : bool
//
implement
render_frame
  (timestamp, ctx) = let
//
  val (pf | ()) = canvas2d_save (ctx)
  val () = canvas2d_translate (ctx, xc, yc)
//
  val () = canvas2d_scale (ctx, alpha, alpha)
//
  var nhr: double
  and nmin: double
  and nsec: double
//
  val () = wallclock_now (nhr, nmin, nsec)
  val () = draw_clock (ctx, nhr, nmin, nsec)
  val () = canvas2d_restore (pf | ctx)
//
in
  true
end // end of [render_frame]

(* ****** ***** *)
//
extern
fun request_animation_frame // JS-function
  {a:vtype}
  (callback: (double, a) -> void, ctx: a): void = "ext#JS_request_animation_frame"
//
(* ****** ***** *)

fun
start_animation
  {l:agz}
(
  ctx: canvas2d(l)
) : void = let
//
vtypedef env = canvas2d(l)
//
fun step
(
  timestamp: double, ctx: canvas2d(l)
) : void =
(
  if render_frame (timestamp, ctx)
    then request_animation_frame{env}(step, ctx) else canvas2d_free (ctx)
  // end of [if]
) (* end of [step] *)
//
in
  request_animation_frame{env}(step, ctx)
end // end of [start_animation]

(* ****** ***** *)

implement
main0 ((*void*)) =
{
//
val ID = "MyClock0"
//
val ctx = canvas2d_make (ID)
val p_ctx = ptrcast (ctx)
val ((*void*)) = assertloc (p_ctx > 0)
//
val ((*void*)) = start_animation (ctx)
//
} (* end of [main0] *)

(* ****** ***** *)

(* end of [myclock0.dats] *)
