(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: October, 2013
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
#define MYDRAW_CANVAS2D
//
#include "./../mylibies.hats"
//
#staload $MYDRAW
#staload $MYDRAW_canvas2d
//
#include "./../DATS/mydraw.dats"
#include "./../DATS/mydraw_HTML5_canvas2d.dats"
//
(* ****** ****** *)
//
#include "./test04.dats"
//
(* ****** ****** *)

extern
fun
canvas2d_draw_dragon
  {l:agz}
(
  cr: !canvas2d (l)
, p1: point, p2: point, clr: color
, level: int
) : void // end of [canvas2d_draw_dragon]


implement
canvas2d_draw_dragon
  (ctx, p1, p2, clr, n) = let
//
val p_ctx = ptrcast (ctx)
//
implement
mydraw_get0_canvas2d<> () = let
//
extern
castfn __cast {l:addr} (ptr(l)): vttakeout (void, canvas2d(l))
//
in
  __cast (p_ctx)
end // end of [mydraw_get0_canvas2d]
//
val () = draw_dragon (1(*sgn*), p1, p2, clr, n)
//
in
  // nothing
end // end of [canvas2d_draw_dragon]

(* ****** ****** *)

val W = 600.0 and H = 400.0

(* ****** ****** *)

implement
main0 () =
{
//
val id = "DragonCurve"
//
val ctx = canvas2d_make (id)
val p_ctx = ptrcast (ctx)
val () = assertloc (p_ctx > 0)
//
val WH = min (W, H)
val WH2 = WH / 2.0
val WH4 = WH / 4.0
//
val () =
canvas2d_translate (ctx, WH2, WH2)
val (pf0 | ()) = canvas2d_save (ctx)
//
val p1 = point_make (~WH4, 0.0)
val p2 = point_make ( WH4, 0.0)
//
val clr = color_make (0.0, 0.0, 1.0)
//
val () = canvas2d_draw_dragon (ctx, p1, p2, clr, 12)
//
val () = canvas2d_restore (pf0 | ctx)
//
val () = canvas2d_free (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04-canvas2d.dats] *)
