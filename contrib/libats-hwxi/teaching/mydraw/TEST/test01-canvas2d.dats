(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
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
staload "./../SATS/mydraw.sats"
staload _(*anon*) = "./../DATS/mydraw.dats"
//
(* ****** ****** *)
//
staload "./test01-2.dats"

(* ****** ****** *)
//
staload "./../SATS/mydraw_html5_canvas2d.sats"
staload _(*anon*) = "./../DATS/mydraw_html5_canvas2d.dats"
//
(* ****** ****** *)

extern
fun
canvas2d_draw3_sierpinski
  {l:agz}
(
  cr: !canvas2d (l)
, p1: point, p2: point, p3: point, clr1: string, clr2: string
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
val clr1 = "blue" and clr2 = "yellow"
//
val () = canvas2d_draw3_sierpinski (ctx, p1, p2, p3, clr1, clr2, 4)
//
val () = canvas2d_restore (pf0 | ctx)
//
val () = canvas2d_free (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01-canvas2d.dats] *)
