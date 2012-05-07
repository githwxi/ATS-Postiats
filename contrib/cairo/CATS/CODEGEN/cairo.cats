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
** Time of generation: Mon May  7 16:24:07 2012
*/

(* ****** ****** *)

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)
*/

/* ****** ****** */

#ifndef ATSHOME_CONTRIB_CAIRO_CAIRO_CATS
#define ATSHOME_CONTRIB_CAIRO_CAIRO_CATS

/* ****** ****** */

#include <cairo.h>

/* ****** ****** */

#define atsctrb_CAIRO_VERSION_ENCODE CAIRO_VERSION_ENCODE

#define atsctrb_cairo_version cairo_version
#define atsctrb_cairo_version_string cairo_version_string

/* ****** ****** */

#define atsctrb_cairo_reference cairo_reference
#define atsctrb_cairo_destroy cairo_destroy

#define atsctrb_cairo_surface_reference cairo_surface_reference
#define atsctrb_cairo_surface_destroy cairo_surface_destroy

#define atsctrb_cairo_device_reference cairo_device_reference
#define atsctrb_cairo_device_destroy cairo_device_destroy

#define atsctrb_cairo_pattern_reference cairo_pattern_reference
#define atsctrb_cairo_pattern_destroy cairo_pattern_destroy

/* ****** ****** */

#define atsctrb_cairo_create cairo_create

/* ****** ****** */

#define atsctrb_cairo_status cairo_status
#define atsctrb_cairo_status_to_string cairo_status_to_string

/* ****** ****** */

#endif // ifndef ATSHOME_CONTRIB_CAIRO_CAIRO_CATS

/* ****** ****** */

/* end of [cairo.cats] */
