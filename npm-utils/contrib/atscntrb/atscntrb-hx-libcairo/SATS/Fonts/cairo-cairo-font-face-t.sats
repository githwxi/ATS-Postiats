(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
cairo_font_face_t * cairo_font_face_reference           (cairo_font_face_t *font_face);
*/
fun
cairo_font_face_reference
  {l:agz} (x: !xrfontface (l)) : xrfontface (l) = "mac#%"
// end of [cairo_font_face_reference]

/*
void                cairo_font_face_destroy             (cairo_font_face_t *font_face);
*/
fun cairo_font_face_destroy (x: xrdev1): void = "mac#%" // endfun

(* ****** ****** *)

/*
cairo_status_t      cairo_font_face_status              (cairo_font_face_t *font_face);
*/
fun cairo_font_face_status (x: !xrfontface1): cairo_status_t = "mac#%"

(* ****** ****** *)

/*
enum                cairo_font_type_t;
cairo_font_type_t   cairo_font_face_get_type            (cairo_font_face_t *font_face);
unsigned int        cairo_font_face_get_reference_count (cairo_font_face_t *font_face);
cairo_status_t      cairo_font_face_set_user_data       (cairo_font_face_t *font_face,
                                                         const
							 cairo_user_data_key_t
							 *key,
                                                         void *user_data,
                                                         cairo_destroy_func_t
							 destroy);
void *              cairo_font_face_get_user_data       (cairo_font_face_t *font_face,
                                                         const cairo_user_data_key_t *key);

*/

(* ****** ****** *)

(* end of [cairo-cairo-font-face-t.sats] *)
