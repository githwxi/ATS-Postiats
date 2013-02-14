(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../cairo_header.sats"

(* ****** ****** *)

/*
int                 cairo_format_stride_for_width       (cairo_format_t format,
                                                         int width);
*/
fun cairo_format_stride_for_width
  (format: cairo_format_t, width: int): int = "mac#atscntrb_cairo_format_stride_for_width"
// end of [cairo_format_stride_for_width]

(* ****** ****** *)

/*
cairo_surface_t *   cairo_image_surface_create          (cairo_format_t format,
                                                         int width,
                                                         int height);
*/
fun cairo_image_surface_create
  (format: cairo_format_t, width: int, height: int): xrsf1 = "mac#atscntrb_cairo_image_surface_create"
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
fun cairo_image_surface_get_format
  (xrsf: !xrsf1): cairo_format_t = "mac#atscntrb_cairo_image_surface_get_format"
// end of [cairo_image_surface_get_format]

/*
int                 cairo_image_surface_get_width       (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_width
  (xrsf: !xrsf1): int = "mac#atscntrb_cairo_image_surface_get_width"
// end of [cairo_image_surface_get_width]

/*
int                 cairo_image_surface_get_height      (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_height
  (xrsf: !xrsf1): int = "mac#atscntrb_cairo_image_surface_get_height"
// end of [cairo_image_surface_get_height]

/*
int                 cairo_image_surface_get_stride      (cairo_surface_t *surface);
*/
fun cairo_image_surface_get_stride
  (xrsf: !xrsf1): int = "mac#atscntrb_cairo_image_surface_get_stride"
// end of [cairo_image_surface_get_stride]

(* ****** ****** *)

(* end of [cairo-Image-Surfaces.sats] *)
