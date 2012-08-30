(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
** Start Time: May, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)
//
// API for cairo in ATS // this one is based on cairo-1.12
//
(* ****** ****** *)

%{#
#include "contrib/cairo/CATS/cairo.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

macdef CAIRO_VERSION_MAJOR = $extval (int, "CAIRO_VERSION_MAJOR")
macdef CAIRO_VERSION_MINOR = $extval (int, "CAIRO_VERSION_MINOR")
macdef CAIRO_VERSION_MICRO = $extval (int, "CAIRO_VERSION_MICRO")

fun CAIRO_VERSION_ENCODE
  (major: int, minor: int, micro: int): int = "mac#CAIRO_VERSION_ENCODE"
// end of [CAIRO_VERSION_ENCODE]

(* ****** ****** *)

fun cairo_version
  ((*void*)): int = "mac#atsctrb_cairo_version"
// end of [cairo_version]
fun cairo_version_string
  ((*void*)): string = "mac#atsctrb_cairo_version_string"
// end of [cairo_version_string]

(* ****** ****** *)
//
// [cairo_bool_t] and [bool] are the same
//
(* ****** ****** *)
//
// [cairo_ref] is reference counted
//
absviewtype
cairo_ref (l:addr) // cairo_t*
viewtypedef
cairo_ref1 = [l:addr | l > null] cairo_ref (l)
stadef xr = cairo_ref
stadef xr1 = cairo_ref1

(*
cairo_public cairo_t *
cairo_reference (cairo_t *cr);
*)
fun cairo_reference
  {l:agz} (x: !xr l): xr (l)
  = "mac#atsctrb_cairo_reference"
// end of [fun]

(*
cairo_public void
cairo_destroy (cairo_t *cr);
*)
fun cairo_destroy (x: xr1): void = "mac#cairo_destroy"

(* ****** ****** *)
//
// [cairo_surface_ref] is reference counted
//
absviewtype
cairo_surface_ref (l:addr) // cairo_surface_t*
viewtypedef
cairo_surface_ref1 = [l:addr | l > null] cairo_surface_ref (l)
stadef xrsf = cairo_surface_ref
stadef xrsf1 = cairo_surface_ref1

fun
cairo_surface_reference
  {l:agz} (
  x: !xrsf l
) : xrsf (l)
  = "mac#atsctrb_cairo_surface_reference"
// end of [fun]
fun cairo_surface_destroy
  (x: xrsf1): void = "mac#cairo_surface_destroy"
// end of [cairo_surface_destroy]

(* ****** ****** *)
//
// [cairo_device_ref] is reference counted
//
absviewtype
cairo_device_ref (l:addr) // cairo_device_t*
viewtypedef
cairo_device_ref1 = [l:addr | l > null] cairo_device_ref (l)
stadef xrdev = cairo_device_ref
stadef xrdev1 = cairo_device_ref1

fun
cairo_device_reference
  {l:agz} (
  x: !xrdev l
) : xrdev (l)
  = "mac#atsctrb_cairo_device_reference"
// end of [fun]
fun cairo_device_destroy
  (x: xrdev1): void = "mac#cairo_device_destroy"
// end of [cairo_device_destroy]

(* ****** ****** *)

typedef
cairo_matrix_t = $extype_struct "cairo_matrix_t" of {
  xx= double, yx= double
, xy= double, yy= double
, x0= double, y0= double
} // end of [cairo_matrix_t]

(* ****** ****** *)
//
// [cairo_pattern_ref] is reference counted
//
absviewtype
cairo_pattern_ref (l:addr) // cairo_pattern_t*
viewtypedef
cairo_pattern_ref1 = [l:addr | l > null] cairo_pattern_ref (l)
stadef xrpat = cairo_pattern_ref
stadef xrpat1 = cairo_pattern_ref1

fun
cairo_pattern_reference
  {l:agz} (
  x: !xrpat l
) : xrpat (l)
  = "mac#atsctrb_cairo_pattern_reference"
// end of [fun]
fun cairo_pattern_destroy
  (x: xrpat1): void = "mac#cairo_pattern_destroy"
// end of [cairo_pattern_destroy]

(* ****** ****** *)

typedef
cairo_destroy_func_t = ptr(*/void*/*) -> void

(* ****** ****** *)

abst@ype
cairo_user_data_key_t = $extype"cairo_user_data_key_t"

(* ****** ****** *)
//
abst@ype
cairo_status_t = $extype"cairo_status_t"
//
macdef CAIRO_STATUS_SUCCESS = $extval (cairo_status_t, "CAIRO_STATUS_SUCCESS")
macdef CAIRO_STATUS_NO_MEMORY = $extval (cairo_status_t, "CAIRO_STATUS_NO_MEMORY")
macdef CAIRO_STATUS_INVALID_RESTORE = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_RESTORE")
macdef CAIRO_STATUS_INVALID_POP_GROUP = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_POP_GROUP")
macdef CAIRO_STATUS_NO_CURRENT_POINT = $extval (cairo_status_t, "CAIRO_STATUS_NO_CURRENT_POINT")
macdef CAIRO_STATUS_INVALID_MATRIX = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_MATRIX")
macdef CAIRO_STATUS_INVALID_STATUS = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_STATUS")
macdef CAIRO_STATUS_NULL_POINTER = $extval (cairo_status_t, "CAIRO_STATUS_NULL_POINTER")
macdef CAIRO_STATUS_INVALID_STRING = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_STRING")
macdef CAIRO_STATUS_INVALID_PATH_DATA = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_PATH_DATA")
macdef CAIRO_STATUS_READ_ERROR = $extval (cairo_status_t, "CAIRO_STATUS_READ_ERROR")
macdef CAIRO_STATUS_WRITE_ERROR = $extval (cairo_status_t, "CAIRO_STATUS_WRITE_ERROR")
macdef CAIRO_STATUS_SURFACE_FINISHED = $extval (cairo_status_t, "CAIRO_STATUS_SURFACE_FINISHED")
macdef CAIRO_STATUS_SURFACE_TYPE_MISMATCH = $extval (cairo_status_t, "CAIRO_STATUS_SURFACE_TYPE_MISMATCH")
macdef CAIRO_STATUS_PATTERN_TYPE_MISMATCH = $extval (cairo_status_t, "CAIRO_STATUS_PATTERN_TYPE_MISMATCH")
macdef CAIRO_STATUS_INVALID_CONTENT = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_CONTENT")
macdef CAIRO_STATUS_INVALID_FORMAT = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_FORMAT")
macdef CAIRO_STATUS_INVALID_VISUAL = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_VISUAL")
macdef CAIRO_STATUS_FILE_NOT_FOUND = $extval (cairo_status_t, "CAIRO_STATUS_FILE_NOT_FOUND")
macdef CAIRO_STATUS_INVALID_DASH = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_DASH")
macdef CAIRO_STATUS_INVALID_DSC_COMMENT = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_DSC_COMMENT")
macdef CAIRO_STATUS_INVALID_INDEX = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_INDEX")
macdef CAIRO_STATUS_CLIP_NOT_REPRESENTABLE = $extval (cairo_status_t, "CAIRO_STATUS_CLIP_NOT_REPRESENTABLE")
macdef CAIRO_STATUS_TEMP_FILE_ERROR = $extval (cairo_status_t, "CAIRO_STATUS_TEMP_FILE_ERROR")
macdef CAIRO_STATUS_INVALID_STRIDE = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_STRIDE")
macdef CAIRO_STATUS_FONT_TYPE_MISMATCH = $extval (cairo_status_t, "CAIRO_STATUS_FONT_TYPE_MISMATCH")
macdef CAIRO_STATUS_USER_FONT_IMMUTABLE = $extval (cairo_status_t, "CAIRO_STATUS_USER_FONT_IMMUTABLE")
macdef CAIRO_STATUS_USER_FONT_ERROR = $extval (cairo_status_t, "CAIRO_STATUS_USER_FONT_ERROR")
macdef CAIRO_STATUS_NEGATIVE_COUNT = $extval (cairo_status_t, "CAIRO_STATUS_NEGATIVE_COUNT")
macdef CAIRO_STATUS_INVALID_CLUSTERS = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_CLUSTERS")
macdef CAIRO_STATUS_INVALID_SLANT = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_SLANT")
macdef CAIRO_STATUS_INVALID_WEIGHT = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_WEIGHT")
macdef CAIRO_STATUS_INVALID_SIZE = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_SIZE")
macdef CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED = $extval (cairo_status_t, "CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED")
macdef CAIRO_STATUS_DEVICE_TYPE_MISMATCH = $extval (cairo_status_t, "CAIRO_STATUS_DEVICE_TYPE_MISMATCH")
macdef CAIRO_STATUS_DEVICE_ERROR = $extval (cairo_status_t, "CAIRO_STATUS_DEVICE_ERROR")
macdef CAIRO_STATUS_INVALID_MESH_CONSTRUCTION = $extval (cairo_status_t, "CAIRO_STATUS_INVALID_MESH_CONSTRUCTION")
macdef CAIRO_STATUS_DEVICE_FINISHED = $extval (cairo_status_t, "CAIRO_STATUS_DEVICE_FINISHED")
macdef CAIRO_STATUS_LAST_STATUS = $extval (cairo_status_t, "CAIRO_STATUS_LAST_STATUS")
//
(* ****** ****** *)
//
abst@ype
cairo_content_t = $extype"cairo_content_t"
//
macdef CAIRO_CONTENT_COLOR = $extval (cairo_content_t, "CAIRO_CONTENT_COLOR")
macdef CAIRO_CONTENT_ALPHA = $extval (cairo_content_t, "CAIRO_CONTENT_ALPHA")
macdef CAIRO_CONTENT_COLOR_ALPHA = $extval (cairo_content_t, "CAIRO_CONTENT_COLOR_ALPHA")
//
(* ****** ****** *)
//
abst@ype
cairo_format_t = $extype"cairo_format_t"
//
macdef CAIRO_FORMAT_INVALID = $extval (cairo_format_t, "CAIRO_FORMAT_INVALID")
macdef CAIRO_FORMAT_ARGB32 = $extval (cairo_format_t, "CAIRO_FORMAT_ARGB32")
macdef CAIRO_FORMAT_RGB24 = $extval (cairo_format_t, "CAIRO_FORMAT_RGB24")
macdef CAIRO_FORMAT_A8 = $extval (cairo_format_t, "CAIRO_FORMAT_A8")
macdef CAIRO_FORMAT_A1 = $extval (cairo_format_t, "CAIRO_FORMAT_A1")
macdef CAIRO_FORMAT_RGB16_565 = $extval (cairo_format_t, "CAIRO_FORMAT_RGB16_565")
macdef CAIRO_FORMAT_RGB30 = $extval (cairo_format_t, "CAIRO_FORMAT_RGB30")
//
(* ****** ****** *)

typedef
cairo_read_func_t =
 (voidptr0(*closure*), charptr0(*data*), uint(*length*)) -> cairo_status_t
// end of [cairo_wirte_func_t]
typedef
cairo_write_func_t =
 (voidptr0(*closure*), constcharptr0(*data*), uint(*length*)) -> cairo_status_t
// end of [cairo_wirte_func_t]

(* ****** ****** *)

typedef
cairo_rectangle_int_t = $extype_struct "cairo_rectangle_int_t" of {
  x= int, y= int
, width= int, height= int
} // end of [cairo_rectangle_int_t]

(* ****** ****** *)

absview cairo_save_v (l:addr)

(* ****** ****** *)
(*
** Functions for manipulating state objects
*)
(*
cairo_public cairo_t *
cairo_create (cairo_surface_t *target);
*)
fun cairo_create
  (target: !xrsf1) : xr1 = "mac#atsctrb_cairo_create"
// end of [cairo_create]

(* ****** ****** *)

(*
cairo_public unsigned int
cairo_get_reference_count (cairo_t *cr);
*)
fun cairo_get_reference_count
  (ctx: !xr1): uint = "mac#atsctrb_cairo_get_reference_count"
// end of [cairo_get_reference_count]

(* ****** ****** *)

(*
cairo_public void *
cairo_get_user_data (cairo_t			 *cr,
		     const cairo_user_data_key_t *key);
*)
fun cairo_get_user_data (
  ctx: !xr1
, key: &cairo_user_data_key_t
) : ptr(*dataptr*) = "mac#atsctrb_cairo_get_user_data"
// end of [fun]

(*
cairo_public cairo_status_t
cairo_set_user_data (cairo_t			 *cr,
		     const cairo_user_data_key_t *key,
		     void			 *user_data,
		     cairo_destroy_func_t	  destroy);
*)
fun cairo_set_user_data (
  ctx: !xr1
, key: &cairo_user_data_key_t
, data: ptr
, fdestroy: cairo_destroy_func_t
) : cairo_status_t = "mac#atsctrb_cairo_set_user_data"
// end of [fun]

(* ****** ****** *)

(*
cairo_public void
cairo_save (cairo_t *cr);
*)
fun cairo_save
  {l:agz} (
  ctx: !xr l
) : (cairo_save_v l | void)
  = "mac#atsctrb_cairo_save" // a macro
// end of [cairo_save]

(*
cairo_public void
cairo_restore (cairo_t *cr);
*)
fun cairo_restore
  {l:agz} (
  pf: cairo_save_v l | ctx: !xr l
) : void = "mac#atsctrb_cairo_restore" // a macro

(* ****** ****** *)

absview cairo_push_group_v (l:addr)

(*
cairo_public void
cairo_push_group (cairo_t *cr);
*)
fun cairo_push_group
  {l:agz} (
  ctx: !xr l
) : (
  cairo_push_group_v l | void
) = "mac#atsctrb_cairo_push_group"
// end of [cairo_push_group]

(*
cairo_public void
cairo_push_group_with_content (cairo_t *cr, cairo_content_t content);
*)
fun cairo_push_group_with_content
  {l:agz} (
  ctx: !xr l, content: cairo_content_t
) : (cairo_push_group_v l | void)
  = "mac#cairo_push_group_with_content"
// end of [cairo_push_group_with_content]

(*
cairo_public cairo_pattern_t *
cairo_pop_group (cairo_t *cr);
*)

(*
cairo_public void
cairo_pop_group_to_source (cairo_t *cr);
*)
fun cairo_pop_group_to_source
  {l:agz} (
  pf: cairo_push_group_v l | ctx: !xr l
) : void = "mac#cairo_pop_group_to_source"

(* ****** ****** *)
//
abst@ype
cairo_operator_t = $extype"cairo_operator_t"
//
macdef CAIRO_VERSION_MAJOR = $extval (int, "CAIRO_VERSION_MAJOR")
macdef CAIRO_OPERATOR_CLEAR = $extval (cairo_operator_t, "CAIRO_OPERATOR_CLEAR")
macdef CAIRO_OPERATOR_SOURCE = $extval (cairo_operator_t, "CAIRO_OPERATOR_SOURCE")
macdef CAIRO_OPERATOR_OVER = $extval (cairo_operator_t, "CAIRO_OPERATOR_OVER")
macdef CAIRO_OPERATOR_IN = $extval (cairo_operator_t, "CAIRO_OPERATOR_IN")
macdef CAIRO_OPERATOR_OUT = $extval (cairo_operator_t, "CAIRO_OPERATOR_OUT")
macdef CAIRO_OPERATOR_ATOP = $extval (cairo_operator_t, "CAIRO_OPERATOR_ATOP")
macdef CAIRO_OPERATOR_DEST = $extval (cairo_operator_t, "CAIRO_OPERATOR_DEST")
macdef CAIRO_OPERATOR_DEST_OVER = $extval (cairo_operator_t, "CAIRO_OPERATOR_DEST_OVER")
macdef CAIRO_OPERATOR_DEST_IN = $extval (cairo_operator_t, "CAIRO_OPERATOR_DEST_IN")
macdef CAIRO_OPERATOR_DEST_OUT = $extval (cairo_operator_t, "CAIRO_OPERATOR_DEST_OUT")
macdef CAIRO_OPERATOR_DEST_ATOP = $extval (cairo_operator_t, "CAIRO_OPERATOR_DEST_ATOP")
macdef CAIRO_OPERATOR_XOR = $extval (cairo_operator_t, "CAIRO_OPERATOR_XOR")
macdef CAIRO_OPERATOR_ADD = $extval (cairo_operator_t, "CAIRO_OPERATOR_ADD")
macdef CAIRO_OPERATOR_SATURATE = $extval (cairo_operator_t, "CAIRO_OPERATOR_SATURATE")
macdef CAIRO_OPERATOR_MULTIPLY = $extval (cairo_operator_t, "CAIRO_OPERATOR_MULTIPLY")
macdef CAIRO_OPERATOR_SCREEN = $extval (cairo_operator_t, "CAIRO_OPERATOR_SCREEN")
macdef CAIRO_OPERATOR_OVERLAY = $extval (cairo_operator_t, "CAIRO_OPERATOR_OVERLAY")
macdef CAIRO_OPERATOR_DARKEN = $extval (cairo_operator_t, "CAIRO_OPERATOR_DARKEN")
macdef CAIRO_OPERATOR_LIGHTEN = $extval (cairo_operator_t, "CAIRO_OPERATOR_LIGHTEN")
macdef CAIRO_OPERATOR_COLOR_DODGE = $extval (cairo_operator_t, "CAIRO_OPERATOR_COLOR_DODGE")
macdef CAIRO_OPERATOR_COLOR_BURN = $extval (cairo_operator_t, "CAIRO_OPERATOR_COLOR_BURN")
macdef CAIRO_OPERATOR_HARD_LIGHT = $extval (cairo_operator_t, "CAIRO_OPERATOR_HARD_LIGHT")
macdef CAIRO_OPERATOR_SOFT_LIGHT = $extval (cairo_operator_t, "CAIRO_OPERATOR_SOFT_LIGHT")
macdef CAIRO_OPERATOR_DIFFERENCE = $extval (cairo_operator_t, "CAIRO_OPERATOR_DIFFERENCE")
macdef CAIRO_OPERATOR_EXCLUSION = $extval (cairo_operator_t, "CAIRO_OPERATOR_EXCLUSION")
macdef CAIRO_OPERATOR_HSL_HUE = $extval (cairo_operator_t, "CAIRO_OPERATOR_HSL_HUE")
macdef CAIRO_OPERATOR_HSL_SATURATION = $extval (cairo_operator_t, "CAIRO_OPERATOR_HSL_SATURATION")
macdef CAIRO_OPERATOR_HSL_COLOR = $extval (cairo_operator_t, "CAIRO_OPERATOR_HSL_COLOR")
macdef CAIRO_OPERATOR_HSL_LUMINOSIT = $extval (cairo_operator_t, "CAIRO_OPERATOR_HSL_LUMINOSIT")
//
(* ****** ****** *)
(*
cairo_public void
cairo_set_operator (cairo_t *cr, cairo_operator_t op);
*)
fun cairo_set_operator
  (ctx: !xr1, opr: cairo_operator_t): void = "mac#cairo_set_operator"
// end of [cairo_set_operator]

(* ****** ****** *)

(*
cairo_public void
cairo_set_source (cairo_t *cr, cairo_pattern_t *source);
*)
fun cairo_set_source
  (ctx: !xr1, src: !xrpat1): void = "mac#cairo_set_source"
// end of [cairo_set_source]

(*
cairo_public void
cairo_set_source_rgb (cairo_t *cr, double red, double green, double blue);
*)
fun cairo_set_source_rgb (
  ctx: !xr1, r: double, g: double, b: double
) : void = "mac#cairo_set_source_rgb" // end of [cairo_set_source_rgb]

(*
cairo_public void
cairo_set_source_rgba (cairo_t *cr,
		       double red, double green, double blue,
		       double alpha);
*)
fun cairo_set_source_rgba (
  ctx: !xr1, r: double, g: double, b: double, alpha: double
) : void = "mac#cairo_set_source_rgba" // end of [cairo_set_source_rgba]

(*
cairo_public void
cairo_set_source_surface (cairo_t	  *cr,
			  cairo_surface_t *surface,
			  double	   x,
			  double	   y);
*)
fun cairo_set_source_surface (
  ctx: !xr1, xrsf: !xrsf1, x: double, y: double
) : void = "mac#cairo_set_source_surface" // end of [fun]

(*
cairo_public void
cairo_set_tolerance (cairo_t *cr, double tolerance);
*)
fun cairo_set_tolerance
  (ctx: !xr1, tolerance: double): void = "mac#cairo_set_tolerance"
// end of [cairo_set_tolerance]

(* ****** ****** *)
//
abst@ype
cairo_antialias_t = $extype"cairo_antialias_t"
//
macdef CAIRO_ANTIALIAS_DEFAULT = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_DEFAULT")
macdef CAIRO_ANTIALIAS_NONE = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_NONE")
macdef CAIRO_ANTIALIAS_GRAY = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_GRAY")
macdef CAIRO_ANTIALIAS_SUBPIXEL = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_SUBPIXEL")
macdef CAIRO_ANTIALIAS_FAST = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_FAST")
macdef CAIRO_ANTIALIAS_GOOD = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_GOOD")
macdef CAIRO_ANTIALIAS_BES = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_BES")
//
(*
cairo_public void
cairo_set_antialias (cairo_t *cr, cairo_antialias_t antialias);
*)
fun cairo_set_antialias
  (ctx: !xr1, aa: cairo_antialias_t): void = "mac#cairo_set_antialias"
// end of [cairo_set_antialias]

(* ****** ****** *)

abst@ype
cairo_fill_rule_t = $extype"cairo_fill_rule_t"
//
macdef CAIRO_FILL_RULE_WINDING = $extval (cairo_fill_rule_t, "CAIRO_FILL_RULE_WINDING")
macdef CAIRO_FILL_RULE_EVEN_OD = $extval (cairo_fill_rule_t, "CAIRO_FILL_RULE_EVEN_OD")
//
(*
cairo_public void
cairo_set_fill_rule (cairo_t *cr, cairo_fill_rule_t fill_rule);
*)
fun cairo_set_fill_rule
  (ctx: !xr1, fr: cairo_fill_rule_t): void = "mac#cairo_set_fill_rule"
// end of [cairo_set_fill_rule]

(* ****** ****** *)

(*
cairo_public void
cairo_set_line_width (cairo_t *cr, double width);
*)
fun cairo_set_line_width
  (ctx: !xr1, width: double): void = "mac#cairo_set_line_width"
// end of [cairo_set_line_width]

(* ****** ****** *)
abst@ype
cairo_line_cap_t = $extype"cairo_line_cap_t"
//
macdef CAIRO_LINE_CAP_BUTT = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_BUTT")
macdef CAIRO_LINE_CAP_ROUND = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_ROUND")
macdef CAIRO_LINE_CAP_SQUAR = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_SQUAR")
//
(*
cairo_public void
cairo_set_line_cap (cairo_t *cr, cairo_line_cap_t line_cap);
*)
fun cairo_set_line_cap
  (ctx: !xr1, lc: cairo_line_cap_t): void = "mac#cairo_set_line_cap"
// end of [cairo_set_line_cap]

(* ****** ****** *)

abst@ype cairo_line_join_t = $extype"cairo_line_join_t"
//
macdef CAIRO_LINE_JOIN_MITER = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_MITER")
macdef CAIRO_LINE_JOIN_ROUND = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_ROUND")
macdef CAIRO_LINE_JOIN_BEVE = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_BEVE")
//
(*
cairo_public void
cairo_set_line_join (cairo_t *cr, cairo_line_join_t line_join);
*)
fun cairo_set_line_join
  (ctx: !xr1, lj: cairo_line_join_t): void = "mac#cairo_set_line_join"
// end of [cairo_set_line_join]

(* ****** ****** *)

(*
cairo_public void
cairo_set_dash (cairo_t      *cr,
		const double *dashes,
		int	      num_dashes,
		double	      offset);
*)
fun cairo_set_dash (
  ctx: !xr1, dashes: &double, ndashes: int, offset: double
) : void = "mac#cairo_set_dash"

(*
cairo_public void
cairo_set_miter_limit (cairo_t *cr, double limit);
*)
fun cairo_set_miter_limit
  (ctx: !xr1, limit: double): void = "mac#cairo_set_miter_limit"
// end of [cairo_set_miter_limit]

(* ****** ****** *)

(*
cairo_public void
cairo_translate (cairo_t *cr, double tx, double ty);
*)
fun cairo_translate
  (ctx: !xr1, tx: double, ty: double) : void = "mac#cairo_translate"
// end of [cairo_translate]

(*
cairo_public void
cairo_scale (cairo_t *cr, double sx, double sy);
*)
fun cairo_scale
  (ctx: !xr1, sx: double, sy: double) : void = "mac#cairo_scale"
// end of [cairo_scale]

(*
cairo_public void
cairo_rotate (cairo_t *cr, double angle);
*)
fun cairo_rotate
  (ctx: !xr1, angle: double) : void = "mac#cairo_rotate"
// end of [cairo_rotate]

(* ****** ****** *)

(*
cairo_public void
cairo_transform (cairo_t	      *cr,
		 const cairo_matrix_t *matrix);
*)
fun cairo_transform (
  ctx: !xr1, matrix: &cairo_matrix_t
) : void = "mac#cairo_transform" // end of [fun]

(*
cairo_public void
cairo_set_matrix (cairo_t	       *cr,
		  const cairo_matrix_t *matrix);
*)
fun cairo_set_matrix (
  ctx: !xr1, matrix: &cairo_matrix_t
) : void = "mac#cairo_set_matrix" // end of [fun]

(*
cairo_public void
cairo_identity_matrix (cairo_t *cr);
*)
fun cairo_identity_matrix
  (ctx: !xr1): void = "mac#cairo_identity_matrix"
// end of [cairo_identity_matrix]

(* ****** ****** *)

(*
cairo_public void
cairo_user_to_device (cairo_t *cr, double *x, double *y);
*)
fun cairo_user_to_device (
//
// x: in/out; y: in/out
//
  ctx: !xr1, x: &double >> double, y: &double >> double
) : void = "mac#cairo_user_to_device" // end of [fun]

(*
cairo_public void
cairo_user_to_device_distance (cairo_t *cr, double *dx, double *dy);
*)
fun cairo_user_to_device_distance (
//
// dx: in/out; dy: in/out
//
  ctx: !xr1, dx: &double >> double, dy: &double >> double
) : void = "mac#cairo_user_to_device_distance" // end of [fun]

(*
cairo_public void
cairo_device_to_user (cairo_t *cr, double *x, double *y);
*)
fun cairo_device_to_user (
//
// x: in/out; y: in/out
//
  ctx: !xr1, x: &double >> double, y: &double >> double
) : void = "mac#cairo_device_to_user" // end of [fun]

(*
cairo_public void
cairo_device_to_user_distance (cairo_t *cr, double *dx, double *dy);
*)
fun cairo_device_to_user_distance (
//
// dx: in/out; dy: in/out
//
  ctx: !xr1, dx: &double >> double, dy: &double >> double
) : void = "mac#cairo_device_to_user_distance" // end of [fun]

(* ****** ****** *)
(*
** Path creation functions
*)
(*
cairo_public void
cairo_new_path (cairo_t *cr);
*)
fun cairo_new_path (ctx: !xr1): void = "mac#cairo_new_path"

(*
cairo_public void
cairo_move_to (cairo_t *cr, double x, double y);
*)
fun cairo_move_to (ctx: !xr1, x: double, y: double): void

(* ****** ****** *)
//
// Various query functions
//
(* ****** ****** *)

(*
cairo_public cairo_operator_t
cairo_get_operator (cairo_t *cr);
*)
fun cairo_get_operator
  (ctx: !xr1): cairo_operator_t = "mac#cairo_get_operator"
// end of [cairo_get_operator]

(*
cairo_public cairo_pattern_t *
cairo_get_source (cairo_t *cr);
*)
fun cairo_get0_source
  {l1:agz} (
  ctx: !xr l1
) : [l2:agz] vtget0 (xr l1, xrpat l2) = "mac#atsctrb_cairo_get0_source"
// end of [cairo_get0_source]

(*
cairo_public double
cairo_get_tolerance (cairo_t *cr);
*)
fun cairo_get_tolerance (ctx: !xr1): double = "mac#cairo_get_tolerance"

(*
cairo_public double
cairo_get_antialias (cairo_t *cr);
*)
fun cairo_get_antialias (ctx: !xr1): double = "mac#cairo_get_antialias"

(*
cairo_public cairo_bool_t
cairo_has_current_point (cairo_t *cr);
*)
fun cairo_has_current_point
  (ctx: !xr1): bool = "mac#cairo_has_current_point"
// end of [cairo_has_current_point]

(*
cairo_public void
cairo_get_current_point (cairo_t *cr, double *x, double *y);
*)
fun cairo_get_current_point (
  ctx: !xr1
, x: &double? >> double, y: &double? >> double
) : void = "mac#cairo_get_current_point" // end of [fun]

(*
cairo_public cairo_fill_rule_t
cairo_get_fill_rule (cairo_t *cr);
*)
fun cairo_get_fill_rule
  (ctx: !xr1): cairo_fill_rule_t = "mac#cairo_get_fill_rule"
// end of [cairo_get_fill_rule]

(*
cairo_public double
cairo_get_line_width (cairo_t *cr);
*)
fun cairo_get_line_width
  (ctx: !xr1): double = "mac#cairo_get_line_width"
// end of [cairo_get_line_width]

(*
cairo_public cairo_line_cap_t
cairo_get_line_cap (cairo_t *cr);
*)
fun cairo_get_line_cap
  (ctx: !xr1): cairo_line_cap_t = "mac#cairo_get_line_cap"
// end of [cairo_get_line_cap]

(*
cairo_public cairo_line_join_t
cairo_get_line_join (cairo_t *cr);
*)
fun cairo_get_line_join
  (ctx: !xr1): cairo_line_join_t = "mac#cairo_get_line_join"
// end of [cairo_get_line_join]

(*
cairo_public double
cairo_get_miter_limit (cairo_t *cr);
*)
fun cairo_get_miter_limit
  (ctx: !xr1): double = "mac#cairo_get_miter_limit"
// end of [cairo_get_miter_limit]

(*
cairo_public int
cairo_get_dash_count (cairo_t *cr);
*)
fun cairo_get_dash_count
  (ctx: !xr1): int = "mac#cairo_get_dash_count"
// end of [cairo_get_dash_count]

(*
cairo_public void
cairo_get_dash (cairo_t *cr, double *dashes, double *offset);
*)

(*
cairo_public void
cairo_get_matrix (cairo_t *cr, cairo_matrix_t *matrix);
*)
fun cairo_get_matrix (
  ctx: !xr1, matrix: &cairo_matrix_t? >> cairo_matrix_t
) : void = "mac#cairo_get_matrix" // end of [fun]

(*
cairo_public cairo_surface_t *
cairo_get_target (cairo_t *cr);
*)
fun cairo_get0_target
  {l1:agz} (
  ctx: !xr l1
) : [l2:agz] vtget0 (xr l1, xrsf l2) = "mac#atsctrb_cairo_get0_target"

(*
cairo_public cairo_surface_t *
cairo_get_group_target (cairo_t *cr);
*)
fun cairo_get0_group_target
  {l1:agz} (
  ctx: !xr l1
) : [l2:agz] vtget0 (xr l1, xrsf l2) = "mac#atsctrb_cairo_get0_group_target"

(* ****** ****** *)
//
// Error status queries
//
(* ****** ****** *)
(*
cairo_public cairo_status_t
cairo_status (cairo_t *cr);
*)
fun cairo_status
  (ctx: !xr1) : cairo_status_t = "mac#atsctrb_cairo_status"
// end of [cairo_status]

(*
cairo_public const char *
cairo_status_to_string (cairo_status_t status);
*)
fun cairo_status_to_string
  (ctx: !xr1) : string = "mac#atsctrb_cairo_status_to_string"
// end of [cairo_status_to_string]

(* ****** ****** *)

(* end of [cairo.sats] *)
