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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "./pats_errmsg.sats"

(* ****** ****** *)

implement{}
prerr_interror () =
{
  val () = (
    prerr "INTERROR("; prerr_FILENAME<> (); prerr ")"
  ) (* end of [val] *)
}
implement{}
prerr_interror_loc (loc) =
{
  val () = $LOC.prerr_location (loc)
  val () = (
    prerr ": INTERROR("; prerr_FILENAME<> (); prerr ")"
  ) (* end of [val] *)
} // end of [prerr_interror_loc]

(* ****** ****** *)

implement{}
prerr_error1_loc (loc) = (
  $LOC.prerr_location (loc); prerr ": error(1)"
) // end of [prerr_error1_loc]

implement{}
prerr_error2_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": error(2)"
) // end of [prerr_error2_loc]

implement{}
prerr_errmac_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": error(mac)"
) // end of [prerr_errmac_loc]

implement{}
prerr_error3_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": error(3)"
) // end of [prerr_error3_loc]

implement{}
prerr_error4_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": error(4)"
) // end of [prerr_error4_loc]

(* ****** ****** *)

implement{}
prerr_errccomp_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": error(ccomp)"
) // end of [prerr_errccomp_loc]

(* ****** ****** *)

implement{}
prerr_warning1_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": warning(1)"
) // end of [prerr_warning1_loc]

implement{}
prerr_warning2_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": warning(2)"
) // end of [prerr_warning2_loc]

implement{}
prerr_warning3_loc (loc) =
(
  $LOC.prerr_location (loc); prerr ": warning(3)"
) // end of [prerr_warning3_loc]

(* ****** ****** *)

(* end of [pats_errmsg.dats] *)
