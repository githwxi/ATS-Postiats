(*
** Start Time: September, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
cairo_device_t *    cairo_device_reference              (cairo_device_t *device);
*/
fun
cairo_device_reference
  {l:agz} (dev: !xrdev (l)) : xrdev (l) = "mac#%"
// end of [cairo_device_reference]

/*
void                cairo_device_destroy                (cairo_device_t *device);
*/
fun cairo_device_destroy (dev: xrdev1): void = "mac#%"

(* ****** ****** *)

/*
cairo_status_t      cairo_device_status                 (cairo_device_t *device);
*/
fun cairo_device_status (dev: !xrdev1): cairo_status_t = "mac#%"

(* ****** ****** *)

/*
void                cairo_device_finish                 (cairo_device_t *device);
*/
fun cairo_device_finish (dev: !xrdev1): void = "mac#%"

/*
void                cairo_device_flush                  (cairo_device_t *device);
*/
fun cairo_device_flush (dev: !xrdev1): void = "mac#%"

(* ****** ****** *)

/*
cairo_device_type_t cairo_device_get_type               (cairo_device_t *device);
*/
fun cairo_device_get_type
  {l:agz} (dev: !xrdev (l)) : cairo_device_type_t = "mac#%"
// end of [cairo_device_get_type]

(* ****** ****** *)

/*
unsigned int        cairo_device_get_reference_count    (cairo_device_t *device);
*/
fun
cairo_device_get_reference_count (dev: xrdev1) : uint = "mac#%"
// endfun

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
  {l:agz}
(
  dev: !xrdev (l)
) : [i:nat]
(
//
// HX: i=0/i>0 : succ/fail
//
  cairo_device_acquire_v (l, i) | int i
) = "mac#%" // endfun

/*
void                cairo_device_release                (cairo_device_t *device);
*/
fun cairo_device_release
  {l:agz} (
  pf: cairo_device_acquire_v (l, 0) | dev: !xrdev (l)
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [cairo-cairo-device-t.sats] *)
