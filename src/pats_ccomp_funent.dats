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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: October, 2012
//
(* ****** ****** *)

staload LAB = "pats_label.sats"
staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

local

typedef
funent = '{
  funent_loc= location
, funent_lab= funlab // attached function label
, funent_level= int // =0/>0 for top/inner function
, funent_ret= tmpvar // storing the return value
, funent_body= instrlst // instructions of function body
} // end of [funent]

assume funent_type = funent
extern typedef "funent_t" = funent

in // in of [local]

(* ****** ****** *)

implement
funent_make (
  loc, fl, lev, tmp, inss
) = '{
  funent_loc= loc
, funent_lab= fl
, funent_level= lev
, funent_ret= tmp
, funent_body= inss
} // end of [funenv_make]

(* ****** ****** *)

implement
fprint_funent
  (out, fent) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
val () = prstr "FUNENT("
//
val () = prstr "level="
val () = fprint_int (out, fent.funent_level)
val () = prstr "\n"
//
val () = prstr "lab="
val () = fprint_funlab (out, fent.funent_lab)
val () = prstr "\n"
//
val () = prstr "ret="
val () = fprint_tmpvar (out, fent.funent_ret)
val () = prstr "\n"
//
val () = prstr "body=\n"
val () = fprint_instrlst (out, fent.funent_body)
//
val () = prstr ")"
in
  // nothing
end // end of [fprint_funent]

end // end of [local]

(* ****** ****** *)

implement
print_funent (fent) = fprint_funent (stdout_ref, fent)
implement
prerr_funent (fent) = fprint_funent (stderr_ref, fent)

(* ****** ****** *)

(* end of [pats_ccomp_funent.dats] *)
