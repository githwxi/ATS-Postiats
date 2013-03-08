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
** Start Time: March, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

%{#
#include "cairo/CATS/cairo-ps.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSHOME.contrib.cairo-ps"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

staload "./cairo.sats"

(* ****** ****** *)
/*
cairo_surface_t*
cairo_ps_surface_create
(
const char *filename, double width_in_points, double height_in_points
) ;
*/
fun cairo_ps_surface_create
(
  filename: NSH(string)
, width_in_points: double, height_in_points: double
) : xrsf1 = "mac#%"

fun cairo_ps_surface_create_none
  (width_in_points: double, height_in_points: double): xrsf1 = "mac#%"
// end of [cairo_ps_surface_create_none]

(* ****** ****** *)

/*
void cairo_ps_surface_set_eps
(
  cairo_surface_t *surface, cairo_bool_t eps
) ;
*/
fun cairo_ps_surface_set_eps
  (surface: !xrsf1, eps: bool): void = "mac#%"

/*
cairo_bool_t
cairo_ps_surface_get_eps (cairo_surface_t *surface);
*/
fun cairo_ps_surface_get_eps (surface: !xrsf1): bool = "mac#%"

(* ****** ****** *)

/*
void cairo_ps_surface_set_size
(
  cairo_surface_t *surface
, double width_in_points, double height_in_points
) ;
*/
fun cairo_ps_surface_set_size
(
  surface: !xrsf1, width_in_points: double, height_in_points: double
) : void = "mac#%" // end of [cairo_ps_surface_set_size]

(* ****** ****** *)

/*
void cairo_ps_surface_dsc_comment
(
cairo_surface_t	*surface, const char *comment
) ;
*/
fun cairo_ps_surface_dsc_comment
  (surface: !xrsf1, comment: NSH(string)): void = "mac#%"
//
(* ****** ****** *)

/*
cairo_public void
cairo_ps_surface_dsc_begin_setup (cairo_surface_t *surface);
*/
fun cairo_ps_surface_dsc_begin_setup (surface: !xrsf1): void = "mac#%"

(* ****** ****** *)

/*
cairo_public void
cairo_ps_surface_dsc_begin_page_setup (cairo_surface_t *surface);
*/
fun cairo_ps_surface_dsc_begin_page_setup (surface: !xrsf1): void = "mac#%"

(* ****** ****** *)

(* end of [cairo-ps.sats] *)
