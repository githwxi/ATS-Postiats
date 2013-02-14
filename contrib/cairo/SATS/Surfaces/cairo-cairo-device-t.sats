(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../cairo_header.sats"

(* ****** ****** *)

/*
cairo_device_t *    cairo_device_reference              (cairo_device_t *device);
*/
fun
cairo_device_reference
  {l:agz} (
  dev: !xrdev l
) : xrdev (l)
  = "mac#atscntrb_cairo_device_reference"
// end of [cairo_device_reference]

/*
void                cairo_device_destroy                (cairo_device_t *device);
*/
fun cairo_device_destroy
  (dev: xrdev1): void = "mac#atscntrb_cairo_device_destroy"
// end of [cairo_device_destroy]

(* ****** ****** *)

/*
cairo_status_t      cairo_device_status                 (cairo_device_t *device);
*/
fun cairo_device_status
  (dev: !xrdev1): cairo_status_t = "mac#atscntrb_cairo_device_status"
// end of [cairo_device_status]

(* ****** ****** *)

/*
void                cairo_device_finish                 (cairo_device_t *device);
*/
fun cairo_device_finish
  (dev: !xrdev1): void = "mac#atscntrb_cairo_device_finish"
// end of [cairo_device_finish]

/*
void                cairo_device_flush                  (cairo_device_t *device);
*/
fun cairo_device_flush
  (dev: !xrdev1): void = "mac#atscntrb_cairo_device_flush"
// end of [cairo_device_flush]

(* ****** ****** *)

/*
cairo_device_type_t cairo_device_get_type               (cairo_device_t *device);
*/
fun cairo_device_get_type
  (dev: !xrdev1): cairo_device_type_t = "mac#atscntrb_cairo_device_get_type"
// end of [cairo_device_get_type]

(* ****** ****** *)

/*
unsigned int        cairo_device_get_reference_count    (cairo_device_t *device);
*/
fun cairo_device_get_reference_count
  (dev: xrdev1): uint = "mac#atscntrb_cairo_device_get_reference_count"
// end of [cairo_device_get_reference_count]

(* ****** ****** *)

/*
cairo_status_t      cairo_device_set_user_data          (cairo_device_t *device,
                                                         const cairo_user_data_key_t *key,
                                                         void *user_data,
                                                         cairo_destroy_func_t destroy);
*/

/*
void *              cairo_device_get_user_data          (cairo_device_t *device,
                                                         const cairo_user_data_key_t *key);
*/

(* ****** ****** *)

/*
cairo_status_t      cairo_device_acquire                (cairo_device_t *device);
*/
fun cairo_device_acquire
  {l:agz} (
  dev: !xrdev l
) : [i:nat] (
  cairo_device_acquire_v (l, i)
| int i // HX: i=0/i>0 : succ/fail
) = "mac#atscntrb_cairo_device_acquire"
// end of [cairo_device_acquire]

/*
void                cairo_device_release                (cairo_device_t *device);
*/
fun cairo_device_release
  {l:agz} (
  pf: cairo_device_acquire_v (l, 0)
| dev: !xrdev l
) : void = "mac#atscntrb_cairo_device_release"
// end of [cairo_device_release]

(* ****** ****** *)

(* end of [cairo-cairo-device-t.sats] *)
