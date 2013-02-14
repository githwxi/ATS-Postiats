(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

/*
const char *        cairo_status_to_string              (cairo_status_t status);
*/
fun cairo_status_to_string
  (ctx: !xr1) : string = "mac#atscntrb_cairo_status_to_string"
// end of [cairo_status_to_string]

(* ****** ****** *)

/*
void                cairo_debug_reset_static_data       (void);
*/
fun cairo_debug_reset_static_data
  ((*void*)): void = "mac#atscntrb_cairo_debug_reset_static_data"
// end of [cairo_debug_reset_static_data]

(* ****** ****** *)

(* end of [cairo-Error-handling.sats] *)
