(*
//
A Wall Clock: ATS->Javascript
//
Author: Hongwei Xi
Authoremail: hwxi AT cs DOT bu DOT edu
Start Time: October 2013
//
This example is essentially translated from
the JS code at the following site:
//
http://www.neilwallis.com/projects/html5/clock/
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
//
#define
PI 3.1415926535898
macdef _2PI = 2 * PI
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "{$HTML5canvas2d}/SATS/canvas2d.sats"

(* ****** ****** *)

extern
fun wallclock_now
(
  nhr: &double? >> double, nmin: &double? >> double, nsec: &double? >> double
) : void = "ext#JS_wallclock_now"

(* ****** ****** *)

staload M = "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"

(* ****** ****** *)

fun
draw_mark
 {l:agz} (
  ctx: !canvas2d(l), i: int
) : void = {
//
val a = PI/30*i
val sa = $M.sin(a)
val ca = $M.cos(a)
val sx = 110 * sa
val sy = 110 * ca
val ex = 120 * sa
val ey = 120 * ca
val () = canvas2d_set_lineWidth (ctx, 2)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_moveTo (ctx, sx, sy)
val () = canvas2d_lineTo (ctx, ex, ey)
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
//
} (* end of [draw_mark] *)

fun
draw_mark2
 {l:agz} (
  ctx: !canvas2d(l), i: int
) : void = {
//
val a = PI/30*i
val sa = $M.sin(a)
val ca = $M.cos(a)
val sx =  95 * sa
val sy = ~95 * ca
val ex =  120 * sa
val ey = ~120 * ca
val nx =  80 * sa
val ny = ~80 * ca
//
val i5 = g0int2string (i/5)
val () = canvas2d_fillText (ctx, $UN.strptr2string(i5), nx, ny)
val () = strptr_free (i5)
//
val () = canvas2d_set_lineWidth (ctx, 8)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_moveTo (ctx, sx, sy)
val () = canvas2d_lineTo (ctx, ex, ey)
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
//
} (* end of [draw_mark2] *)

(* ****** ****** *)

fun
draw_clock
 {l:agz} (
  ctx: !canvas2d(l)
, nhr: double, nmin: double, nsec: double
) : void = {
//
val () = canvas2d_clearRect (ctx, 0.0, 0.0, 300.0, 300.0)
//
// Define gradients for 3D / shadow effect
//
val grad1 =
  canvas2d_createLinearGradient (ctx, 0.0, 0.0, 300.0, 300.0)
val () = canvas2d_gradient_addColorStop(grad1, 0.0, "#D83040")
val () = canvas2d_gradient_addColorStop(grad1, 1.0, "#801020")
//
val grad2=
  canvas2d_createLinearGradient (ctx, 0.0, 0.0, 300.0, 300.0)
val () = canvas2d_gradient_addColorStop(grad2, 0.0, "#801020")
val () = canvas2d_gradient_addColorStop(grad2, 1.0, "#D83040")
//
val () = canvas2d_set_font_string (ctx, "bold 20px arial")
val () = canvas2d_set_textAlign_string (ctx, "center")
val () = canvas2d_set_textBaseline_string (ctx, "middle")
val () = canvas2d_set_lineWidth (ctx, 1)
//
val () = canvas2d_set_strokeStyle_gradient (ctx, grad1)
val () = canvas2d_set_lineWidth (ctx, 10)
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_arc(ctx, 150.0, 150.0, 138.0, 0.0, _2PI, true)
val () = canvas2d_closePath (ctx)
val () = canvas2d_set_shadowBlur (ctx, 6)
val () = canvas2d_set_shadowOffsetX (ctx, 4)
val () = canvas2d_set_shadowOffsetY (ctx, 4)
val () = canvas2d_set_shadowColor (ctx, "rgba(0,0,0,0.6)")
val () = canvas2d_stroke (ctx)
val ((*void*)) = canvas2d_restore (pf | ctx)
val () = canvas2d_gradient_free (grad1)
//
val () = canvas2d_set_strokeStyle_gradient (ctx, grad2)
val () = canvas2d_set_lineWidth (ctx, 10)
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_arc (ctx, 150.0, 150.0, 129.0, 0.0, _2PI, true);
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
val ((*void*)) = canvas2d_restore (pf | ctx)
val () = canvas2d_gradient_free (grad2)
//
val () = canvas2d_set_strokeStyle_string (ctx, "#222")
//
val (pf | ()) = canvas2d_save (ctx)
val () = canvas2d_translate (ctx, 150.0, 150.0)
//
val () = loop (ctx, 1) where
{
fun loop
(
  ctx: !canvas2d(l), i: int
) : void =
  if i <= 60 then let
    val () =  (
      if i mod 5 != 0 then draw_mark (ctx, i) else draw_mark2 (ctx, i)
    ) : void // end of [val]
  in
    loop (ctx, i+1)
  end else () // end of [if]
}
//
val ampm =
  (if (nhr < 12.0) then "AM" else "PM"): string
val () = canvas2d_set_strokeStyle_string (ctx, "#000")
val () = canvas2d_set_lineWidth (ctx, 1)
val () = canvas2d_strokeRect (ctx, 21.0, ~14.0, 44.0, 27.0)
val () = canvas2d_fillText (ctx, ampm, 43.0, 0.0)
//
val () = canvas2d_set_lineWidth (ctx, 6)
//
val (pf2 | ()) = canvas2d_save (ctx)
val () = canvas2d_rotate (ctx, nhr*PI/6)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_moveTo (ctx, 0.0, 10.0)
val () = canvas2d_lineTo (ctx, 0.0, ~60.0)
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
val ((*void*)) = canvas2d_restore (pf2 | ctx)
//
val (pf2 | ()) = canvas2d_save (ctx)
val () = canvas2d_rotate (ctx, nmin*PI/30)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_moveTo (ctx, 0.0, 20.0)
val () = canvas2d_lineTo (ctx, 0.0, ~110.0)
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
val ((*void*)) = canvas2d_restore (pf2 | ctx)
//
val () = canvas2d_set_lineWidth (ctx, 3)
val () = canvas2d_set_strokeStyle_string (ctx, "#E33")
val (pf2 | ()) = canvas2d_save (ctx)
val () = canvas2d_rotate (ctx, nsec*PI/30)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_moveTo (ctx, 0.0, 20.0)
val () = canvas2d_lineTo (ctx, 0.0, ~110.0)
val () = canvas2d_closePath (ctx)
val () = canvas2d_stroke (ctx)
val ((*void*)) = canvas2d_restore (pf2 | ctx)
//
val () = canvas2d_set_fillStyle_string (ctx, "#000")
val (pf2 | ()) = canvas2d_save (ctx)
val () = canvas2d_beginPath (ctx)
val () = canvas2d_arc(ctx, 0.0, 0.0, 6.5, 0.0, _2PI, true)
val () = canvas2d_closePath (ctx)
val () = canvas2d_fill (ctx)
val ((*void*)) = canvas2d_restore (pf2 | ctx)
//
val ((*void*)) = canvas2d_restore (pf | ctx)
//
} (* end of [draw_clock] *)

(* ****** ****** *)

val w = 920.0
val h = 600.0
val mn = min (w, h)
val xc = w / 2 and yc = h / 2
val alpha = mn / 300

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
//
  val () =
  canvas2d_translate (ctx, xc-mn/2, yc-mn/2)
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
val ID = "MyClock1"
//
val ctx = canvas2d_make (ID)
val p_ctx = ptrcast (ctx)
val ((*void*)) = assertloc (p_ctx > 0)
//
val ((*void*)) = start_animation (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [myclock1.dats] *)
