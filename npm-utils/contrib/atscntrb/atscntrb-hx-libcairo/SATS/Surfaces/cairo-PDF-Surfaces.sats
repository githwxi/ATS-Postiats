(*
** Start Time: March, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
cairo_surface_t*
cairo_pdf_surface_create
(
  const char *filename,
  double width_in_points, double height_in_points
) ;
*/
fun cairo_pdf_surface_create
(
  filename: NSH(string)
, width_in_points: double, height_in_points: double
) : xrsf1 = "mac#%"

fun cairo_pdf_surface_create_none
  (width_in_points: double, height_in_points: double): xrsf1 = "mac#%"
// end of [cairo_pdf_surface_create_none]

(* ****** ****** *)

/*
cairo_surface_t*
cairo_pdf_surface_create_for_stream
(
  cairo_write_func_t write_func, void *closure,
  double width_in_points, double height_in_points
) ;
*/

(* ****** ****** *)
//
abst@ype cairo_pdf_version_t = int
//
macdef
CAIRO_PDF_VERSION_1_4 = $extval (cairo_pdf_version_t, "CAIRO_PDF_VERSION_1_4")
macdef
CAIRO_PDF_VERSION_1_5 = $extval (cairo_pdf_version_t, "CAIRO_PDF_VERSION_1_5")
//
(* ****** ****** *)

/*
void
cairo_pdf_surface_restrict_to_version
(
  cairo_surface_t *surface, cairo_pdf_version_t version
) ;
*/
fun cairo_pdf_surface_restrict_to_version
  (surface: !xrsf1, version: cairo_pdf_version_t): void = "mac#%"
//
(* ****** ****** *)

/*
void cairo_pdf_get_versions
(
cairo_pdf_version_t const **versions, int *num_versions
) ;
*/

(* ****** ****** *)

/*
const char*
cairo_pdf_version_to_string (cairo_pdf_version_t version);
*/

fun cairo_pdf_version_to_string
  (version: cairo_pdf_version_t): string = "mac#%"
//
(* ****** ****** *)

/*
void cairo_pdf_surface_set_size
(
  cairo_surface_t *surface, double width_in_points, double height_in_points
) ;
*/
fun cairo_pdf_surface_set_size
(
  surface: !xrsf1, width_in_points: double, height_in_points: double
) : void = "mac#%" // end of [cairo_pdf_surface_set_size]

(* ****** ****** *)

(* end of [cairo-PDF-Surfaces.sats] *)
