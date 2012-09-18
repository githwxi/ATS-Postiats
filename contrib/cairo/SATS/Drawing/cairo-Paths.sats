(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

staload "cairo/SATS/cairo_header.sats"

(* ****** ****** *)

/*
cairo_path_t *      cairo_copy_path                     (cairo_t *cr);
*/
/*
cairo_path_t *      cairo_copy_path_flat                (cairo_t *cr);
*/
/*
void                cairo_path_destroy                  (cairo_path_t *path);
*/
/*
void                cairo_append_path                   (cairo_t *cr,
                                                         const cairo_path_t
							 *path);
*/

(* ****** ****** *)

/*
cairo_bool_t        cairo_has_current_point             (cairo_t *cr);
*/
fun cairo_has_current_point
  (ctx: !xr1): bool = "mac#atsctrb_cairo_has_current_point"
// end of [cairo_has_current_point]

/*
void                cairo_get_current_point             (cairo_t *cr,
                                                         double *x,
                                                         double *y);
*/
fun cairo_get_current_point (
  ctx: !xr1
, x: &double? >> double, y: &double? >> double
) : void = "mac#atsctrb_cairo_get_current_point" // end of [fun]

(* ****** ****** *)

/*
void                cairo_new_path                      (cairo_t *cr);
*/
fun cairo_new_path (ctx: !xr1): void = "mac#atsctrb_cairo_new_path"

/*
void                cairo_new_sub_path                  (cairo_t *cr);
*/
fun cairo_new_sub_path (ctx: !xr1): void = "mac#atsctrb_cairo_new_sub_path"

(* ****** ****** *)

/*
void                cairo_close_path                    (cairo_t *cr);
*/
/*
void                cairo_arc                           (cairo_t *cr,
                                                         double xc,
                                                         double yc,
                                                         double radius,
                                                         double angle1,
                                                         double angle2);
*/
/*
void                cairo_arc_negative                  (cairo_t *cr,
                                                         double xc,
                                                         double yc,
                                                         double radius,
                                                         double angle1,
                                                         double angle2);
*/
/*
void                cairo_curve_to                      (cairo_t *cr,
                                                         double x1,
                                                         double y1,
                                                         double x2,
                                                         double y2,
                                                         double x3,
                                                         double y3);
*/
/*
void                cairo_line_to                       (cairo_t *cr,
                                                         double x,
                                                         double y);
*/

(* ****** ****** *)


/*
void                cairo_move_to                       (cairo_t *cr,
                                                         double x,
                                                         double y);
*/
fun cairo_move_to
  (ctx: !xr1, x: double, y: double): void = "mac#atsctrb_cairo_move_to"

(* ****** ****** *)

/*
void                cairo_rectangle                     (cairo_t *cr,
                                                         double x,
                                                         double y,
                                                         double width,
                                                         double height);
*/
/*
void                cairo_glyph_path                    (cairo_t *cr,
                                                         const
							 cairo_glyph_t
							 *glyphs,
                                                         int num_glyphs);
*/
/*
void                cairo_text_path                     (cairo_t *cr,
                                                         const char *utf8);
*/
/*
void                cairo_rel_curve_to                  (cairo_t *cr,
                                                         double dx1,
                                                         double dy1,
                                                         double dx2,
                                                         double dy2,
                                                         double dx3,
                                                         double dy3);
*/
/*
void                cairo_rel_line_to                   (cairo_t *cr,
                                                         double dx,
                                                         double dy);
*/
/*
void                cairo_rel_move_to                   (cairo_t *cr,
                                                         double dx,
                                                         double dy);
*/
/*
void                cairo_path_extents                  (cairo_t *cr,
                                                         double *x1,
                                                         double *y1,
                                                         double *x2,
                                                         double *y2);
*/

(* ****** ****** *)

(* end of [cairo-Paths.sats] *)
