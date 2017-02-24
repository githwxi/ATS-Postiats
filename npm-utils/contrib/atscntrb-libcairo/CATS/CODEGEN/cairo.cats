/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
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
*) */

/* ****** ****** */

/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/cairo.atxt
** Time of generation: Sun May 11 01:44:28 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)
*/

/* ****** ****** */

#ifndef CAIRO_CAIRO_CATS
#define CAIRO_CAIRO_CATS

/* ****** ****** */

#include <cairo.h>
#ifdef CAIRO_HAS_PS_SURFACE
#include <cairo-ps.h>
#endif
#ifdef CAIRO_HAS_PDF_SURFACE
#include <cairo-pdf.h>
#endif

/* ****** ****** */

ATSinline()
atstype_bool
atscntrb_cairo_eq_int_int
(
  atstype_int x, atstype_int y
) {
  return (x==y ? atsbool_true : atsbool_false) ;
} /* end of [atscntrb_cairo_eq_int_int] */

/* ****** ****** */

#define atscntrb_CAIRO_VERSION_ENCODE CAIRO_VERSION_ENCODE

#define atscntrb_cairo_version cairo_version

ATSinline()
atstype_string
atscntrb_cairo_version_string()
{
  return (void*)(cairo_version_string()) ;
} /* endfun */

/* ****** ****** */

#define atscntrb_cairo_device_reference cairo_device_reference
#define atscntrb_cairo_device_destroy cairo_device_destroy

#define atscntrb_cairo_pattern_reference cairo_pattern_reference
#define atscntrb_cairo_pattern_destroy cairo_pattern_destroy

/* ****** ****** */

