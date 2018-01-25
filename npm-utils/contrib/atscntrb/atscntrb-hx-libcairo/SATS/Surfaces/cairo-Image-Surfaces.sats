(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
int                 cairo_format_stride_for_width       (cairo_format_t format,
                                                         int width);
*/
fun cairo_format_stride_for_width
  (format: cairo_format_t, width: int): int = "mac#%"
// end of [cairo_format_stride_for_width]

(* ****** ****** *)

/*
cairo_surface_t *   cairo_image_surface_create          (cairo_format_t format,
                                                         int width,
                                                         int height);
*/
fun cairo_image_surface_create
  (format: cairo_format_t, width: int, height: int): xrsf1 = "mac#%"
// end of [cairo_image_surface_create]

(* ****** ****** *)

/*
cairo_surface_t *   cairo_image_surface_create_for_data (unsigned char *data,
                                                         cairo_format_t
							 format,
                                                         int width,
                                                         int height,
                                                         int stride);
*/

/*
unsigned char *     cairo_image_surface_get_data        (cairo_surface_t *surface);
*/

(* ****** ****** *)

/*
cairo_format_t      cairo_image_surface_get_format      (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_format (xrsf: !xrsf1): cairo_format_t = "mac#%"

/*
int                 cairo_image_surface_get_width       (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_width (xrsf: !xrsf1): int = "mac#%"

/*
int                 cairo_image_surface_get_height      (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_height (xrsf: !xrsf1): int = "mac#%"

/*
int                 cairo_image_surface_get_stride      (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_stride (xrsf: !xrsf1): int = "mac#%"

(* ****** ****** *)

(* end of [cairo-Image-Surfaces.sats] *)
