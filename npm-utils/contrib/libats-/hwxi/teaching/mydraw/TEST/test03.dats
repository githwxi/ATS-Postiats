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
draw_line(point, point, color): void
//
extern
fun{}
draw_koch(point, point, color, int(*level*)): void
//
(* ****** ****** *)

implement
{}(*tmp*)
draw_line
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

implement
{}(*tmp*)
draw_koch
(
  p1, p2, clr, n
) = let
in
//
if n > 0 then let
  val v0 = (p2 - p1) / 3.0
  val q1 = p1 + v0
  val q2 = q1 + vector_rotate (v0, ~PI/3)
  val q3 = p2 - v0
  val () = draw_koch (p1, q1, clr, n-1)
  val () = draw_koch (q1, q2, clr, n-1)
  val () = draw_koch (q2, q3, clr, n-1)
  val () = draw_koch (q3, p2, clr, n-1)
in
  // nothing
end else draw_line (p1, p2, clr) // end of [if]
//
end // end of [draw_koch]

(* ****** ****** *)

(* end of [test03.dats] *)
