(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
*)

(* ****** ****** *)

extern
fun{}
draw_row
(
  pul: point, c1: color, c2: color, n: intGte(0)
) : void // end of [draw_row]

(* ****** ****** *)

implement
{}(*tmp*)
draw_row
  (pul, c1, c2, n) = let
//
fun loop
(
  pul: point
, clr1: color, clr2: color
, n: intGte(0)
) : void =
  if n > 0 then let
    val () = mydraw_new_path ()
    val (
    ) = mydraw_rectangle (pul, 1.0, 1.0)
    val () = mydraw_fill_set_rgb (clr1.r(), clr1.g(), clr1.b())
    val () = mydraw_fill ()
    val () = mydraw_close_path ()
  in
    loop (point_hshift (pul, 1.0), clr2, clr1, pred(n))
  end else () // end of [if]
//
in
  loop (pul, c1, c2, n)
end // end of [draw_row]

(* ****** ****** *)

extern
fun{} draw_mrow
(
  pul: point, c1: color, c2: color, m: intGte(0), n: intGte(0)
) : void // end of [draw_mrow]

(* ****** ****** *)

implement{
} draw_mrow
  (pul, c1, c2, m, n) = let
in
//
if m > 0 then let
  val () = draw_row (pul, c1, c2, n)
in
  draw_mrow (point_vshift (pul, 1.0), c2, c1, pred(m), n)
end else () // end of [if]
//
end // end of [draw_mrow]

(* ****** ****** *)

(* end of [test02.dats] *)
