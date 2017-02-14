(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: October, 2013
*)

(* ****** ****** *)

#define PI 3.1415926535898

(* ****** ****** *)
//
extern
fun{}
draw_line (point, point, color): void
//
extern
fun{}
draw_dragon
(
  sgn: int, point, point, color, int(*level*)
) : void // end of [draw_dragon]
//
(* ****** ****** *)

implement{
} draw_line
(
  p1, p2, clr
) = let
//
val () = mydraw_new_path ()
//
val () = mydraw_move_to (p1)
val () = mydraw_line_to (p2)
val () = mydraw_stroke_set_rgb (clr.r(), clr.g(), clr.b())
val () = mydraw_stroke ()
//
val () = mydraw_close_path ()
//
in
  // nothing
end // end of [draw_line]

(* ****** ****** *)

implement{
} draw_dragon
(
  sgn, p1, p2, clr, n
) = let
in
//
if n > 0 then let
  val v0 = $M.cos(PI/4) * (p2 - p1)
  val q1 = p1 + vector_rotate (v0, sgn*PI/4)
  val () = draw_dragon ( 1, p1, q1, clr, n-1)
  val () = draw_dragon (~1, q1, p2, clr, n-1)
in
  // nothing
end else draw_line (p1, p2, clr) // end of [if]
//
end // end of [draw_dragon]

(* ****** ****** *)

(* end of [test04.dats] *)
