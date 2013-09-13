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

(*
** HX: this file only includes typedefs and macros; it is for internal use!
*)

(* ****** ****** *)

#ifndef CAIRO_CAIRO_HEADER_SATS
#define CAIRO_CAIRO_HEADER_SATS

(* ****** ****** *)
//
// HX: for convenience
//
typedef rgb_type =
  @{red= double, green= double, blue= double}
typedef rgb = rgb_type

typedef rgba_type =
  @{red= double, green= double, blue= double, alpha= double}
typedef rgba = rgba_type

(* ****** ****** *)
//
// API for cairo in ATS // this one is based on cairo-1.12
//
(* ****** ****** *)

macdef CAIRO_VERSION_MAJOR = $extval (int, "CAIRO_VERSION_MAJOR")
macdef CAIRO_VERSION_MINOR = $extval (int, "CAIRO_VERSION_MINOR")
macdef CAIRO_VERSION_MICRO = $extval (int, "CAIRO_VERSION_MICRO")

fun CAIRO_VERSION_ENCODE
  (major: int, minor: int, micro: int): int = "mac#CAIRO_VERSION_ENCODE"
// end of [CAIRO_VERSION_ENCODE]

(* ****** ****** *)

macdef CAIRO_HAS_IMAGE_SURFACE = $extval (int, "CAIRO_HAS_IMAGE_SURFACE")
macdef CAIRO_HAS_PDF_SURFACE = $extval (int, "CAIRO_HAS_PDF_SURFACE")
macdef CAIRO_HAS_PNG_FUNCTIONS = $extval (int, "CAIRO_HAS_PNG_FUNCTIONS")

(* ****** ****** *)

macdef CAIRO_HAS_MIME_SURFACE = $extval (int, "CAIRO_HAS_MIME_SURFACE")
macdef CAIRO_MIME_TYPE_JP2 = $extval (string, "CAIRO_MIME_TYPE_JP2")
macdef CAIRO_MIME_TYPE_JPEG = $extval (string, "CAIRO_MIME_TYPE_JPEG")
macdef CAIRO_MIME_TYPE_PNG = $extval (string, "CAIRO_MIME_TYPE_PNG")
macdef CAIRO_MIME_TYPE_URI = $extval (string, "CAIRO_MIME_TYPE_URI")
macdef CAIRO_MIME_TYPE_UNIQUE_ID = $extval (string, "CAIRO_MIME_TYPE_UNIQUE_ID")

(* ****** ****** *)
//
// [cairo_ref] is reference-counted
//
absvtype
cairo_ref (l:addr) = ptr // cairo_t*
vtypedef
cairo_ref1 = [l:addr | l > null] cairo_ref (l)
stadef xr = cairo_ref
stadef xr1 = cairo_ref1
//
(* ****** ****** *)
//
// [cairo_surface_ref] is reference-counted
//
absvtype
cairo_surface_ref (l:addr) = ptr // cairo_surface_t*
vtypedef
cairo_surface_ref1 = [l:addr | l > null] cairo_surface_ref (l)
stadef xrsf = cairo_surface_ref
stadef xrsf1 = cairo_surface_ref1
//
(* ****** ****** *)
//
// [cairo_device_ref] is reference-counted
//
absvtype
cairo_device_ref (l:addr) = ptr // cairo_device_t*
vtypedef
cairo_device_ref1 = [l:addr | l > null] cairo_device_ref (l)
stadef xrdev = cairo_device_ref
stadef xrdev1 = cairo_device_ref1
//
(* ****** ****** *)
//
// [cairo_pattern_ref] is reference-counted
//
absvtype
cairo_pattern_ref (l:addr) = ptr // cairo_pattern_t*
vtypedef
cairo_pattern_ref1 = [l:addr | l > null] cairo_pattern_ref (l)
stadef xrpat = cairo_pattern_ref
stadef xrpat1 = cairo_pattern_ref1
//
(* ****** ****** *)
//
// [cairo_region_ref] is reference-counted
//
absvtype
cairo_region_ref (l:addr) = ptr // cairo_region_t*
vtypedef
cairo_region_ref1 = [l:addr | l > null] cairo_region_ref (l)
stadef xrrgn = cairo_region_ref
stadef xrrgn1 = cairo_region_ref1
//
(* ****** ****** *)
//
// cairo_font_face_ref // cairo_font_fact_t*
//
absvtype
cairo_font_face_ref (l:addr) = ptr // cairo_font_face_t*
vtypedef
cairo_font_face_ref1 = [l:addr | l > null] cairo_font_face_ref (l)
stadef xrfontface = cairo_font_face_ref
stadef xrfontface1 = cairo_font_face_ref1
//
(* ****** ****** *)

