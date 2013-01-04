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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

typedef
funent = '{
  funent_loc= location
, funent_lab= funlab // attached function label
, funent_level= int // =0/>0 for top/inner function
//
, funent_imparg= s2varlst
, funent_tmparg= s2explstlst
//
, funent_tmpret= tmpvar // storing the return value
, funent_instrlst= instrlst // instructions of function body
, funent_tmpvarlst= tmpvarlst // tmpvars in function body
} // end of [funent]

assume funent_type = funent
extern typedef "funent_t" = funent

in // in of [local]

implement
funent_make (
  loc, fl, lev
, imparg, tmparg, tmpret, inss
) = let
  val tmps = instrlst_get_tmpvarset (inss)
  val tmps = tmpvarset_vt_add (tmps, tmpret)
  val tmplst = tmpvarset_vt_listize_free (tmps)
  val tmplst = list_of_list_vt (tmplst)
in '{
  funent_loc= loc
, funent_lab= fl
, funent_level= lev
, funent_imparg= imparg
, funent_tmparg= tmparg
, funent_tmpret= tmpret
, funent_instrlst= inss
, funent_tmpvarlst= tmplst
} end // end of [funenv_make]

(* ****** ****** *)

implement
funent_get_loc (fent) = fent.funent_loc

implement
funent_get_lab (fent) = fent.funent_lab

implement
funent_get_imparg (fent) = fent.funent_imparg

implement
funent_get_tmparg (fent) = fent.funent_tmparg

implement
funent_get_tmpret (fent) = fent.funent_tmpret

implement
funent_get_instrlst (fent) = fent.funent_instrlst

implement
funent_get_tmpvarlst (fent) = fent.funent_tmpvarlst

(* ****** ****** *)

implement
fprint_funent
  (out, fent) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
val () = prstr "FUNENT(\n"
//
val () = prstr "level="
val () = fprint_int (out, fent.funent_level)
val () = prstr "\n"
//
val () = prstr "lab="
val () = fprint_funlab (out, fent.funent_lab)
val () = prstr "\n"
//
val () = prstr "imparg="
val () = fprint_s2varlst (out, fent.funent_imparg)
val () = prstr "\n"
//
val () = prstr "tmparg="
val tmparg = fent.funent_tmparg
val () = $UT.fprintlst (out, tmparg, "; ", fprint_s2explst)
val () = prstr "\n"
//
val () = prstr "ret="
val () = fprint_tmpvar (out, fent.funent_tmpret)
val () = prstr "\n"
//
val () = prstr "body=\n"
val () = fprint_instrlst (out, fent.funent_instrlst)
//
val () = prstr ")"
in
  // nothing
end // end of [fprint_funent]

end // end of [local]

(* ****** ****** *)

implement
funent_is_tmplt (fent) = let
  val tmparg = funent_get_tmparg (fent)
in
//
case+ tmparg of list_cons _ => true | list_nil () => false
//
end // end of [funent_is_tmplst]

(* ****** ****** *)

implement
print_funent (fent) = fprint_funent (stdout_ref, fent)
implement
prerr_funent (fent) = fprint_funent (stderr_ref, fent)

(* ****** ****** *)

(* end of [pats_ccomp_funent.dats] *)
