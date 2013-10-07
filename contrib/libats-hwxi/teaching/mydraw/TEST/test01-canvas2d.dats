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
staload "./test02.dats"

(* ****** ****** *)
//
staload "./../SATS/mydraw_html5_canvas2d.sats"
staload _(*anon*) = "./../DATS/mydraw_html5_canvas2d.dats"
//
(* ****** ****** *)
//
extern
fun{}
draw3_solid (point, point, point, color): void
extern
fun{}
draw3_sierpinski
  (point, point, point, color, color, int(*level*)): void
//
(* ****** ****** *)

implement{
} draw3_solid
(
  p1, p2, p3, clr
) = let
//
val () = mydraw_triangle (p1, p2, p3)
val () = mydraw_set_source_color (clr)
val () = mydraw_fill ()
//
in
  // nothing
end // end of [draw3_solid]

(* ****** ****** *)

implement{
} draw3_sierpinski
(
  p1, p2, p3, clr1, clr2, n
) = let
in
//
if n > 0 then let
  val p12 = p1 + 0.5 * (p2 - p1)
  val p23 = p2 + 0.5 * (p3 - p2)
  val p31 = p3 + 0.5 * (p1 - p3)
  val () = draw3_solid (p12, p23, p31, clr2)
  val () = draw3_sierpinski (p1, p12, p31, clr1, clr2, n-1)
  val () = draw3_sierpinski (p12, p2, p23, clr1, clr2, n-1)
  val () = draw3_sierpinski (p31, p23, p3, clr1, clr2, n-1)
in
  // nothing
end else draw3_solid (p1, p2, p3, clr1) // end of [if]
//
end // end of [draw3_sierpinski]

(* ****** ****** *)

extern
fun
canvas2d_draw3_sierpinski
  {l:agz}
(
  cr: !canvas2d (l)
, p1: point, p2: point, p3: point, c1: color, c2: color
, level: int
) : void // end of [canvas2d_draw3_sierpinski]

implement
canvas2d_draw3_sierpinski
  (ctx, p1, p2, p3, c1, c2, n) = let
//
val p_ctx = ptrcast (ctx)
//
implement
mydraw_get0_canvas2d<> () = let
//
extern
castfn __cast {l:addr} (ptr (l)): vttakeout (void, canvas2d (l))
//
in
  __cast (p_ctx)
end // end of [mydraw_get0_canvas2d]
//
in
  draw3_sierpinski (p1, p2, p3, c1, c2, n)
end // end of [canvas2d_draw3_sierpinski]

(* ****** ****** *)

(* end of [test01-canvas2d.dats] *)
