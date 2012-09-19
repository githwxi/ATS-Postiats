(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

staload "cairo/SATS/cairo_header.sats"

(* ****** ****** *)

/*
cairo_device_t *    cairo_device_reference              (cairo_device_t *device);
*/
fun
cairo_device_reference
  {l:agz} (
  x: !xrdev l
) : xrdev (l)
  = "mac#atsctrb_cairo_device_reference"
// end of [cairo_device_reference]

/*
void                cairo_device_destroy                (cairo_device_t *device);
*/
fun cairo_device_destroy
  (x: xrdev1): void = "mac#atsctrb_cairo_device_destroy"
// end of [cairo_device_destroy]

(* ****** ****** *)

/*
cairo_status_t      cairo_device_status                 (cairo_device_t *device);
*/
fun cairo_device_status
  (x: !xrdev1): cairo_status_t = "mac#atsctrb_cairo_device_status"
// end of [cairo_device_status]

(* ****** ****** *)

/*
void                cairo_device_finish                 (cairo_device_t *device);
*/
fun cairo_device_finish
  (x: !xrdev1): void = "mac#atsctrb_cairo_device_finish"
// end of [cairo_device_finish]

/*
void                cairo_device_flush                  (cairo_device_t *device);
*/
fun cairo_device_flush
  (x: !xrdev1): void = "mac#atsctrb_cairo_device_flush"
// end of [cairo_device_flush]

(* ****** ****** *)

/*
enum                cairo_device_type_t;
cairo_device_type_t cairo_device_get_type               (cairo_device_t *device);
unsigned int        cairo_device_get_reference_count    (cairo_device_t *device);
cairo_status_t      cairo_device_set_user_data          (cairo_device_t *device,
                                                         const
							 cairo_user_data_key_t
							 *key,
                                                         void *user_data,
                                                         cairo_destroy_func_t
							 destroy);
void *              cairo_device_get_user_data          (cairo_device_t *device,
                                                         const
							 cairo_user_data_key_t
							 *key);
cairo_status_t      cairo_device_acquire                (cairo_device_t *device);
void                cairo_device_release                (cairo_device_t *device);
*/

(* ****** ****** *)

(* end of [cairo-cairo-device-t.sats] *)
