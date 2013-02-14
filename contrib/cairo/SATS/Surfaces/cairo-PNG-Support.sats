(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../cairo_header.sats"

(* ****** ****** *)

/*
cairo_surface_t *   cairo_image_surface_create_from_png (const char *filename);
*/
fun cairo_image_surface_create_from_png
  (filename: string): xrsf1 = "mac#atscntrb_cairo_image_surface_create_from_png"
// end of [cairo_image_surface_create_from_png]

(* ****** ****** *)

/*

cairo_status_t      (*cairo_read_func_t)                (void *closure,
                                                         unsigned char *data,
                                                         unsigned int length);
cairo_surface_t *   cairo_image_surface_create_from_png_stream
                                                        (cairo_read_func_t read_func,
                                                         void *closure);
*/

(* ****** ****** *)

/*
cairo_status_t      cairo_surface_write_to_png          (cairo_surface_t *surface,
                                                         const char *filename);
*/
fun cairo_surface_write_to_png
  (xrsf: !xrsf1, filename: string): cairo_status_t = "mac#atscntrb_cairo_surface_write_to_png"
// end of [cairo_surface_write_to_png]

(* ****** ****** *)

/*
cairo_status_t      (*cairo_write_func_t)               (void *closure,
                                                         const unsigned
							 char *data,
                                                         unsigned int
							 length);
cairo_status_t      cairo_surface_write_to_png_stream   (cairo_surface_t *surface,
                                                         cairo_write_func_t write_func,
                                                         void *closure);
*/

(* ****** ****** *)

(* end of [cairo-PNG-Support.sats] *)
