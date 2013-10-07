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
staload "./test01.dats"

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
