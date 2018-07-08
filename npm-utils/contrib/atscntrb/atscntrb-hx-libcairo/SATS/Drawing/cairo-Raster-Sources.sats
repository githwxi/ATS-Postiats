(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: September, 2012
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*

cairo_pattern_t *   cairo_pattern_create_raster_source  (void *user_data,
                                                         cairo_content_t
                                                         content,
                                                         int width,
                                                         int height);
void                cairo_raster_source_pattern_set_callback_data
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         void *data);
void *              cairo_raster_source_pattern_get_callback_data
                                                        (cairo_pattern_t
                                                         *pattern);
void                cairo_raster_source_pattern_set_acquire
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         cairo_raster_source_acquire_func_t
                                                         acquire,
                                                         cairo_raster_source_release_func_t
                                                         release);
void                cairo_raster_source_pattern_get_acquire
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         cairo_raster_source_acquire_func_t
                                                         *acquire,
                                                         cairo_raster_source_release_func_t
                                                         *release);
void                cairo_raster_source_pattern_set_snapshot
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         cairo_raster_source_snapshot_func_t
                                                         snapshot);
cairo_raster_source_snapshot_func_t
                                                         cairo_raster_source_pattern_get_snapshot
                                                        (cairo_pattern_t
                                                         *pattern);
void                cairo_raster_source_pattern_set_copy
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         cairo_raster_source_copy_func_t
                                                         copy);
cairo_raster_source_copy_func_t cairo_raster_source_pattern_get_copy
                                                        (cairo_pattern_t
                                                         *pattern);
void                cairo_raster_source_pattern_set_finish
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         cairo_raster_source_finish_func_t
                                                         finish);
cairo_raster_source_finish_func_t cairo_raster_source_pattern_get_finish
                                                        (cairo_pattern_t
                                                         *pattern);
cairo_surface_t     (*cairo_raster_source_acquire_func_t)
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         void
                                                         *callback_data,
                                                         cairo_surface_t
                                                         *target,
                                                         const
                                                         cairo_rectangle_int_t
                                                         *extents);
void                (*cairo_raster_source_release_func_t)
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         void
                                                         *callback_data,
                                                         cairo_surface_t
                                                         *surface);
cairo_status_t      (*cairo_raster_source_snapshot_func_t)
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         void
                                                         *callback_data);
cairo_status_t      (*cairo_raster_source_copy_func_t)  (cairo_pattern_t
                                                         *pattern,
                                                         void
                                                         *callback_data,
                                                         const
                                                         cairo_pattern_t
                                                         *other);
void                (*cairo_raster_source_finish_func_t)
                                                        (cairo_pattern_t
                                                         *pattern,
                                                         void *callback_data);
*/

(* ****** ****** *)

(* end of [cairo-Raster-Sources.sats] *)