/* ****** ****** */
//
// Drawing: cairo-cairo-t
//
#define atscntrb_cairo_create cairo_create
#define atscntrb_cairo_reference cairo_reference
#define atscntrb_cairo_destroy cairo_destroy
#define atscntrb_cairo_status cairo_status
#define atscntrb_cairo_status_to_string cairo_status_to_string
#define atscntrb_cairo_save cairo_save
#define atscntrb_cairo_restore cairo_restore
#define atscntrb_cairo_get_target cairo_get_target
#define atscntrb_cairo_push_group cairo_push_group
#define atscntrb_cairo_push_group_with_content cairo_push_group_with_content
#define atscntrb_cairo_pop_group cairo_pop_group
#define atscntrb_cairo_pop_group_to_source cairo_pop_group_to_source
#define atscntrb_cairo_get_group_target cairo_get_group_target
#define atscntrb_cairo_set_source_rgb cairo_set_source_rgb
#define atscntrb_cairo_set_source_rgba cairo_set_source_rgba
#define atscntrb_cairo_set_source cairo_set_source
#define atscntrb_cairo_set_source_surface cairo_set_source_surface
#define atscntrb_cairo_get_source cairo_get_source
#define atscntrb_cairo_set_antialias cairo_set_antialias
#define atscntrb_cairo_get_antialias cairo_get_antialias
#define atscntrb_cairo_set_dash cairo_set_dash
#define atscntrb_cairo_get_dash_count cairo_get_dash_count
#define atscntrb_cairo_set_fill_rule cairo_set_fill_rule
#define atscntrb_cairo_get_fill_rule cairo_get_fill_rule
#define atscntrb_cairo_set_line_cap cairo_set_line_cap
#define atscntrb_cairo_get_line_cap cairo_get_line_cap
#define atscntrb_cairo_set_line_join cairo_set_line_join
#define atscntrb_cairo_get_line_join cairo_get_line_join
#define atscntrb_cairo_set_line_width cairo_set_line_width
#define atscntrb_cairo_get_line_width cairo_get_line_width
#define atscntrb_cairo_set_miter_limit cairo_set_miter_limit
#define atscntrb_cairo_get_miter_limit cairo_get_miter_limit
#define atscntrb_cairo_set_operator cairo_set_operator
#define atscntrb_cairo_get_operator cairo_get_operator
#define atscntrb_cairo_set_tolerance cairo_set_tolerance
#define atscntrb_cairo_get_tolerance cairo_get_tolerance
#define atscntrb_cairo_clip cairo_clip
#define atscntrb_cairo_clip_preserve cairo_clip_preserve
#define atscntrb_cairo_clip_extents cairo_clip_extents
#define atscntrb_cairo_in_clip cairo_in_clip
#define atscntrb_cairo_reset_clip cairo_reset_clip
#define atscntrb_cairo_fill cairo_fill
#define atscntrb_cairo_fill_preserve cairo_fill_preserve
#define atscntrb_cairo_fill_extents cairo_fill_extents
#define atscntrb_cairo_in_fill cairo_in_fill
#define atscntrb_cairo_mask cairo_mask
#define atscntrb_cairo_mask_surface cairo_mask_surface
#define atscntrb_cairo_paint cairo_paint
#define atscntrb_cairo_paint_with_alpha cairo_paint_with_alpha
#define atscntrb_cairo_stroke cairo_stroke
#define atscntrb_cairo_stroke_preserve cairo_stroke_preserve
#define atscntrb_cairo_stroke_extents cairo_stroke_extents
#define atscntrb_cairo_in_stroke cairo_in_stroke
#define atscntrb_cairo_copy_page cairo_copy_page
#define atscntrb_cairo_show_page cairo_show_page
#define atscntrb_cairo_get_reference_count cairo_get_reference_count
#define atscntrb_cairo_set_user_data cairo_set_user_data
#define atscntrb_cairo_get_user_data cairo_get_user_data
//
// Drawing: cairo-text
//
#define atscntrb_cairo_select_font_face cairo_select_font_face
#define atscntrb_cairo_set_font_size cairo_set_font_size
#define atscntrb_cairo_set_font_matrix cairo_set_font_matrix
#define atscntrb_cairo_get_font_matrix cairo_get_font_matrix
#define atscntrb_cairo_set_font_options cairo_set_font_options
#define atscntrb_cairo_get_font_options cairo_get_font_options
#define atscntrb_cairo_set_font_face cairo_set_font_face
#define atscntrb_cairo_get_font_face cairo_get_font_face
#define atscntrb_cairo_set_scaled_font cairo_set_scaled_font
#define atscntrb_cairo_get_scaled_font cairo_get_scaled_font
#define atscntrb_cairo_show_text cairo_show_text
#define atscntrb_cairo_show_glyphs cairo_show_glyphs
#define atscntrb_cairo_show_text_glyphs cairo_show_text_glyphs
#define atscntrb_cairo_font_extents cairo_font_extents
#define atscntrb_cairo_text_extents cairo_text_extents
#define atscntrb_cairo_glyph_extents cairo_glyph_extents
#define atscntrb_cairo_toy_font_face_create cairo_toy_font_face_create
#define atscntrb_cairo_toy_font_face_get_family cairo_toy_font_face_get_family
#define atscntrb_cairo_toy_font_face_get_slant cairo_toy_font_face_get_slant
#define atscntrb_cairo_toy_font_face_get_weight cairo_toy_font_face_get_weight
#define atscntrb_cairo_glyph_allocate cairo_glyph_allocate
#define atscntrb_cairo_glyph_free cairo_glyph_free
#define atscntrb_cairo_text_cluster_allocate cairo_text_cluster_allocate
#define atscntrb_cairo_text_cluster_free cairo_text_cluster_free
//
// Drawing: cairo-Paths
//
#define atscntrb_cairo_copy_path cairo_copy_path
#define atscntrb_cairo_copy_path_flat cairo_copy_path_flat
#define atscntrb_cairo_path_destroy cairo_path_destroy
#define atscntrb_cairo_append_path cairo_append_path
#define atscntrb_cairo_get_current_point cairo_get_current_point
#define atscntrb_cairo_has_current_point cairo_has_current_point
#define atscntrb_cairo_new_path cairo_new_path
#define atscntrb_cairo_new_sub_path cairo_new_sub_path
#define atscntrb_cairo_close_path cairo_close_path
#define atscntrb_cairo_arc cairo_arc
#define atscntrb_cairo_arc_negative cairo_arc_negative
#define atscntrb_cairo_rectangle cairo_rectangle
#define atscntrb_cairo_move_to cairo_move_to
#define atscntrb_cairo_line_to cairo_line_to
#define atscntrb_cairo_curve_to cairo_curve_to
#define atscntrb_cairo_rel_move_to cairo_rel_move_to
#define atscntrb_cairo_rel_line_to cairo_rel_line_to
#define atscntrb_cairo_rel_curve_to cairo_rel_curve_to
#define atscntrb_cairo_text_path cairo_text_path
#define atscntrb_cairo_glyph_path cairo_glyph_path
#define atscntrb_cairo_path_extents cairo_path_extents
//
// Drawing: cairo-Transformations
//
#define atscntrb_cairo_translate cairo_translate
#define atscntrb_cairo_scale cairo_scale
#define atscntrb_cairo_rotate cairo_rotate
#define atscntrb_cairo_transform cairo_transform
#define atscntrb_cairo_set_matrix cairo_set_matrix
#define atscntrb_cairo_get_matrix cairo_get_matrix
#define atscntrb_cairo_identity_matrix cairo_identity_matrix
#define atscntrb_cairo_user_to_device cairo_user_to_device
#define atscntrb_cairo_user_to_device_distance cairo_user_to_device_distance
#define atscntrb_cairo_device_to_user cairo_device_to_user
#define atscntrb_cairo_device_to_user_distance cairo_device_to_user_distance
//
/* ****** ****** */
//
// Surfaces: cairo-cairo-surface-t
//
#define atscntrb_cairo_surface_create_similar cairo_surface_create_similar
#define atscntrb_cairo_surface_create_similar_image cairo_surface_create_similar_image
#define atscntrb_cairo_surface_create_for_rectangle cairo_surface_create_for_rectangle
#define atscntrb_cairo_surface_reference cairo_surface_reference
#define atscntrb_cairo_surface_destroy cairo_surface_destroy
#define atscntrb_cairo_surface_status cairo_surface_status
#define atscntrb_cairo_surface_finish cairo_surface_finish
//
//
// Surfaces: cairo-Image-Surfaces
//
#define atscntrb_cairo_format_stride_for_width cairo_format_stride_for_width
#define atscntrb_cairo_image_surface_create cairo_image_surface_create
#define atscntrb_cairo_image_surface_create_for_data cairo_image_surface_create_for_data
#define atscntrb_cairo_image_surface_get_data cairo_image_surface_get_data
#define atscntrb_cairo_image_surface_get_format cairo_image_surface_get_format
#define atscntrb_cairo_image_surface_get_width cairo_image_surface_get_width
#define atscntrb_cairo_image_surface_get_height cairo_image_surface_get_height
#define atscntrb_cairo_image_surface_get_stride cairo_image_surface_get_stride
//
// Surfaces: cairo-PNG-Support
//
#define atscntrb_cairo_image_surface_create_from_png cairo_image_surface_create_from_png
#define atscntrb_cairo_image_surface_create_from_png_stream cairo_image_surface_create_from_png_stream
#define atscntrb_cairo_surface_write_to_png cairo_surface_write_to_png
#define atscntrb_cairo_surface_write_to_png_stream cairo_surface_write_to_png_stream
//
// Surfaces: cairo-PDF-Surfaces
//
#define atscntrb_cairo_pdf_surface_create cairo_pdf_surface_create
#define atscntrb_cairo_pdf_surface_create_for_stream cairo_pdf_surface_create_for_stream
#define atscntrb_cairo_pdf_surface_restrict_to_version cairo_pdf_surface_restrict_to_version
#define atscntrb_cairo_pdf_version_to_string cairo_pdf_version_to_string
#define atscntrb_cairo_pdf_surface_set_size cairo_pdf_surface_set_size
//
// Surfaces: cairo-PostScript-Surfaces
//
#define atscntrb_cairo_ps_surface_create cairo_ps_surface_create
#define atscntrb_cairo_ps_surface_create_for_stream cairo_ps_surface_create_for_stream
#define atscntrb_cairo_ps_surface_restrict_to_level cairo_ps_surface_restrict_to_level
#define atscntrb_cairo_ps_get_levels cairo_ps_get_levels
#define atscntrb_cairo_ps_level_to_string cairo_ps_level_to_string
#define atscntrb_cairo_ps_surface_get_eps cairo_ps_surface_get_eps
#define atscntrb_cairo_ps_surface_set_eps cairo_ps_surface_set_eps
#define atscntrb_cairo_ps_surface_set_size cairo_ps_surface_set_size
#define atscntrb_cairo_ps_surface_dsc_begin_setup cairo_ps_surface_dsc_begin_setup
#define atscntrb_cairo_ps_surface_dsc_begin_page_setup cairo_ps_surface_dsc_begin_page_setup
#define atscntrb_cairo_ps_surface_dsc_comment cairo_ps_surface_dsc_comment
//
/* ****** ****** */
//
// Utilities: cairo-cairo-matrix-t
//
#define atscntrb_cairo_matrix_init cairo_matrix_init
#define atscntrb_cairo_matrix_init_identity cairo_matrix_init_identity
#define atscntrb_cairo_matrix_init_translate cairo_matrix_init_translate
#define atscntrb_cairo_matrix_init_scale cairo_matrix_init_scale
#define atscntrb_cairo_matrix_init_rotate cairo_matrix_init_rotate
#define atscntrb_cairo_matrix_translate cairo_matrix_translate
#define atscntrb_cairo_matrix_scale cairo_matrix_scale
#define atscntrb_cairo_matrix_rotate cairo_matrix_rotate
#define atscntrb_cairo_matrix_invert cairo_matrix_invert
#define atscntrb_cairo_matrix_multiply cairo_matrix_multiply
#define atscntrb_cairo_matrix_transform_distance cairo_matrix_transform_distance
#define atscntrb_cairo_matrix_transform_point cairo_matrix_transform_point
//
/* ****** ****** */

#endif // ifndef CAIRO_CAIRO_CATS

/* ****** ****** */

/* end of [cairo.cats] */
