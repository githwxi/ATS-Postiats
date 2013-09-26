(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: July, 2012
//
(* ****** ****** *)
//
// HX-2012-10:
// Note that [funlab_type] is assumed in [pats_ccomp.sats]
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload CCOMP = "./pats_ccomp.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

implement
fprint_funlab
  (out, fl) = let
  val name = $CCOMP.funlab_get_name ($UN.cast(fl))
in
  fprint_string (out, name)
end // end of [fprint_funlab]

implement
print_funlab (fl) = fprint_funlab (stdout_ref, fl)
implement
prerr_funlab (fl) = fprint_funlab (stderr_ref, fl)

(* ****** ****** *)

(* end of [pats_histaexp_funlab.dats] *)
