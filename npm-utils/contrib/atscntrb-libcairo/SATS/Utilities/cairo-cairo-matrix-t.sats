(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
typedef struct {
  double xx; double yx;
  double xy; double yy;
  double x0; double y0;
} cairo_matrix_t;
*/

(* ****** ****** *)

/*
void                cairo_matrix_init                   (cairo_matrix_t *matrix,
                                                         double xx,
                                                         double yx,
                                                         double xy,
                                                         double yy,
                                                         double x0,
                                                         double y0);
*/
fun cairo_matrix_init
(
  matrix: &xrmat? >> xrmat
, xx: double, yx: double, xy: double, yy: double, x0: double, y0: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_init_identity          (cairo_matrix_t *matrix);
*/
fun cairo_matrix_init_identity
  (matrix: &xrmat? >> xrmat): void = "mac#%"
// end of [cairo_matrix_init_identity]

(* ****** ****** *)

/*
void                cairo_matrix_init_translate         (cairo_matrix_t *matrix,
                                                         double tx,
                                                         double ty);
*/
fun
cairo_matrix_init_translate
(
  matrix: &xrmat? >> xrmat, tx: double, ty: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_init_scale             (cairo_matrix_t *matrix,
                                                         double sx,
                                                         double sy);
*/
fun
cairo_matrix_init_scale
(
  matrix: &xrmat? >> xrmat, sx: double, sy: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_init_rotate            (cairo_matrix_t *matrix,
                                                         double radians);
*/
fun cairo_matrix_init_rotate
  (matrix: &xrmat? >> xrmat, radians: double): void = "mac#%"
// end of [cairo_matrix_init_rotate]

(* ****** ****** *)

/*
void                cairo_matrix_translate              (cairo_matrix_t *matrix,
                                                         double tx,
                                                         double ty);
*/
fun
cairo_matrix_translate
(
  matrix: &xrmat >> _, tx: double, ty: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_scale                  (cairo_matrix_t *matrix,
                                                         double sx,
                                                         double sy);
*/
fun
cairo_matrix_scale
(
  matrix: &xrmat >> _, sx: double, sy: double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_rotate                 (cairo_matrix_t *matrix,
                                                         double radians);
*/
fun cairo_matrix_rotate
  (matrix: &xrmat >> _, radians: double): void = "mac#%"
// end of [cairo_matrix_rotate]

(* ****** ****** *)

/*
cairo_status_t      cairo_matrix_invert                 (cairo_matrix_t *matrix);
*/
fun cairo_matrix_invert
  (matrix: &xrmat >> xrmat): cairo_status_t = "mac#%"
// end of [cairo_matrix_invert]

(* ****** ****** *)

/*
void                cairo_matrix_multiply               (cairo_matrix_t *result,
                                                         const
							 cairo_matrix_t *a,
                                                         const
							 cairo_matrix_t
							 *b);
*/
fun cairo_matrix_multiply
(
  result: &xrmat? >> xrmat, a: &RD(xrmat), b: &RD(xrmat)
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void                cairo_matrix_transform_distance     (const cairo_matrix_t *matrix,
                                                         double *dx,
                                                         double *dy);
*/
fun
cairo_matrix_transform_distance
(
  matrix: &RD(xrmat)
, dx: &double? >> double, dy: &double? >> double
) : void = "mac#%" // end of [fun]

(* ****** ****** *)

/*
void                cairo_matrix_transform_point        (const cairo_matrix_t *matrix,
                                                         double *x,
                                                         double *y);
*/
fun
cairo_matrix_transform_point
(
  matrix: &RD(xrmat)
, x: &double? >> double, y: &double? >> double
) : void = "mac#%" // end of [fun]

(* ****** ****** *)

(* end of [cairo-cairo-matrix-t.sats] *)
