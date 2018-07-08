(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
*)

(* ****** ****** *)
//
extern
fun{}
draw3_solid
  (point, point, point, color): void
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
val () = mydraw_new_path ()
val () = mydraw_triangle (p1, p2, p3)
val () = mydraw_fill_set_rgb (clr.r(), clr.g(), clr.b())
val () = mydraw_fill ()
val () = mydraw_close_path ()
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

(* end of [test01.dats] *)
