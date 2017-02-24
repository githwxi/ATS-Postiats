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
#include "./test02.dats"
//
(* ****** ****** *)

val W = 450.0 and H = 450.0

(* ****** ****** *)

implement
main0 () =
{
//
val id =
  "CheckerBoard"
//
val M = 8 and N = 8
//
val ctx = canvas2d_make (id)
val p_ctx = ptrcast (ctx)
val () = assertloc (p_ctx > 0)
//
val WH = min (W, H)
//
val p0 = point_make (0.0, 0.0)
//
val (pf0 | ()) = canvas2d_save (ctx)
//
val () = canvas2d_scale (ctx, 1.0*W/N, 1.0*H/M)
//
implement
mydraw_get0_canvas2d<> () = let
extern
castfn __cast {l:addr} (ptr (l)): vttakeout (void, canvas2d(l))
in
  __cast (p_ctx)
end // end of [mydraw_get0_canvas2d]
//
val clr1 = color_make (0.8, 0.8, 0.8)
val clr2 = color_make (0.0, 0.0, 0.0)
//
val () = draw_mrow (p0, clr1, clr2, M, N)
//
val () = canvas2d_restore (pf0 | ctx)
//
val () = canvas2d_free (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02-canvas2d.dats] *)
