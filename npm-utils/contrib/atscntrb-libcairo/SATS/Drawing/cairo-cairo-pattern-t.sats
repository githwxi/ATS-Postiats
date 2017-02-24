(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: September, 2012
*)

(* ****** ****** *)

#include "./../mybasis.sats"

(* ****** ****** *)

/*
void                cairo_pattern_add_color_stop_rgb    (cairo_pattern_t *pattern,
                                                         double offset,
                                                         double red,
                                                         double green,
                                                         double blue);
void                cairo_pattern_add_color_stop_rgba   (cairo_pattern_t *pattern,
                                                         double offset,
                                                         double red,
                                                         double green,
                                                         double blue,
                                                         double alpha);
cairo_status_t      cairo_pattern_get_color_stop_count  (cairo_pattern_t *pattern,
                                                         int *count);
cairo_status_t      cairo_pattern_get_color_stop_rgba   (cairo_pattern_t *pattern,
                                                         int index,
                                                         double *offset,
                                                         double *red,
                                                         double *green,
                                                         double *blue,
                                                         double *alpha);
cairo_pattern_t *   cairo_pattern_create_rgb            (double red,
                                                         double green,
                                                         double blue);
cairo_pattern_t *   cairo_pattern_create_rgba           (double red,
                                                         double green,
                                                         double blue,
                                                         double alpha);
cairo_status_t      cairo_pattern_get_rgba              (cairo_pattern_t *pattern,
                                                         double *red,
                                                         double *green,
                                                         double *blue,
                                                         double *alpha);
cairo_pattern_t *   cairo_pattern_create_for_surface    (cairo_surface_t *surface);
cairo_status_t      cairo_pattern_get_surface           (cairo_pattern_t *pattern,
                                                         cairo_surface_t **surface);
cairo_pattern_t *   cairo_pattern_create_linear         (double x0,
                                                         double y0,
                                                         double x1,
                                                         double y1);
cairo_status_t      cairo_pattern_get_linear_points     (cairo_pattern_t *pattern,
                                                         double *x0,
                                                         double *y0,
                                                         double *x1,
                                                         double *y1);
cairo_pattern_t *   cairo_pattern_create_radial         (double cx0,
                                                         double cy0,
                                                         double radius0,
                                                         double cx1,
                                                         double cy1,
                                                         double radius1);
cairo_status_t      cairo_pattern_get_radial_circles    (cairo_pattern_t *pattern,
                                                         double *x0,
                                                         double *y0,
                                                         double *r0,
                                                         double *x1,
                                                         double *y1,
                                                         double *r1);
cairo_pattern_t *   cairo_pattern_create_mesh           (void);
void                cairo_mesh_pattern_begin_patch      (cairo_pattern_t *pattern);
void                cairo_mesh_pattern_end_patch        (cairo_pattern_t *pattern);
void                cairo_mesh_pattern_move_to          (cairo_pattern_t *pattern,
                                                         double x,
                                                         double y);
void                cairo_mesh_pattern_line_to          (cairo_pattern_t *pattern,
                                                         double x,
                                                         double y);
void                cairo_mesh_pattern_curve_to         (cairo_pattern_t *pattern,
                                                         double x1,
                                                         double y1,
                                                         double x2,
                                                         double y2,
                                                         double x3,
                                                         double y3);
void                cairo_mesh_pattern_set_control_point
                                                        (cairo_pattern_t
							*pattern,
                                                         unsigned int
							 point_num,
                                                         double x,
                                                         double y);
void                cairo_mesh_pattern_set_corner_color_rgb
                                                        (cairo_pattern_t
							*pattern,
                                                         unsigned int
							 corner_num,
                                                         double red,
                                                         double green,
                                                         double blue);
void                cairo_mesh_pattern_set_corner_color_rgba
                                                        (cairo_pattern_t
							*pattern,
                                                         unsigned int
							 corner_num,
                                                         double red,
                                                         double green,
                                                         double blue,
                                                         double alpha);
cairo_status_t      cairo_mesh_pattern_get_patch_count  (cairo_pattern_t *pattern,
                                                         unsigned int
							 *count);
cairo_path_t *      cairo_mesh_pattern_get_path         (cairo_pattern_t *pattern,
                                                         unsigned int
							 patch_num);
cairo_status_t      cairo_mesh_pattern_get_control_point
                                                        (cairo_pattern_t
							*pattern,
                                                         unsigned int
							 patch_num,
                                                         unsigned int
							 point_num,
                                                         double *x,
                                                         double *y);
cairo_status_t      cairo_mesh_pattern_get_corner_color_rgba
                                                        (cairo_pattern_t
							*pattern,
                                                         unsigned int
							 patch_num,
                                                         unsigned int
							 corner_num,
                                                         double *red,
                                                         double *green,
                                                         double *blue,
                                                         double *alpha);
*/

(* ****** ****** *)

/*
cairo_pattern_t *   cairo_pattern_reference             (cairo_pattern_t *pattern);
*/
fun cairo_pattern_reference
  {l:agz} (x: !xrpat (l)): xrpat (l) = "mac#%"

/*
void                cairo_pattern_destroy               (cairo_pattern_t *pattern);
*/
fun cairo_pattern_destroy
  (x: xrpat1): void = "mac#%" // end of [cairo_pattern_destroy]
//
(* ****** ****** *)

/*
cairo_status_t      cairo_pattern_status                (cairo_pattern_t *pattern);
enum                cairo_extend_t;
void                cairo_pattern_set_extend            (cairo_pattern_t *pattern,
                                                         cairo_extend_t
							 extend);
cairo_extend_t      cairo_pattern_get_extend            (cairo_pattern_t *pattern);
enum                cairo_filter_t;
void                cairo_pattern_set_filter            (cairo_pattern_t *pattern,
                                                         cairo_filter_t
							 filter);
cairo_filter_t      cairo_pattern_get_filter            (cairo_pattern_t *pattern);
void                cairo_pattern_set_matrix            (cairo_pattern_t *pattern,
                                                         const
							 cairo_matrix_t
							 *matrix);
void                cairo_pattern_get_matrix            (cairo_pattern_t *pattern,
                                                         cairo_matrix_t *matrix);
enum                cairo_pattern_type_t;
cairo_pattern_type_t cairo_pattern_get_type             (cairo_pattern_t *pattern);
*/

(* ****** ****** *)

/*
unsigned int        cairo_pattern_get_reference_count   (cairo_pattern_t *pattern);
*/

(* ****** ****** *)

/*
cairo_status_t      cairo_pattern_set_user_data         (cairo_pattern_t *pattern,
                                                         const
							 cairo_user_data_key_t
							 *key,
                                                         void *user_data,
                                                         cairo_destroy_func_t
							 destroy);
void *              cairo_pattern_get_user_data         (cairo_pattern_t *pattern,
                                                         const
							 cairo_user_data_key_t *key);
*/

(* ****** ****** *)

(* end of [cairo-cairo-pattern-t.sats] *)
