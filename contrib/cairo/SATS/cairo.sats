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
#include "cairo/CATS/cairo.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

staload "cairo/SATS/cairo_header.sats"

(* ****** ****** *)

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

#include "cairo/SATS/Drawing/cairo-cairo-t.sats"
#include "cairo/SATS/Drawing/cairo-Paths.sats"
#include "cairo/SATS/Drawing/cairo-cairo-pattern-t.sats"
#include "cairo/SATS/Drawing/cairo-Regions.sats"
#include "cairo/SATS/Drawing/cairo-Transformations.sats"

(* ****** ****** *)

#include "cairo/SATS/Surfaces/cairo-cairo-device-t.sats"
#include "cairo/SATS/Surfaces/cairo-cairo-surface-t.sats"

(* ****** ****** *)

#include "cairo/SATS/Utilities/cairo-cairo-matrix-t.sats"
#include "cairo/SATS/Utilities/cairo-Error-Handling.sats"
#include "cairo/SATS/Utilities/cairo-Types.sats"

(* ****** ****** *)

(* end of [cairo.sats] *)
