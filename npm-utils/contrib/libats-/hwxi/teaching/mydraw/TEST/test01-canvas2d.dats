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
#include "./test01.dats"
//
(* ****** ****** *)

extern
fun
canvas2d_draw3_sierpinski
  {l:agz}
(
  cr: !canvas2d (l)
, p1: point, p2: point, p3: point, clr1: color, clr2: color
, level: int
) : void // end of [canvas2d_draw3_sierpinski]

implement
canvas2d_draw3_sierpinski
  (ctx, p1, p2, p3, clr1, clr2, n) = let
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
in
  draw3_sierpinski (p1, p2, p3, clr1, clr2, n)
end // end of [canvas2d_draw3_sierpinski]

(* ****** ****** *)

val W = 600.0 and H = 400.0

(* ****** ****** *)

implement
main0 () =
{
//
val id =
  "SierpinskiTriangles"
//
val ctx = canvas2d_make (id)
val p_ctx = ptrcast (ctx)
val () = assertloc (p_ctx > 0)
//
val WH = min (W, H)
val WH2 = WH / 2.0
//
val () =
canvas2d_translate (ctx, WH2, WH2)
val (pf0 | ()) = canvas2d_save (ctx)
//
val p1 = point_make (~WH2,  WH2)
val p2 = point_make ( 0.0, ~WH2)
val p3 = point_make ( WH2,  WH2)
//
val clr1 = color_make (0.0, 0.0, 1.0)
val clr2 = color_complement (clr1)
//
val () = canvas2d_draw3_sierpinski (ctx, p1, p2, p3, clr1, clr2, 5)
//
val () = canvas2d_restore (pf0 | ctx)
//
val () = canvas2d_free (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01-canvas2d.dats] *)