typedef cairo_bool_t = bool

(* ****** ****** *)
//
abst@ype cairo_status_t = $extype"cairo_status_t"
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
fun eq_cairo_status_cairo_status
  (x1: cairo_status_t, x2: cairo_status_t):<> bool = "mac#%cairo_eq_int_int"
overload = with eq_cairo_status_cairo_status
//
(* ****** ****** *)
//
abst@ype cairo_content_t = $extype"cairo_content_t"
//
macdef CAIRO_CONTENT_COLOR = $extval (cairo_content_t, "CAIRO_CONTENT_COLOR")
macdef CAIRO_CONTENT_ALPHA = $extval (cairo_content_t, "CAIRO_CONTENT_ALPHA")
macdef CAIRO_CONTENT_COLOR_ALPHA = $extval (cairo_content_t, "CAIRO_CONTENT_COLOR_ALPHA")
//
(* ****** ****** *)
//
abst@ype cairo_format_t = $extype"cairo_format_t"
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
//
abst@ype cairo_operator_t = $extype"cairo_operator_t"
//
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
//
abst@ype cairo_antialias_t = $extype"cairo_antialias_t"
//
macdef CAIRO_ANTIALIAS_DEFAULT = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_DEFAULT")
macdef CAIRO_ANTIALIAS_NONE = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_NONE")
macdef CAIRO_ANTIALIAS_GRAY = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_GRAY")
macdef CAIRO_ANTIALIAS_SUBPIXEL = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_SUBPIXEL")
macdef CAIRO_ANTIALIAS_FAST = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_FAST")
macdef CAIRO_ANTIALIAS_GOOD = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_GOOD")
macdef CAIRO_ANTIALIAS_BES = $extval (cairo_antialias_t, "CAIRO_ANTIALIAS_BES")
//
(* ****** ****** *)
//
abst@ype cairo_fill_rule_t = $extype"cairo_fill_rule_t"
//
macdef CAIRO_FILL_RULE_WINDING = $extval (cairo_fill_rule_t, "CAIRO_FILL_RULE_WINDING")
macdef CAIRO_FILL_RULE_EVEN_ODD = $extval (cairo_fill_rule_t, "CAIRO_FILL_RULE_EVEN_ODD")
//
(* ****** ****** *)
//
abst@ype cairo_line_cap_t = $extype"cairo_line_cap_t"
//
macdef CAIRO_LINE_CAP_BUTT = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_BUTT")
macdef CAIRO_LINE_CAP_ROUND = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_ROUND")
macdef CAIRO_LINE_CAP_SQUARE = $extval (cairo_line_cap_t, "CAIRO_LINE_CAP_SQUARE")
//
(* ****** ****** *)
//
abst@ype cairo_line_join_t = $extype"cairo_line_join_t"
//
macdef CAIRO_LINE_JOIN_MITER = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_MITER")
macdef CAIRO_LINE_JOIN_ROUND = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_ROUND")
macdef CAIRO_LINE_JOIN_BEVEL = $extval (cairo_line_join_t, "CAIRO_LINE_JOIN_BEVEL")
//
(* ****** ****** *)
//
abst@ype cairo_font_slant_t = $extype"cairo_font_slant_t"
//
macdef CAIRO_FONT_SLANT_NORMAL = $extval (cairo_font_slant_t, "CAIRO_FONT_SLANT_NORMAL")
macdef CAIRO_FONT_SLANT_ITALIC = $extval (cairo_font_slant_t, "CAIRO_FONT_SLANT_ITALIC")
macdef CAIRO_FONT_SLANT_OBLIQUE = $extval (cairo_font_slant_t, "CAIRO_FONT_SLANT_OBLIQUE")
//
(* ****** ****** *)
//
abst@ype cairo_font_weight_t = $extype"cairo_font_weight_t"
//
macdef CAIRO_FONT_WEIGHT_NORMAL = $extval (cairo_font_weight_t, "CAIRO_FONT_WEIGHT_NORMAL")
macdef CAIRO_FONT_WEIGHT_BOLD = $extval (cairo_font_weight_t, "CAIRO_FONT_WEIGHT_BOLD")
//
(* ****** ****** *)
//
abst@ype cairo_path_data_type_t = $extype"cairo_path_data_type_t"
//
macdef CAIRO_PATH_MOVE_TO = $extval (cairo_path_data_type_t, "CAIRO_PATH_MOVE_TO")
macdef CAIRO_PATH_LINE_TO = $extval (cairo_path_data_type_t, "CAIRO_PATH_LINE_TO")
macdef CAIRO_PATH_CURVE_TO = $extval (cairo_path_data_type_t, "CAIRO_PATH_CURVE_TO")
macdef CAIRO_PATH_CLOSE_PATH = $extval (cairo_path_data_type_t, "CAIRO_PATH_CLOSE_PATH")
//
(* ****** ****** *)
//
abst@ype cairo_font_type_t = $extype"cairo_font_type_t"
//
macdef CAIRO_FONT_TYPE_TOY = $extval (cairo_font_type_t, "CAIRO_FONT_TYPE_TOY")
macdef CAIRO_FONT_TYPE_FT = $extval (cairo_font_type_t, "CAIRO_FONT_TYPE_FT")
macdef CAIRO_FONT_TYPE_WIN32 = $extval (cairo_font_type_t, "CAIRO_FONT_TYPE_WIN32")
macdef CAIRO_FONT_TYPE_QUARTZ = $extval (cairo_font_type_t, "CAIRO_FONT_TYPE_QUARTZ")
macdef CAIRO_FONT_TYPE_USER = $extval (cairo_font_type_t, "CAIRO_FONT_TYPE_USER")
//
(* ****** ****** *)

