(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
typedef label = $LAB.label
staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

datatype
primval_node =
  | PMVint of (int)
  | PMVbool of (bool)
  | PMVchar of (char)
  | PMVstring of (string)
  | PMVvoid of ()
  | PMVarg of (int)
  | PMVargref of (int) // call-by-reference
  | PMVcastfn of (d2cst, primval)
  | PMVerr of ()
// end of [primval_node]

and primlab_node =
  | PMLlab of (label) | PMLind of (primvalist(*ind*))
// end of [primlab]

where
primval = '{
  primval_loc= location
, primval_type= hisexp
, primval_node= primval_node
} // end of [primval]

and primvalist = List (primval)

and primlab = '{
  primlab_loc= location
, primlab_node= primlab_node
}

(* ****** ****** *)

fun fprint_primval : fprint_type (primval)
fun fprint_primvalist : fprint_type (primvalist)

(* ****** ****** *)

fun fprint_primlab : fprint_type (primlab)

(* ****** ****** *)

(* end of [pats_ccomp.sats] *)
