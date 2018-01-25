fun
draw_triangle{l:agz}
(
  cr: !cairo_ref l
, x0: double, y0: double
, x1: double, y1: double
, x2: double, y2: double
) : void = () where {
  val () = cairo_move_to (cr, x0, y0)
  val () = cairo_line_to (cr, x1, y1)
  val () = cairo_line_to (cr, x2, y2)
  val () = cairo_close_path (cr)
} (* end of [draw_triangle] *)
