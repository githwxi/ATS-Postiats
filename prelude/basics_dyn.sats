(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)
//
dataprop unit_p = unit_p of ()
dataview unit_v = unit_v of ()
//
dataview
option_view_bool_view
  (a:view+, bool) = Some_v (a, true) of a | None_v (a, false)
// end of [option_view_bool_view]
stadef option_v = option_view_bool_view
// viewdef optvar_v (a:viewt@ype, l:addr) = option_v (a @ l, l > null)
//
(* ****** ****** *)

dataviewtype // viewt@ype+: covariant
option_viewt0ype_bool_viewtype (a:viewt@ype+, bool) =
  | None_vt (a, false) | Some_vt (a, true) of a
// end of [option_viewt0ype_bool_viewtype]
stadef option_vt = option_viewt0ype_bool_viewtype
viewtypedef Option_vt (a:viewt@ype) = [b:bool] option_vt (a, b)

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_dyn.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_dyn.sats] *)
