(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: September, 2012
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
void cairo_translate
(
cairo_t *cr, double tx, double ty
) ;
*/
fun cairo_translate
  (ctx: !xr1, tx: double, ty: double) : void = "mac#%"
// end of [cairo_translate]

(* ****** ****** *)

/*
void cairo_scale
(
cairo_t *cr, double sx, double sy
) ;
*/
fun cairo_scale
  (ctx: !xr1, sx: double, sy: double) : void = "mac#%"
// end of [cairo_scale]

(* ****** ****** *)

/*
void cairo_rotate (cairo_t *cr, double angle);
*/
fun cairo_rotate (ctx: !xr1, angle: double) : void = "mac#%"

(* ****** ****** *)

/*
void cairo_transform
(
cairo_t *cr, const cairo_matrix_t *matrix
) ;
*/
fun cairo_transform
  (ctx: !xr1, matrix: &RD(xrmat)): void = "mac#%"
// end of [cairo_transform]

(* ****** ****** *)

/*
void
cairo_set_matrix
(
cairo_t *cr, const cairo_matrix_t *matrix
) ;
*/
fun cairo_set_matrix
  (ctx: !xr1, matrix: &RD(xrmat)): void = "mac#%"
// end of [cairo_set_matrix]

/*
void
cairo_get_matrix (cairo_t *cr, cairo_matrix_t *matrix)
*/
fun cairo_get_matrix
  (ctx: !xr1, matrix: &xrmat? >> xrmat): void = "mac#%"
// end of [cairo_get_matrix]

(* ****** ****** *)

/*
void cairo_identity_matrix (cairo_t *cr) ;
*/
fun cairo_identity_matrix (ctx: !xr1): void = "mac#%"

(* ****** ****** *)

/*
void
cairo_user_to_device
  (cairo_t *cr, double *x, double *y) ;
*/
fun cairo_user_to_device
(
//
// x: in/out; y: in/out
//
  ctx: !xr1, x: &double >> double, y: &double >> double
) : void = "mac#%" // endfun

/*
void
cairo_user_to_device_distance
  (cairo_t *cr, double *dx, double *dy) ;
*/
fun cairo_user_to_device_distance
(
//
// dx: in/out; dy: in/out
//
  ctx: !xr1, dx: &double >> double, dy: &double >> double
) : void = "mac#%" // endfun

(* ****** ****** *)

/*
void
cairo_device_to_user
  (cairo_t *cr, double *x, double *y) ;
*/
fun cairo_device_to_user
(
//
// x: in/out; y: in/out
//
  ctx: !xr1, x: &double >> double, y: &double >> double
) : void = "mac#%" // endfun

/*
void
cairo_device_to_user_distance
  (cairo_t *cr, double *dx, double *dy) ;
*/
fun cairo_device_to_user_distance
(
//
// dx: in/out; dy: in/out
//
  ctx: !xr1, dx: &double >> double, dy: &double >> double
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [cairo-Transformations.sats] *)