abst@ype cairo_device_type_t = $extype"cairo_device_type_t"
//
macdef CAIRO_DEVICE_TYPE_INVALID = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_INVALID")
macdef CAIRO_DEVICE_TYPE_DRM = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_DRM")
macdef CAIRO_DEVICE_TYPE_GL = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_GL")
macdef CAIRO_DEVICE_TYPE_SCRIPT = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_SCRIPT")
macdef CAIRO_DEVICE_TYPE_XCB = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_XCB")
macdef CAIRO_DEVICE_TYPE_XLIB = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_XLIB")
macdef CAIRO_DEVICE_TYPE_XML = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_XML")
macdef CAIRO_DEVICE_TYPE_COGL = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_COGL")
macdef CAIRO_DEVICE_TYPE_WIN32 = $extval(cairo_device_type_t, "CAIRO_DEVICE_TYPE_WIN32")
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
cairo_destroy_func_t = ptr(*/void*/*) -> void

(* ****** ****** *)

abst@ype
cairo_user_data_key_t = $extype"cairo_user_data_key_t"

(* ****** ****** *)

typedef
cairo_glyph_t =
$extype_struct"cairo_glyph_t" of
{
  index= ulint, x= double, y= double
} // end of [cairo_glyph_t]

(* ****** ****** *)

typedef
cairo_text_cluster_t =
$extype_struct"cairo_text_cluster_t" of
{
  num_bytes= int, num_glyphs= int
} // end of [cairo_text_cluster_t]

(* ****** ****** *)

typedef
cairo_text_extents_t =
$extype_struct"cairo_text_extents_t" of
{
  x_bearing= double
, y_bearing= double
, width= double
, height= double
, x_advance= double
, y_advance= double
} // end of [cairo_text_extents_t]

(* ****** ****** *)

typedef
cairo_font_extents_t =
$extype_struct"cairo_font_extents_t" of
{
  ascent= double
, descent= double
, height= double
, max_x_advance= double
, max_y_advance= double
} // end of [cairo_font_extents_t]

(* ****** ****** *)

abst@ype
cairo_path_data_t =
  $extype"cairo_path_data_t" // HX: union type
// end of [abst@ype]

typedef
cairo_path_t =
$extype_struct"cairo_path_t" of
{
  status= cairo_status_t
, data= ptr // HX: pointer to cairo_path_data_t[num_data]
, num_data= int
} // end of [cairo_path_t]

(* ****** ****** *)

typedef
cairo_rectangle_int_t =
$extype_struct"cairo_rectangle_int_t" of
{
  x= int, y= int, width= int, height= int
} // end of [cairo_rectangle_int_t]

(* ****** ****** *)

typedef
cairo_matrix_t =
$extype_struct"cairo_matrix_t" of
{
  xx= double, yx= double
, xy= double, yy= double
, x0= double, y0= double
} // end of [cairo_matrix_t]

(* ****** ****** *)
//
// HX: for balancing [cairo_save] and [cairo_restore]
//
absview cairo_save_v (l:addr)
//
// HX: for balancing [cairo_push_group] and [cairo_pop_group]
//
absview cairo_push_group_v (l:addr)

(* ****** ****** *)

absview cairo_device_acquire_v (l:addr, i:int)

praxi
cairo_device_acquire_v_free_none
  {l:addr}{i:int | i > 0} (pf: cairo_device_acquire_v (l, i)): void
// end of [cairo_device_acquire_v_free_none]

(* ****** ****** *)

#endif // end of [CAIRO_CAIRO_HEADER_SATS]

(* ****** ****** *)

(* end of [cairo_header.sats] *)
