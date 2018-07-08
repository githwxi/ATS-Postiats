(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: September, 2012
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
cairo_path_t*cairo_copy_path (cairo_t *cr);
*/
/*
cairo_path_t*cairo_copy_path_flat (cairo_t *cr);
*/
/*
void cairo_path_destroy (cairo_path_t *path);
*/
/*
void cairo_append_path
(
cairo_t *cr, const cairo_path_t *path
) ;
*/

(* ****** ****** *)

/*
cairo_bool_t
cairo_has_current_point (cairo_t *cr);
*/
fun cairo_has_current_point (ctx: !xr1): bool = "mac#%"

/*
void
cairo_get_current_point
(
cairo_t *cr, double *x, double *y
) ;
*/
fun cairo_get_current_point
(
  ctx: !xr1, x: &double? >> double, y: &double? >> double
) : void = "mac#%" // end of [cairo_get_current_point]

(* ****** ****** *)

/*
void cairo_new_path (cairo_t *cr);
*/
fun cairo_new_path (ctx: !xr1): void = "mac#%"

/*
void cairo_new_sub_path (cairo_t *cr);
*/
fun cairo_new_sub_path (ctx: !xr1): void = "mac#%"

(* ****** ****** *)

/*
void cairo_close_path (cairo_t *cr);
*/
fun cairo_close_path (ctx: !xr1): void = "mac#%" // endfun

(* ****** ****** *)

/*
void
cairo_arc
(
cairo_t *cr,
double xc, double yc,
double radius,
double angle1,
double angle2
) ;
*/
fun cairo_arc
(
  ctx: !xr1
, xc: double, yc: double, rad: double, angl1: double, angl2: double
) : void = "mac#%" // end of [cairo_arc]

/*
void
cairo_arc_negative
(
cairo_t *cr,
double xc, double yc,
double radius,
double angle1,
double angle2
) ;
*/
fun cairo_arc_negative
(
  ctx: !xr1
, xc: double, yc: double, rad: double, angl1: double, angl2: double
) : void = "mac#%" // end of [cairo_arc_negative]

(* ****** ****** *)

/*
void
cairo_curve_to
(
cairo_t *cr,
double x1, double y1,
double x2, double y2,
double x3, double y3
) ;
*/
fun cairo_curve_to
(
  ctx: !xr1
, x1: double, y1: double, x2: double, y2: double, x3: double, y3: double
) : void = "mac#%" // end of [cairo_curve_to]

(* ****** ****** *)

/*
void
cairo_line_to
(
cairo_t *cr, double x, double y
) ;
*/
fun cairo_line_to
  (ctx: !xr1, x: double, y: double): void = "mac#%"
// end of [cairo_line_to]

/*
void
cairo_move_to
(
cairo_t *cr, double x, double y
) ;
*/
fun cairo_move_to
  (ctx: !xr1, x: double, y: double): void = "mac#%"
// end of [cairo_move_to]

(* ****** ****** *)

/*
void
cairo_rectangle
(
cairo_t *cr,
double x,
double y,
double width,
double height
) ;
*/
fun cairo_rectangle
(
  ctx: !xr1, x: double, y: double, width: double, height: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void
cairo_glyph_path
(
cairo_t *cr,
const cairo_glyph_t *glyphs,
int num_glyphs
) ;
*/
fun cairo_glyph_path {n:int}
(
  ctx: !xr1, glyphs: arrayref (cairo_glyph_t, n), n: int n
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void
cairo_text_path
(
cairo_t *cr, const char *utf8
) ;
*/
fun cairo_text_path (ctx: !xr1, utf8: string): void = "mac#%"

(* ****** ****** *)

/*
void
cairo_rel_curve_to
(
cairo_t *cr,
double dx1, double dy1,
double dx2, double dy2,
double dx3, double dy3
) ;
*/
fun cairo_rel_curve_to
(
  ctx: !xr1
, dx1: double, dy1: double
, dx2: double, dy2: double
, dx3: double, dy3: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void
cairo_rel_line_to
(
cairo_t *cr, double dx, double dy
) ;
*/
fun cairo_rel_line_to
  (ctx: !xr1, dx: double, dy: double): void = "mac#%"
// end of [cairo_rel_line_to]

/*
void
cairo_rel_move_to
(
cairo_t *cr, double dx, double dy
) ;
*/
fun cairo_rel_move_to
  (ctx: !xr1, dx: double, dy: double): void = "mac#%"
// end of [cairo_rel_move_to]

(* ****** ****** *)

/*
void
cairo_path_extents
(
cairo_t *cr, double *x1, double *y1, double *x2, double *y2
) ;
*/
fun cairo_path_extents
(
  ctx: !xr1
, x1: &double? >> double
, y1: &double? >> double
, x2: &double? >> double
, y2: &double? >> double
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [cairo-Paths.sats] *)
