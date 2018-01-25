(*
** Start Time: March, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
cairo_surface_t*
cairo_ps_surface_create
(
const char *filename, double width_in_points, double height_in_points
) ;
*/
fun cairo_ps_surface_create
(
  filename: NSH(string)
, width_in_points: double, height_in_points: double
) : xrsf1 = "mac#%"

fun cairo_ps_surface_create_none
  (width_in_points: double, height_in_points: double): xrsf1 = "mac#%"
// end of [cairo_ps_surface_create_none]

(* ****** ****** *)

/*
cairo_surface_t*
cairo_ps_surface_create_for_stream
(
  cairo_write_func_t write_func, void *closure
, double width_in_points, double height_in_points
) ;
*/

(* ****** ****** *)
//
abst@ype cairo_ps_level_t = int
//
macdef
CAIRO_PS_LEVEL_2 = $extval (cairo_ps_level_t, "CAIRO_PS_LEVEL_2")
macdef
CAIRO_PS_LEVEL_3 = $extval (cairo_ps_level_t, "CAIRO_PS_LEVEL_3")
//        
(* ****** ****** *)

/*
void
cairo_ps_surface_restrict_to_level
(
  cairo_surface_t *surface, cairo_ps_level_t level
) ;
*/
fun cairo_ps_surface_restrict_to_level
  (surface: !xrsf1, level: cairo_ps_level_t): void = "mac#%"
//
(* ****** ****** *)

/*
void cairo_ps_get_levels
(
cairo_ps_level_t const **levels, int *num_levels
) ;
*/

(* ****** ****** *)

/*
const char*
cairo_ps_level_to_string (cairo_ps_level_t level);
*/
fun cairo_ps_level_to_string (level: cairo_ps_level_t): string = "mac#%"

(* ****** ****** *)

/*
void cairo_ps_surface_set_eps
(
  cairo_surface_t *surface, cairo_bool_t eps
) ;
*/
fun cairo_ps_surface_set_eps
  (surface: !xrsf1, eps: bool): void = "mac#%"

/*
cairo_bool_t
cairo_ps_surface_get_eps (cairo_surface_t *surface);
*/
fun cairo_ps_surface_get_eps (surface: !xrsf1): bool = "mac#%"

(* ****** ****** *)

/*
void cairo_ps_surface_set_size
(
  cairo_surface_t *surface
, double width_in_points, double height_in_points
) ;
*/
fun cairo_ps_surface_set_size
(
  surface: !xrsf1, width_in_points: double, height_in_points: double
) : void = "mac#%" // end of [cairo_ps_surface_set_size]

(* ****** ****** *)

/*
cairo_public void
cairo_ps_surface_dsc_begin_setup (cairo_surface_t *surface);
*/
fun cairo_ps_surface_dsc_begin_setup (surface: !xrsf1): void = "mac#%"

(* ****** ****** *)

/*
cairo_public void
cairo_ps_surface_dsc_begin_page_setup (cairo_surface_t *surface);
*/
fun cairo_ps_surface_dsc_begin_page_setup (surface: !xrsf1): void = "mac#%"

(* ****** ****** *)

/*
void cairo_ps_surface_dsc_comment
(
cairo_surface_t	*surface, const char *comment
) ;
*/
fun cairo_ps_surface_dsc_comment
  (surface: !xrsf1, comment: NSH(string)): void = "mac#%"
//
(* ****** ****** *)

(* end of [cairo-PostScript-Surfaces.sats] *)
